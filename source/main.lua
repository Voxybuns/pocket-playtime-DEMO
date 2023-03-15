import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"
import "CoreLibs/crank"
import "CoreLibs/math"

import "libraries/animatedSprite"
import "libraries/roomy"

local pd <const> = playdate
local gfx <const> = pd.graphics
local testTable
local testSprite
local timer
local musicPlayer
local crankedUp

class('BPMDisplay').extends(gfx.sprite)

function BPMDisplay:init()
    BPMDisplay.super.init(self)
    self:updateBPMDisplay(BEATS_PER_MINUTE)
end

function BPMDisplay:updateBPMDisplay(__newValue)
    local displayText = "BPM: " .. __newValue
    local displayImage = gfx.image.new(gfx.getTextSize(displayText))
    gfx.pushContext(displayImage)
        gfx.drawText(displayText, 0, 0)
    gfx.popContext()
    self:setImage(displayImage)
    self:moveTo(200, 24)
    self:add()
end

function BPMDisplay:update()
    BPMDisplay.super.init(self)
    self:updateBPMDisplay(BEATS_PER_MINUTE)
end

class('MinigameTimer').extends(gfx.sprite)

function MinigameTimer:init()
    MinigameTimer.super.init(self)

    self.startTime = 2
    self.currentTime = self.startTime
    self:moveTo(200, 235)
    self:updateTimer(self.startTime)
end

function MinigameTimer:updateTimer(newTime)
    local timerWidth = (newTime / self.startTime) * 400
    local timerImage = gfx.image.new(400, 10)
    gfx.pushContext(timerImage)
        gfx.fillRect(0, 0, timerWidth, 10)
    gfx.popContext()
    self:setImage(timerImage)
    self:add()
end

function MinigameTimer:update()
    MinigameTimer.super.update(self)
    if self.currentTime > 0 then
        self.currentTime -= BEATS_PER_MINUTE / 60 / 30
        self:updateTimer(self.currentTime)
    else
        self.currentTime = self.startTime
    end
end

BEATS_PER_MINUTE = 120

testTable = gfx.imagetable.new("assets/images/testSprite")
testSprite = AnimatedSprite.new(testTable)
testSprite:addState("idle",1, 2, {tickStep = 8})
testSprite:moveTo(200, 120)
testSprite:playAnimation()
testDisplay = BPMDisplay()

musicPlayer = pd.sound.fileplayer.new("assets/sound/testMusic")
musicPlayer:setLoopRange(4, 8)
musicPlayer:play(0)

timer = MinigameTimer()

function pd.update()
    musicPlayer:setRate(BEATS_PER_MINUTE / 120)
    if pd.buttonIsPressed( pd.kButtonUp ) then
        testSprite:moveBy( 0, -2 * (BEATS_PER_MINUTE / 120) )
    end
    if pd.buttonIsPressed( pd.kButtonRight ) then
        testSprite:moveBy( 2 * (BEATS_PER_MINUTE / 120), 0 )
    end
    if pd.buttonIsPressed( pd.kButtonDown ) then
        testSprite:moveBy( 0, 2 * (BEATS_PER_MINUTE / 120) )
    end
    if pd.buttonIsPressed( pd.kButtonLeft ) then
        testSprite:moveBy( -2 * (BEATS_PER_MINUTE / 120), 0 )
    end
    crankedUp = (pd.getCrankPosition() / 12 ) / 30
    BEATS_PER_MINUTE = pd.math.lerp(120, 240, crankedUp)
    gfx.sprite.update()
    pd.timer.updateTimers()
end