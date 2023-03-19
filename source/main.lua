-- All the import functions are placed in their own files, to make main.lua cleaner
import "utilities/importModules"
import "utilities/importRooms"

-- Defining shorthands
local pd <const> = playdate
local gfx <const> = pd.graphics

-- Enabling 2x mode so I don't have to draw big sprites...
gfx.clear(gfx.kColorBlack)
gfx.setBackgroundColor(gfx.kColorBlack)
pd.display.setScale(2)
pd.display.setRefreshRate(50)

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