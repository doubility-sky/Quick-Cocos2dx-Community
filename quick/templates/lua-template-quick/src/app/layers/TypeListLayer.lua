local TypeListLayer = class("TypeListLayer",function()
    return display.newSprite()
end)

function TypeListLayer:ctor()
    local emptyNode = cc.Node:create()
    emptyNode:setContentSize(display.width + 800, display.height)

    display.newSprite("image/classic.png")
    :pos(display.cx, display.cy)
    :addTo(emptyNode)
    
    cc.ui.UIPushButton.new({ normal = "image/button_type_clear.png", pressed = "image/button_type.png"})
    :onButtonClicked(function()
            self.scene:onType("classic")
        end)
    :pos( display.cx, display.cy  + 6)
    :addTo(emptyNode)
    
    display.newSprite("image/recreation.png")
    :pos(display.cx + 400, display.cy)
    :addTo(emptyNode)
    
    cc.ui.UIPushButton.new({ normal = "image/button_type_clear.png", pressed = "image/button_type.png" })
    :onButtonClicked(function()
            self.scene:onType("recreation")
        end)
    :pos( display.cx + 400, display.cy  + 6)
    :addTo(emptyNode)
    
    display.newSprite("image/hundred.png")
    :pos(display.cx + 800, display.cy)
    :addTo(emptyNode)
    
    cc.ui.UIPushButton.new({ normal = "image/button_type_clear.png", pressed = "image/button_type.png"})
    :onButtonClicked(function()
            self.scene:onType("hundred")
        end)
    :pos( display.cx + 800, display.cy + 6)
    :addTo(emptyNode)

    local scrollview = cc.ui.UIScrollView.new({viewRect = cc.rect(0,90,display.width,display.height-180)})
    :addScrollNode(emptyNode)
    :setDirection(cc.ui.UIScrollView.DIRECTION_HORIZONTAL)
    -- :onScroll(handler(self, nil))
    :addTo(self)
end

function TypeListLayer:setScene(scene)
    self.scene = scene
end

return TypeListLayer