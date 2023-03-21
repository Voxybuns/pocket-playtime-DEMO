-- Defining shorthands
local pd <const> = playdate
local gfx <const> = pd.graphics

class("Intermission").extends(Room)

local dials = {}

local sceneTimer
local sfxIntermission
local sfxWon
local sfxLost

local isGameWon

class("Dial").extends(gfx.sprite)

function Dial:init(__x, __y)
    self.dialImage = gfx.imagetable.new("assets/intermission/dial")
    self.dial = AnimatedSprite.new(self.dialImage)
    self.dial:addState("idle", 1, 1)
    self.dial:addState("popped", 2, 2)
    self.dial:moveTo(__x, __y)
    self.dial:playAnimation()
end

function Dial:lose()
    local sfx = pd.sound.sampleplayer.new("assets/popped_cork")
    self.dial:changeState("popped")
    sfx:play()
end

function checkDials()
    for i = gameSettings.lives, 0, -1 do
        dials[i].dial:changeState("popped")
    end
end

function Intermission:goToGame()
    manager:enter(DiggingForGold())
end

function Intermission:enter(previous, ...)
    -- self.gameList = {
    --     TestGame,
    --     TestGame2,
    --     TestGame3
    -- }

    
    for i = 1, 4, 1 do
        dials[i] = Dial(40 + (i * 24), 100)
    end

    checkDials()

    isGameWon = select(1, ...)
    print(isGameWon)

    local backgroundImage = gfx.image.new("assets/intermission/background")
    gfx.sprite.setBackgroundDrawingCallback(
        function (x, y, width, height)
            backgroundImage:draw( 0, 0 )
        end
    )

    sfxIntermission = pd.sound.sampleplayer.new("assets/intermission")
    sfxWon = pd.sound.sampleplayer.new("assets/gamewon")
    sfxLost = pd.sound.sampleplayer.new("assets/gamelost")

    if isGameWon == true then
        sfxWon:play()
        sceneTimer = pd.timer.performAfterDelay(beatsToMs(8), function()
            Intermission:goToGame()
        end)
    elseif isGameWon == false then
        sfxLost:play()
        gameSettings.lives -= 1
        checkDials()
        sceneTimer = pd.timer.performAfterDelay(beatsToMs(8), function()
            Intermission:goToGame()
        end)
    else
        sfxIntermission:play()
        sceneTimer = pd.timer.performAfterDelay(beatsToMs(9.5), function()
            Intermission:goToGame()
        end)
    end



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

function Intermission:BButtonDown()
    dial4:lose()
end