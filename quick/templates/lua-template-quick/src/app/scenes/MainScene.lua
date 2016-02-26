local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

function MainScene:ctor()
    require("app.layers.BackgroundLayer").new()
    :addTo(self)
            
    self.typeList = require("app.layers.TypeListLayer").new()
    self.typeList:addTo(self)
    self.typeList:setScene(self)
    
    self.topMenu = require("app.layers.TopMenuLayer").new()
    self.topMenu:addTo(self)
    self.topMenu:setScene(self)
    
    self.bottomMenu = require("app.layers.BottomMenuLayer").new()
    self.bottomMenu:addTo(self)
    self.bottomMenu:setScene(self)
    
    -- self.net = require("app.NetSocket")
    -- self.net.init(self)
    -- self.net.login("192.168.0.101", 6001, "test", "test")
end

function MainScene:onEnter()
end

function MainScene:onExit()
end

function MainScene:onGame(item)
    cc.Director:getInstance():pushScene(require("app.scenes.GameScene").new())
    --GameApp:enterScene("GameScene", nil, "SLIDEINT", 0.25)
end

function MainScene:onType(type)
    self.topMenu:setType(type)
    self.bottomMenu:setType(type)
    
    if type == "" then
        self:showMain()
    elseif type == "classic" then
        self:showClassic()
    elseif type == "hundred" then
    elseif type == "recreation" then
    end
end

function MainScene:showClassic()
    self.typeList:hide()
    local function TimerUpdata()
        if self.classic == nil then
            self.classic = require("app.layers.ClassicItemLayer").new()
            self.classic:addTo(self)
            self.classic:setScene(self)
        end 
        self.classic:show()
    end
    local scheduler = require("framework.scheduler")
    scheduler.performWithDelayGlobal(TimerUpdata, 0.25)
end

function MainScene:showMain()
    if self.classic ~= nil then
        self.classic:hide()
    end
    local function TimerUpdata()
        self.typeList:show()
    end
    local scheduler = require("framework.scheduler")
    scheduler.performWithDelayGlobal(TimerUpdata, 0.25)
end

function MainScene:login_success()
    -- self.net.connect("192.168.0.101", 7001)
end

function MainScene:login_fail(error)
end

function MainScene:connect_success()
    self:onGame(nil)
end

function MainScene:connect_fail(error)
end

function MainScene:receive_msg(name, msg)
end

return MainScene
