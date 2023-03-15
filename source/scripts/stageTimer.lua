local pd <const> = playdate
local gfx <const> = pd.graphics

class('StageTimer').extends(gfx.sprite)

function StageTimer:init()
    StageTimer.super.init(self)

    self.beatsAmount = 8
    self.currentTime = self.beatsAmount
    self:moveTo(200, 235)
    self:updateTimer(self.beatsAmount)
end

function StageTimer:updateTimer(newTime)
    local timerWidth = (newTime / self.beatsAmount) * 400
    local timerImage = gfx.image.new(400, 10)
    gfx.pushContext(timerImage)
        gfx.fillRect(0, 0, timerWidth, 10)
    gfx.popContext()
    self:setImage(timerImage)
    self:add()
end

function StageTimer:update()
    StageTimer.super.update(self)
    if self.currentTime > 0 then
        self.currentTime -= BEATS_PER_MINUTE / 60 / 30
        self:updateTimer(self.currentTime)
    else
        self.currentTime = self.beatsAmount
    end
end