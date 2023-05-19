-- This object creates the timer displayed at the bottom of the screen
-- when a microgame is being played.

local pd <const> = playdate
local gfx <const> = pd.graphics

class('StageTimer').extends(gfx.sprite)

-- When called...
function StageTimer:init()
    gfx.setColor(gfx.kColorWhite)

    self.tempo = gameSettings.tempo
    -- Convert 8 beats into milliseconds according to the tempo
    self.duration = 8 * (60000 / self.tempo)
    -- Creating a unit timer
    self.timer = pd.timer.new(self.duration, 400, 0)
    -- Calling a function to draw the timer on every update
    self.timer.updateCallback = function(timer)
        self:updateTimer(self.timer.value)
    end
    self:moveTo(200, 236)
end

-- Drawing the timer
function StageTimer:updateTimer(__newTime)
    local timerWidth = __newTime
    local timerImage = gfx.image.new(400, 8)
    gfx.pushContext(timerImage)
        gfx.fillRect(0, 0, timerWidth, 8)
    gfx.popContext()
    self:setImage(timerImage)
    self:add()
end

function StageTimer:update()
    StageTimer.super.update(self)

    -- Removing the timer when it expires
    if self.timer.value == 0 then
        self:remove()
    end
end