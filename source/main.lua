-- Importing core libraries
import "CoreLibs/graphics"
import "CoreLibs/object"
import "CoreLibs/sprites"
import "CoreLibs/animator"
import "CoreLibs/easing"
import "CoreLibs/math"
import "Corelibs/timer"
import "CoreLibs/accelerometer"
import "CoreLibs/crank"

-- Importing third-party libraries
import "libraries/animatedSprite"
import "libraries/roomy"

-- Defining shorthands
local pd <const> = playdate
local gfx <const> = pd.graphics

-- Global scene manager
local manager = Manager()

-- Global variables
local tempo = 120

-- Global update function
function update()
    gfx.sprite.update()
    pd.timer.updateTimers()
end