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
    local displayText = "Press A to try"
    local displayImage = gfx.image.new(gfx.getTextSize(displayText))
    gfx.pushContext(displayImage)
        gfx.setImageDrawMode(gfx.kDrawModeFillWhite)
        gfx.drawText(displayText, 0, 0)
    gfx.popContext()
    local displaySprite = gfx.sprite.new(displayImage)
    displaySprite:moveTo(100, 12)
    displaySprite:add()
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