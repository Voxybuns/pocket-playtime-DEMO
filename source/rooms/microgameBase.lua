-- Defining shorthands
local pd <const> = playdate
local gfx <const> = pd.graphics

-- Defining base Microgame class
class("Microgame").extends(Room)

-- When entering the microgame...
function Microgame:enter(previous, ...)
    self.isWon = false
    -- Retrieve the tempo
    -- Create a timer instance
    self.timer = StageTimer(gameSettings.tempo)
    -- Create a tempo display instance (DEBUG)
    -- self.tempoDisplay = TempoDisplay(gameSettings.tempo)
end

function Microgame:update()
    local timerValue = self.timer.timer.value
    if timerValue == 0 then
        manager:enter(Intermission(), self.isWon)
    end
end
