local GameTableLayer = class("GameTableLayer",function()
    return display.newSprite()
end)

function GameTableLayer:ctor()
    display.newSprite("image/table_background.jpg")
    :pos(display.cx, display.top - 360)
    :addTo(self)
    
    display.newSprite("image/table_background.jpg")
    :pos(display.cx, display.bottom + 360)
    :addTo(self)
    
    display.newSprite("image/table_marker.png")
    :pos(display.cx, display.cy + 60)
    :addTo(self)
end

return GameTableLayer