local GameMenuLayer = class("GameMenuLayer",function()
    return display.newSprite()
end)

function GameMenuLayer:ctor()
    local menu = display.newSprite("image/menu_background.png")
    :pos(display.cx, display.top + 20)
    :addTo(self)
    
    local size = menu:getContentSize()
    
    cc.ui.UIPushButton.new("image/menu_exit.png")
    :onButtonClicked(function()
            --GameApp:enterScene("MainScene", nil, "SLIDEINT", 0.25)
            cc.Director:getInstance():popScene()
        end)
    :pos(size.width/2 - 225, size.height/2 + 20)
    :addTo(menu)
    
    cc.ui.UIPushButton.new("image/menu_change.png")
    :onButtonClicked(function()
        end)
    :pos(size.width/2 - 75, size.height/2 + 20)
    :addTo(menu)
    
    cc.ui.UIPushButton.new("image/menu_set.png")
    :onButtonClicked(function()
        end)
    :pos(size.width/2 + 75, size.height/2 + 20)
    :addTo(menu)
    
    cc.ui.UIPushButton.new("image/menu_chat.png")
    :onButtonClicked(function()
        end)
    :pos(size.width/2 + 225, size.height/2 + 20)
    :addTo(menu)
    
    local show = false
    cc.ui.UIPushButton.new("image/button_menu.png")
    :onButtonClicked(function()
            if show then
                show = false
                local move = cc.MoveBy:create(0.3, cc.p(0, 78))
                local action = cc.Sequence:create(move)
                transition.execute(menu, action)
            else 
                show = true
                local move = cc.MoveBy:create(0.3, cc.p(0, -78))
                local action = cc.Sequence:create(move)
                transition.execute(menu, action)
            end
        end)
    :pos(size.width/2, size.height/2 - 95)
    :addTo(menu)
end

return GameMenuLayer