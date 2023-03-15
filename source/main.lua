import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"
import "CoreLibs/crank"
import "CoreLibs/math"

import "libraries/animatedSprite"
import "libraries/roomy"

import "stages/testStage"

local pd <const> = playdate
local gfx <const> = pd.graphics

BEATS_PER_MINUTE = 120

local manager

manager = Manager()

manager:enter(TestStage)

function pd.update()
    gfx.sprite.update()
    pd.timer.updateTimers()
    manager:emit('update')
end