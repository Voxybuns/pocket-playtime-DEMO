local pd <const> = playdate
local gfx <const> = pd.graphics

class("GameSettings").extends()

function GameSettings:init()
    self.tempo = 120
    self.lives = 4
    self.difficulty = 1
end