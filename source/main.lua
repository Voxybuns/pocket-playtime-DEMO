-- All the import functions are placed in their own files, to make main.lua cleaner
import "utilities/importModules"
import "utilities/importRooms"

-- Defining shorthands
local pd <const> = playdate
local gfx <const> = pd.graphics

-- Display setup
gfx.clear(gfx.kColorBlack) -- Invert colors
gfx.setBackgroundColor(gfx.kColorBlack)

-- Creating the global game settings
gameSettings = GameSettings()

-- Creating the global scene manager
manager = Manager()
manager:hook()
manager:enter(Intermission())

-- Global update function
function pd.update()
    gfx.sprite.update()
    pd.timer.updateTimers()
    manager:emit('update')
end