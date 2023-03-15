import "scripts/stageTimer"
import "scripts/bpmDisplay"

local pd <const> = playdate
local gfx <const> = pd.graphics

local timer
local bpmDisplay
local testTable
local testSprite
local musicPlayer
local crankedUp

class('TestStage').extends(Room)

function TestStage:enter()
    timer = StageTimer()
    bpmDisplay = BPMDisplay()

    testTable = gfx.imagetable.new("assets/images/testSprite")
    testSprite = AnimatedSprite.new(testTable)
    testSprite:addState("idle",1, 2, {tickStep = 8})
    testSprite:moveTo(200, 120)
    testSprite:playAnimation()

    musicPlayer = pd.sound.fileplayer.new("assets/sound/testMusic")
    musicPlayer:setLoopRange(4, 8)
    musicPlayer:play(0)
end

function TestStage:update()
    musicPlayer:setRate(BEATS_PER_MINUTE / 120)
    if pd.buttonIsPressed( pd.kButtonUp ) then
        testSprite:moveBy( 0, -2 * (BEATS_PER_MINUTE / 120) )
    end
    if pd.buttonIsPressed( pd.kButtonRight ) then
        testSprite:moveBy( 2 * (BEATS_PER_MINUTE / 120), 0 )
    end
    if pd.buttonIsPressed( pd.kButtonDown ) then
        testSprite:moveBy( 0, 2 * (BEATS_PER_MINUTE / 120) )
    end
    if pd.buttonIsPressed( pd.kButtonLeft ) then
        testSprite:moveBy( -2 * (BEATS_PER_MINUTE / 120), 0 )
    end
    crankedUp = (pd.getCrankPosition() / 12 ) / 30
    BEATS_PER_MINUTE = pd.math.lerp(120, 240, crankedUp)
end