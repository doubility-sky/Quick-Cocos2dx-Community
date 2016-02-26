local BottomMenuLayer = class("BottomMenuLayer",function()
    return display.newSprite()
end)

function BottomMenuLayer:ctor()
    self.menu = display.newSprite("image/bottom_menu.png")
    :pos(display.cx, display.bottom + 45)
    :addTo(self)
    
    local size = self.menu:getContentSize()
    
    cc.ui.UIPushButton.new({ normal = "image/button_activity_1.png", pressed = "image/button_activity_2.png" })
    :onButtonClicked(function()
        end)
    :pos(size.width / 2 - 300, size.height / 2)
    :addTo(self.menu)
    
    cc.ui.UIPushButton.new({ normal = "image/button_rank_1.png", pressed = "image/button_rank_2.png" })
    :onButtonClicked(function()
        end)
    :pos(size.width / 2 - 180, size.height / 2)
    :addTo(self.menu)
    
    cc.ui.UIPushButton.new({ normal = "image/button_save_1.png", pressed = "image/button_save_2.png" })
    :onButtonClicked(function()
        end)
    :pos(size.width / 2 - 60, size.height / 2)
    :addTo(self.menu)
    
    cc.ui.UIPushButton.new({ normal = "image/button_exchange_1.png", pressed = "image/button_exchange_2.png" })
    :onButtonClicked(function()
        end)
    :pos(size.width / 2 + 60, size.height / 2)
    :addTo(self.menu)
    
    
    cc.ui.UIPushButton.new({ normal = "image/button_shop_1.png", pressed = "image/button_shop_2.png" })
    :onButtonClicked(function()
        end)
    :pos(size.width / 2 + 180, size.height / 2)
    :addTo(self.menu)
    
    
    cc.ui.UIPushButton.new({ normal = "image/button_more_1.png", pressed = "image/button_more_2.png" })
    :onButtonClicked(function()
        end)
    :pos(size.width / 2 + 300, size.height / 2)
    :addTo(self.menu)
end

function BottomMenuLayer:setScene(scene)
    self.scene = scene
end

function BottomMenuLayer:setType(type)
    local function changeMenu()
        if type == "" then
            self:showMain()
        elseif type == "classic" then
            self:showClassic()
        elseif type == "hundred" then
            self:showHundred()
        elseif type == "recreation" then
            self:showRecreation()
        end
    end

    local action = cc.Sequence:create( cc.MoveBy:create(0.25, cc.p(0, -100 * display.contentScaleFactor)), cc.CallFunc:create(changeMenu), cc.MoveBy:create(0.25, cc.p(0, 100 * display.contentScaleFactor)))
    transition.execute(self.menu, action)
end

function BottomMenuLayer:showMain()
end

function BottomMenuLayer:showClassic()
end

function BottomMenuLayer:showHundred()
end

function BottomMenuLayer:showRecreation()
end

return BottomMenuLayer