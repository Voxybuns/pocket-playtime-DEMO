-- Defining shorthands
local pd <const> = playdate
local gfx <const> = pd.graphics

class("Intermission").extends(Room)

-- Create a table to store the lives on screen
local lives = {}

local sceneTimer
local sfxIntermission
local sfxWon
local sfxLost

local isGameWon

-- Create a class for the dial sprites
class("Life").extends(gfx.sprite)

-- Initialize Dial object
function Life:init(__x, __y)
    self.lifeImage = gfx.imagetable.new("assets/intermission/life")
    self.life = AnimatedSprite.new(self.lifeImage)
    self.life:addState("empty", 9, 11, {tickStep = 2})
    self.life:addState("emptying", 4, 8, {tickStep = 2, nextAnimation = "empty"})
    self.life:addState("full", 1, 3, {tickStep = 2})
    self.life:moveTo(__x, __y)
    self.life:playAnimation()
end

-- Draw the life bar
function checkLives()
    -- Draw all icons with the default empty state
    for i = 1, 4, 1 do
        lives[i] = Life(48 + (i * 64), 200)
    end
    -- Have all remaining lives display their full state
    for i = 1, gameSettings.lives, 1 do
        lives[i].life:changeState("full")
    end
end

-- Handle lives animation and count when game is lost
function loseLive()
    -- Changing the current life to its empty state
    lives[gameSettings.lives].life:changeState("emptying")
    -- Decreasing lives
    gameSettings.lives -= 1
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
    -- Draw background image
    local backgroundImage = gfx.image.new("assets/intermission/background")
    gfx.sprite.setBackgroundDrawingCallback(
        function (x, y, width, height)
            backgroundImage:draw( 0, 0 )
        end
    )
    -- Draw the lives counter
    checkLives()
    -- Store the exit game's state
    isGameWon = select(1, ...)
    -- Initialize SFX
    sfxIntermission = pd.sound.sampleplayer.new("assets/intermission")
    sfxWon = pd.sound.sampleplayer.new("assets/gamewon")
    sfxLost = pd.sound.sampleplayer.new("assets/gamelost")
    -- React to exit game's state
    if isGameWon == true then
        sfxWon:play()
        sceneTimer = pd.timer.performAfterDelay(beatsToMs(8), function()
            Intermission:goToGame()
        end)
    elseif isGameWon == false then
        sfxLost:play()
        loseLive()
        sceneTimer = pd.timer.performAfterDelay(beatsToMs(8), function()
            Intermission:goToGame()
        end)
    else
        sfxIntermission:play() -- When launching game for the first time...
        sceneTimer = pd.timer.performAfterDelay(beatsToMs(9.5), function()
            Intermission:goToGame()
        end)
    end
end

-- Debug functions to change tempo
function Intermission:upButtonDown()
    gameSettings.tempo += 20
end
function Intermission:downButtonDown()
    gameSettings.tempo -= 20
end

function Intermission:AButtonDown()
    -- self.index = math.random(3)
    -- manager:enter(self.gameList[self.index](), gameSettings.tempo)
end