-- Defining shorthands
local pd <const> = playdate
local gfx <const> = pd.graphics

class("DiggingForGold").extends(Microgame)

local noseImage = gfx.imagetable.new("assets/diggingForGold/nose")
local nose = AnimatedSprite.new(noseImage)
local handImage = gfx.imagetable.new("assets/diggingForGold/hand")
local hand = AnimatedSprite.new(handImage)
local nostrilsImage = gfx.image.new("assets/diggingForGold/nostrils")
local nostrils = gfx.sprite.new(nostrilsImage)
local animatorX
local animatorY
local handPosX
local handPosY
local isPicked = false

function DiggingForGold:enter(previous, ...)
    DiggingForGold.super:enter(self, ...)

    animatorX = gfx.animator.new(beatsToMs(3), 40, 160, playdate.easingFunctions.linear, beatsToMs(-1.5))
    animatorX.repeatCount = -1
    animatorX.reverses = true

    nose:addState("idle", 1, 1)
    nose:setZIndex(2)
    nose:add()
    nose:moveTo(100, 36)
    nose:playAnimation()

    nostrils:moveTo(100, 36)
    nostrils:setZIndex(-1)
    nostrils:add()

    hand:addState("pinkyUp", 1, 1)
    hand:addState("indexUp", 2, 2)
    hand:addState("bothUp", 3, 3)
    hand:add()
    hand:playAnimation()
end

function DiggingForGold:update()
    if isPicked == false then
        handPosX = animatorX:currentValue()
        handPosY = 120
    else
        handPosY = animatorY:currentValue()
    end
    hand:moveTo(handPosX, handPosY)
end

function DiggingForGold:AButtonDown()
    handPosX = animatorX:currentValue()
    animatorY = gfx.animator.new(beatsToMs(0.5), 120, 86, playdate.easingFunctions.outQuad)
    isPicked = true
end