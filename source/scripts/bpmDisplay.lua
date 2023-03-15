local pd <const> = playdate
local gfx <const> = pd.graphics

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