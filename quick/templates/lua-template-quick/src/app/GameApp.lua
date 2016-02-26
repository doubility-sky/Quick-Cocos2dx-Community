require("config")
require("cocos.init")
require("framework.init")

local GameApp = class("GameApp", cc.mvc.AppBase)


function GameApp:ctor()
    GameApp.super.ctor(self)
end

function GameApp:run()
    cc.FileUtils:getInstance():addSearchPath("res/")
    --cc.Director:getInstance():setContentScaleFactor(display.widthInPixels / display.width)
    self:enterScene("MainScene")
end

return GameApp
