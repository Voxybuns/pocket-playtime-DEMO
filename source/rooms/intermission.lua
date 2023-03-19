-- Defining shorthands
local pd <const> = playdate
local gfx <const> = pd.graphics

class("Intermission").extends(Room)

function Intermission:enter(previous, ...)
    -- self.gameList = {
    --     TestGame,
    --     TestGame2,
    --     TestGame3
    -- }
    self.tempoDisplay = TempoDisplay()
end

function Intermission:upButtonDown()
    gameSettings.tempo += 20
end

function Intermission:downButtonDown()
    gameSettings.tempo -= 20
end

function Intermission:AButtonDown()
    -- self.index = math.random(3)
    -- manager:enter(self.gameList[self.index](), gameSettings.tempo)
    manager:enter(DiggingForGold())
end

function Intermission:update()
    self.tempoDisplay:updateTempo(gameSettings.tempo)
end