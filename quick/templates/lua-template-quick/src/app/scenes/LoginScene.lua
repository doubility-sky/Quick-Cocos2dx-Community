local LoginScene = class("LoginScene", function()
    return display.newScene("LoginScene")
end)

function LoginScene:ctor()    
    require("app.layers.BackgroundLayer").new()
    :addTo(self)
end

function LoginScene:onEnter()
end

function LoginScene:onExit()
end

return LoginScene