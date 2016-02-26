
local GameScene = class("GameScene", function()
    return display.newScene("GameScene")
end)

function GameScene:ctor()    
    require("app.layers.GameTableLayer").new()
    :addTo(self)
    require("app.layers.GameMenuLayer").new()
    :addTo(self)
end

function GameScene:onEnter()
end

function GameScene:onExit()
end

return GameScene