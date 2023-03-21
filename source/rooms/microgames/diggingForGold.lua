-- Defining shorthands
local pd <const> = playdate
local gfx <const> = pd.graphics

class("DiggingForGold").extends(Microgame)

-- Nose stuff
local noseImage = gfx.imagetable.new("assets/diggingForGold/nose")
local nose = AnimatedSprite.new(noseImage)
nose:addState("idle", 1, 1)
nose:addState("bumpLeft", 7, 9, {tickStep = 2, loop = false})
nose:addState("bumpMid", 1, 3, {tickStep = 2, loop = false})
nose:addState("bumpRight", 4, 6, {tickStep = 2, loop = false})
local noseColliderLeft
local noseColliderMid
local noseColliderRight

local nostrilsImage = gfx.image.new("assets/diggingForGold/nostrils")
local nostrils = gfx.sprite.new(nostrilsImage)
nostrils:setZIndex(-2)

local sfxGiggle = pd.sound.sampleplayer.new("assets/giggle")
local sfxWiggle = pd.sound.sampleplayer.new("assets/wiggle")
local sfxPop = pd.sound.sampleplayer.new("assets/popped_cork")

local isIn = false

-- Hand stuff
class("Hand").extends(gfx.sprite)
function Hand:init(__offsetX, __offsetY)
    self.offsetX = __offsetX or 0
    self.offsetY = __offsetY or 0
    Hand.super.init(self)
    local handImage = gfx.image.new("assets/diggingForGold/hand")
    self:setImage(handImage)
    self:setZIndex(-1)
    self:add()
end
function Hand:update()
    self:moveTo(finger.x + self.offsetX, finger.y + self.offsetY)
end


-- Game states
local isPicking = false
local isBump = false

-- Creating a pinky class...
class("Pinky").extends(gfx.sprite)
function Pinky:init()
    Pinky.super.init(self)
    
    -- Animators
    local idle1 = pd.geometry.point.new(80, 100)
    local idle2 = pd.geometry.point.new(120, 100)
    self.animatorIdle = gfx.animator.new(beatsToMs(3), idle1, idle2, pd.easingFunctions.inOutQuad, beatsToMs(-1.5))
    self.animatorPick = gfx.animator.new(beatsToMs(0, 3), 100, 70, pd.easingFunctions.outQuad)
    self.animatorIdle.repeatCount = -1
    self.animatorIdle.reverses = true
    
    -- Setting up sprite and collisions
    local fingerImage = gfx.image.new("assets/diggingForGold/pinky")
    self:setImage(fingerImage)
    self:setCollideRect(0,0,8,8)
    self:setCenter(0.4, 0.5)
    self.collisionResponse = "overlap"
    self:setAnimator(self.animatorIdle)
    self:add()
end
function Pinky:update()
    Pinky.super.update(self)
    if isPicking == true then
        self:pick()
    end
end
function Pinky:pick()
    local actualX, actualY, collisions, length = self:moveWithCollisions(self.x, self.animatorPick:currentValue())
    local progress = self.animatorPick:progress()
    if length > 0 and isBump == false then
        self:setZIndex(1)
        isBump = true
        sfxWiggle:play()
        for index, collision in pairs(collisions) do
            local collider = collision['other']
            if collider:isa(noseColliderMid) then
                nose:changeState("bumpMid")
            elseif collider:isa(noseColliderLeft) then
                nose:changeState("bumpLeft")
            elseif collider:isa(noseColliderRight) then
                nose:changeState("bumpRight")
            end
        end
    end
    if isBump == false and progress > 0.75 and isIn ~= true then
        sfxGiggle:play()
        sfxPop:play()
        isIn = true
    end
end

class("Index").extends(Pinky)
function Index:init()
    Index.super.init(self)

    local fingerImage = gfx.image.new("assets/diggingForGold/index")
    self:setImage(fingerImage)
    self:setCollideRect(0,0,12,8)
    self:setCenter(0.5, 0.5)
end

function DiggingForGold:enter()
    DiggingForGold.super:enter(self)

    finger = Pinky()
    hand = Hand(-19, 38)

    nose:add()
    nose:moveTo(100, 40)
    nose:playAnimation()

    nostrils:add()
    nostrils:moveTo(100, 40)

    noseColliderLeft = gfx.sprite.addEmptyCollisionSprite(78, 56, 2, 8)
    noseColliderMid = gfx.sprite.addEmptyCollisionSprite(97, 56, 6, 8)
    noseColliderRight = gfx.sprite.addEmptyCollisionSprite(120, 56, 2, 8)
end

function DiggingForGold:AButtonDown()
    if isPicking == false then
        isPicking = true
        finger.animatorPick:reset()
        finger:removeAnimator()
    end
end

function DiggingForGold:BButtonDown()
    manager:enter(Intermission())
end