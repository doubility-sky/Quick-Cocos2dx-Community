local ClassicItemLayer = class("ClassicItemLayer",function()
    return display.newSprite()
end)

function ClassicItemLayer:ctor()
    local emptyNode = cc.Node:create()
    emptyNode:setContentSize(display.width + 550, display.height)
    
    display.newSprite("image/classic_1.png")
    :pos(display.cx, display.cy + 125)
    :addTo(emptyNode)
    
    cc.ui.UIPushButton.new({ normal = "image/button_classic_clear.png", pressed = "image/button_classic.png"})
    :onButtonClicked(function()
            self.scene:onGame("classic1")
        end)
    :pos( display.cx - 3, display.cy  + (3 + 125)) 
    :addTo(emptyNode)
    
    display.newSprite("image/classic_2.png")
    :pos(display.cx + 550, display.cy + 125)
    :addTo(emptyNode)
    
    cc.ui.UIPushButton.new({ normal = "image/button_classic_clear.png", pressed = "image/button_classic.png"})
    :onButtonClicked(function()
            self.scene:onGame("classic2")
        end)
    :pos( display.cx + ( 550 - 3), display.cy  + 3 + 125)
    :addTo(emptyNode)
    
    display.newSprite("image/classic_3.png")
    :pos(display.cx, display.cy - 125)
    :addTo(emptyNode)
    
    cc.ui.UIPushButton.new({ normal = "image/button_classic_clear.png", pressed = "image/button_classic.png"})
    :onButtonClicked(function()
            self.scene:onGame("classic3")
        end)
    :pos( display.cx - 3, display.cy  + (3 - 125))
    :addTo(emptyNode)
    
    display.newSprite("image/classic_4.png")
    :pos(display.cx + 550, display.cy - 125)
    :addTo(emptyNode)
    
    cc.ui.UIPushButton.new({ normal = "image/button_classic_clear.png", pressed = "image/button_classic.png"})
    :onButtonClicked(function()
            self.scene:onGame("classic4")
        end)
    :pos( display.cx + (550 - 3), display.cy  + (3 - 125))
    :addTo(emptyNode)
    
    local scrollview = cc.ui.UIScrollView.new({viewRect = cc.rect(0,90,display.width,display.height-180)})
    :addScrollNode(emptyNode)
    :setDirection(cc.ui.UIScrollView.DIRECTION_HORIZONTAL)
    -- :onScroll(handler(self, nil))
    :addTo(self)
end

function ClassicItemLayer:setScene(scene)
    self.scene = scene
end

return ClassicItemLayer