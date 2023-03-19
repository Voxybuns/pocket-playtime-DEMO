-- This is a debug script intended to display the current tempo on screen

-- Shorthands
local pd <const> = playdate
local gfx <const> = pd.graphics

class('TempoDisplay').extends(gfx.sprite)

function TempoDisplay:init()
    TempoDisplay.super.init(self)
    -- Retrieving tempo
    self.tempo = gameSettings.tempo
    -- Drawing tempo
    self:updateTempo(self.tempo)
end

function TempoDisplay:updateTempo(__newValue)
    local displayText = __newValue
    local displayImage = gfx.image.new(gfx.getTextSize(displayText))
    gfx.pushContext(displayImage)
        gfx.drawText(displayText, 0, 0)
    gfx.popContext()
    self:setImage(displayImage)
    self:moveTo(100, 12)
    self:add()
end