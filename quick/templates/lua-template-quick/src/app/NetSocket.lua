local net = require("framework.cc.net.init")
require("framework.protobuf")
local crypt = require("crypt")

local NetSocket = {}

local msgprotocol = require "app.protocol.msgprotocol"

protobuf.register_file("/Users/winsure/Card/src/app/protocol/game.pb") 
protobuf.register_file("/Users/Winsure/Card/src/app/protocol/user.pb")  
    
local msgbuff = ""
local msgsocket
local msgstate
local msgindex = 1

local loginbuff = ""
local loginsocket
local loginstate 
local loginname
local loginpass
local loginchallenge
local loginkey
local loginsecret
local loginuid = 0

local delegateobject

function NetSocket.init(delegate)
    delegateobject = delegate
    
	local time = net.SocketTCP.getTime()

    loginsocket = net.SocketTCP.new()
	loginsocket:setName("LoginTcp")
	loginsocket:setTickTime(1)
	loginsocket:setReconnTime(6)
	loginsocket:setConnFailTime(4)

	loginsocket:addEventListener(net.SocketTCP.EVENT_DATA, NetSocket.login_receive)
	-- loginsocket:addEventListener(net.SocketTCP.EVENT_CLOSE, NetSocket.login_close)
	-- loginsocket:addEventListener(net.SocketTCP.EVENT_CLOSED, NetSocket.login_closed)
	loginsocket:addEventListener(net.SocketTCP.EVENT_CONNECTED, NetSocket.login_connected)
	loginsocket:addEventListener(net.SocketTCP.EVENT_CONNECT_FAILURE, NetSocket.login_error)
    
	msgsocket = net.SocketTCP.new()
	msgsocket:setName("GateTcp")
	msgsocket:setTickTime(1)
	msgsocket:setReconnTime(6)
	msgsocket:setConnFailTime(4)

	msgsocket:addEventListener(net.SocketTCP.EVENT_DATA, NetSocket.gate_receive)
	-- msgsocket:addEventListener(net.SocketTCP.EVENT_CLOSE, NetSocket.gate_close)
	-- msgsocket:addEventListener(net.SocketTCP.EVENT_CLOSED, NetSocket.gate_closed)
	msgsocket:addEventListener(net.SocketTCP.EVENT_CONNECTED, NetSocket.gate_connected)
	msgsocket:addEventListener(net.SocketTCP.EVENT_CONNECT_FAILURE, NetSocket.gate_error)
end

function NetSocket.login(ip, port, name, password)
    loginstate = 0
    loginname = name
    loginpass = password
    loginsocket:connect(ip, port)
    print("login:" .. ip .. "," .. port)
end

function NetSocket.connect(ip, port)
    msgstate = 0
    msgsocket:connect(ip, port)
end

function NetSocket.login_error(event)
    print("login connect error")
end

function NetSocket.login_connected(event)
    loginstate = 1
    print("login connect success")
end

function NetSocket.login_receive(event)
    loginbuff = loginbuff .. event.data
    local len = #loginbuff
    while (len > 2)
    do
        local size = 256*loginbuff:byte(1) + loginbuff:byte(2)
        if (len < 2 + size) then
            return
        end
        local id, data = NetSocket.recv_data(loginbuff:sub(3, 2+size))
        if loginstate == 1 then
            loginstate = 2
            loginchallenge = data
            loginkey = crypt.randomkey()
            NetSocket.send_data(id, crypt.dhexchange(loginkey))
        elseif loginstate == 2 then
            loginstate = 3
            loginsecret = crypt.dhsecret(data, loginkey)
            NetSocket.send_data(id, crypt.hmac64(loginchallenge, loginsecret))
        elseif loginstate == 3 then
            loginstate = 4
            NetSocket.send_data(id, crypt.desencode(loginsecret, string.format("%s@%s", crypt.base64encode(loginname), crypt.base64encode(loginpass))))
        elseif loginstate == 4 then
            loginsocket:close()
            loginstate = 5
            if id == 4 then
                delegateobject:login_fail(data)
            elseif id == 5 then
                loginuid = tonumber(data)
                delegateobject:login_success()
            end
            print("login end:" .. id)
            return
        end
        print("login state:" .. loginstate)
        loginbuff = loginbuff.sub(3+size, #loginbuff)
        len = #loginbuff
    end
end

function NetSocket.recv_data(data)
    local id = 256*data:byte(1) + data:byte(2)
    return id, data:sub(3, #data)
end

function NetSocket.send_data(id, data)
    local len = 2 + #data
    local buff = string.char(math.floor(len/256)%256) .. string.char(len%256) .. string.char(math.floor(id/256)%256) .. string.char(id%256) .. data
	loginsocket:send(buff)
end

function NetSocket.gate_connected(event)
    msgstate = 1
    local handshake = loginuid .. ":" .. msgindex
    msgindex = msgindex+ 1
    local hmac = crypt.hmac_hash(loginsecret, handshake)
    NetSocket.send_connect(0, handshake .. ":" .. crypt.base64encode(hmac) .. ":" .. crypt.base64encode(loginkey))
end

function NetSocket.send_connect(id, data)
    local len = 2 + #data
    local buff = string.char(math.floor(len/256)%256) .. string.char(len%256) .. string.char(math.floor(id/256)%256) .. string.char(id%256) .. data
	msgsocket:send(buff)
end

function NetSocket.gate_receive(event)
    msgbuff = msgbuff .. event.data
    local len = #msgbuff
    while (len > 2)
    do
        local size = 256*msgbuff:byte(1) + msgbuff:byte(2)
        if (len < 2 + size) then
            return
        end
        if msgstate == 1 then
            msgstate = 2
            local id, data = NetSocket.recv_data(msgbuff:sub(3, 2+size))
            print("connect end:" .. id)
            if id == 0 then
                delegateobject:connect_success()
            else 
                delegateobject:connect_fail(data)
                msgsocket:close()
                return
            end
        else 
            local name, msg = NetSocket.recv_pack(msgbuff:sub(3, 2+size))
            delegateobject:receive_msg(name, msg)
        end
        msgbuff = msgbuff.sub(3+size, #msgbuff)
        len = #msgbuff
    end
end

function NetSocket.send_pack(name, msg)
    local id = msgprotocol[name]
    local data = protobuf.encode(name, msg)

    local len = 2 + #data
    data = string.char(math.floor(len/256)%256) .. string.char(len%256) .. string.char(math.floor(id/256)%256) .. string.char(id%256) .. data
	msgsocket:send(data)
end

function NetSocket.recv_pack(data)

    local id = 256*data:byte(1) + data:byte(2)
    local name = msgprotocol[id]
    local msg = protobuf.decode(name, data:sub(3, #data))
    return name, msg
end

return NetSocket