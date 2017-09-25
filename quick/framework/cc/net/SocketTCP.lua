--[[
For quick-cocos2d-x
SocketTCP lua
@author zrong (zengrong.net)
Creation: 2013-11-12
Last Modification: 2013-12-05
@see http://cn.quick-x.com/?topic=quickkydsocketfzl

RS-team 2016-02 ~ 2017-09 update:
	1. Connect support ipv6
	2. Clean up code, rename variables and functions
	3. Ticker improved; Remove reconnect timer
	4. Remove EVENT_CLOSE; EVENT_CONNECT_FAILURE just for connecting
]]

local socket = require "socket"
local scheduler = require("framework.scheduler")

local CONNECT_TIMEOUT = 3	-- socket failure timeout

local STATUS_CLOSED = "closed"
local STATUS_NOT_CONNECTED = "Socket is not connected"
local STATUS_ALREADY_CONNECTED = "already connected"
local STATUS_ALREADY_IN_PROGRESS = "Operation already in progress"
local STATUS_TIMEOUT = "timeout"
local STATUS_REFUSED = "connection refused"
local STATUS_INVALID_ARGUMENT = "Invalid argument"


local SocketTCP = class("SocketTCP")

SocketTCP.EVENT_DATA = "SOCKET_TCP_DATA"
SocketTCP.EVENT_CLOSE = "just for compatibility, remove me later!!!"
SocketTCP.EVENT_CLOSED = "SOCKET_TCP_CLOSED"
SocketTCP.EVENT_CONNECTED = "SOCKET_TCP_CONNECTED"
SocketTCP.EVENT_CONNECT_FAILURE = "SOCKET_TCP_CONNECT_FAILURE"

SocketTCP._VERSION = socket._VERSION
SocketTCP._DEBUG = socket._DEBUG


function SocketTCP.getTime()
	return socket.gettime()
end


function SocketTCP:ctor(host, port)
	assert(host and port, "Host and port are necessary!")
	cc(self):addComponent("components.behavior.EventProtocol"):exportMethods()
	self.tcp = nil
	self.host = host
	self.port = port
	self.name = 'SocketTCP'
	self.connected = false
	self.connector = nil  -- timer for connect timeout
	self.ticker = nil  -- timer for data receive
end


function SocketTCP:setName(name)
	self.name = name
	return self
end


function SocketTCP:connect()
	printf("%s.connect(%s, %d)", self.name, self.host, self.port)
	local addrs, err = socket.dns.getaddrinfo(self.host)
	if not addrs or #addrs == 0 then
		print("getaddrinfo error:", tostring(err))
		self:dispatchEvent({name=SocketTCP.EVENT_CONNECT_FAILURE})
		return
	end

	local function set_tcp(family)
		print("set connect family to:", family)
		if family == "inet" then
			self.tcp = socket.tcp()
		else
			self.tcp = socket.tcp6()
		end
		self.tcp:settimeout(0)
	end
	local idx, timecnt = 1, 0
	set_tcp(addrs[idx].family)

	local function check(dt)
		local result, status = self.tcp:connect(self.host, self.port)
		if status ~= STATUS_ALREADY_IN_PROGRESS then
			printf("connect result:%s status:%s", tostring(result), tostring(status))
		end
		if result == 1 or status == STATUS_ALREADY_CONNECTED then
			printf("%s._onConnectd", self.name)
			self.connected = true
			self:dispatchEvent({name=SocketTCP.EVENT_CONNECTED})
			if self.connector then 
				scheduler.unscheduleGlobal(self.connector)
			end
			self.ticker = scheduler.scheduleUpdateGlobal(handler(self, self._tick))
			return
		end
		local failed = (status == STATUS_REFUSED or status == STATUS_INVALID_ARGUMENT)
		timecnt = timecnt + dt
		if timecnt >= CONNECT_TIMEOUT or failed then
			idx, timecnt = idx+1, 0
			if idx > #addrs then
				printf("%s._connectFailure", self.name)
				if self.connector then 
					scheduler.unscheduleGlobal(self.connector)
				end
				self:dispatchEvent({name=SocketTCP.EVENT_CONNECT_FAILURE})
			else
				self.tcp:close()
				set_tcp(addrs[idx].family)
			end
		end
	end
	self.connector = scheduler.scheduleUpdateGlobal(check)
end


function SocketTCP:send(data)
	assert(self.connected, self.name .. " is not connected.")
	self.tcp:send(data)
end


function SocketTCP:disconnect()
	printf("%s.close", self.name)
	self.tcp:close()
end


function SocketTCP:_tick(dt)
	local body, status, partial = self.tcp:receive("*a")  -- read the package body
	if status == STATUS_CLOSED or status == STATUS_NOT_CONNECTED then
		printf("%s._onDisConnect status:%s", self.name, status)
		self.tcp:close()
		self.connected = false
		if self.ticker then
			scheduler.unscheduleGlobal(self.ticker)
		end
		self:dispatchEvent({name=SocketTCP.EVENT_CLOSED})
		return
	end
	if (body and string.len(body) == 0) or (partial and string.len(partial) == 0) then
		return 
	end
	if body and partial then 
		body = body .. partial 
	end
	self:dispatchEvent({
		name=SocketTCP.EVENT_DATA, data=(partial or body), partial=partial, body=body
	})
end


return SocketTCP

