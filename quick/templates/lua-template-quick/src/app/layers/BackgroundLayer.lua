local BackgroundLayer = class("BackgroundLayer",function()
    return display.newSprite()
end)

function BackgroundLayer:ctor()
    local background = display.newSprite("image/background.jpg")
    :setRotation(90)
    :pos(display.cx, display.cy)
    :addTo(self)
    
    local move1 = cc.MoveBy:create(2, cc.p(10, 0))
    local move2 = cc.MoveBy:create(2, cc.p(-10, 0))
    local SequenceAction = cc.Sequence:create( move1, move2 )
    --transition.execute(background, cc.RepeatForever:create( SequenceAction ))
end

return BackgroundLayer