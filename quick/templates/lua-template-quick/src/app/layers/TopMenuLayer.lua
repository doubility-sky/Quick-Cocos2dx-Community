local TopMenuLayer = class("TopMenuLayer",function()
    return display.newSprite()
end)

function TopMenuLayer:ctor()
    self.menu = display.newSprite("image/title_background.png")
    :pos(display.cx, display.top - 36)
    :addTo(self)
    
    local size = self.menu:getContentSize()
    
    self.titleDouniu = display.newSprite("image/title_douniu.png")
    :pos(size.width / 2, size.height / 2)
    :addTo(self.menu)
    
    self.back = cc.ui.UIPushButton.new({ normal = "image/button_back_1.png", pressed = "image/button_back_2.png" })
    :onButtonClicked(function()
            self.scene:onType("")
        end)
    :hide()
    :pos(size.width / 2 -  display.cx + 60, size.height + (40 - 100))
    :addTo(self.menu)
    
    cc.ui.UIPushButton.new({ normal = "image/button_notice_1.png", pressed = "image/button_notice_2.png" })
    :onButtonClicked(function()
        end)
    :pos(size.width / 2 +  display.cx - 160, size.height + (40 - 100))
    :addTo(self.menu)
    
    cc.ui.UIPushButton.new({ normal = "image/button_set_1.png", pressed = "image/button_set_2.png" })
    :onButtonClicked(function()
        end)
    :pos( size.width / 2 +  display.cx - 60, size.height + (40 - 100))
    :addTo(self.menu)
end

function TopMenuLayer:setScene(scene)
    self.scene = scene
end

function TopMenuLayer:setType(type)
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

    local action = cc.Sequence:create( cc.MoveBy:create(0.25, cc.p(0, 100)), cc.CallFunc:create(changeMenu), cc.MoveBy:create(0.25, cc.p(0, -100)))
    transition.execute(self.menu, action)
end

function TopMenuLayer:showMain()
    if self.titleClassic ~= nil then
        self.titleClassic:hide()
    end
    self.back:hide()
    self.titleDouniu:show()
end

function TopMenuLayer:showClassic()
    self.titleDouniu:hide()
    if self.titleClassic == nil then
        local size = self.menu:getContentSize()
        self.titleClassic = display.newSprite("image/title_classic.png")
        :pos(size.width / 2, size.height / 2)
        :addTo(self.menu)
    end
    self.back:show()
    self.titleClassic:show()
end

function TopMenuLayer:showHundred()
end

function TopMenuLayer:showRecreation()
end

return TopMenuLayer