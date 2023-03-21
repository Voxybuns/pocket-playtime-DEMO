-- Defining shorthands
local pd <const> = playdate
local gfx <const> = pd.graphics


class("SpriteWithChild").extends(gfx.sprite)

function SpriteWithChild:init(__parent, __child, __offsetX, __offsetY)
    SpriteWithChild.super.init(self)
    self.offsetX = __offsetX
    self.offsetY = __offsetY
    self.parent = __parent
    self.child = __child
end

function SpriteWithChild:add()
    self.parent:add()
    self.child:add()
end
