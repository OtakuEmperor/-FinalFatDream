--world1
tree={}
forest={}
stone={}
grass={}
questionMark={}
q3Trap={}
npc={}
questionKey={}
--world2
blackboard={}
deepWall={}
deepWall_boss={}
lightWall={}
floor={}
aisle={}
deskChair={}
stair={}
dust={}
fence ={}
UNG={}
deepWall_counter = 1
lightWall_counter = 1
fence_counter = 1
deskChair_counter = 1
--world3
houseWall={}
houseFloor={}
bookcase={}
bed={}
kotatsu={}
potted={}
sofa={}
tv={}
bigTable={}
smallTable={}
tv_fake = 1
bed_fake = 1
kotatsu_fake = 1
sofa_fake = 1
bigTable_fake = 1
smallTable_fake = 1
-- this function is for OOP
function newObject(o, class)
    class.__index = class
    return setmetatable(o, class)
end
function npc.new (originPointX,originPointY)
    local obj = {
        Image = love.graphics.newImage("img/books.png"),
        Barrier=true,
        dialog={},
        dialogLength=0,
        x = originPointX,
        y = originPointY
    }
    obj = newObject(obj, npc)
    return obj
end
function tree.new (originPointX,originPointY)
   local obj = {
        Image = love.graphics.newImage("img/stone.png"),
        Barrier=false,
        moveable=true,
        nx= originPointX,
        ny= originPointX,
        x = originPointX,
        y = originPointY
    }
    obj = newObject(obj, tree)
    return obj
end

function forest.new (originPointX,originPointY)
   local obj = {
        Image = love.graphics.newImage("img/forest.png"),
        Barrier=true,
        x = originPointX,
        y = originPointY
    }
    obj = newObject(obj, forest)
    return obj
end

function stone.new (originPointX,originPointY)
   local obj = {
        Image = love.graphics.newImage("img/stone.png"),
        Barrier=true,
        x = originPointX,
        y = originPointY
    }
    obj = newObject(obj, stone)
    return obj
end

function grass.new (originPointX,originPointY)
   local num = love.math.random(1, 4)
   local grassImg
   if num == 1 then
       grassImg = "img/grass1.png"
   elseif num == 2 then
       grassImg = "img/grass2.png"
   elseif num == 3 then
       grassImg = "img/grass3.png"
   elseif num == 4 then
       grassImg = "img/grass4.png"
   end
   local obj = {
        Image = love.graphics.newImage(grassImg),
        Barrier=false,
        x = originPointX,
        y = originPointY
    }
    obj = newObject(obj, grass)
    return obj
end

--world2
function blackboard.new (originPointX,originPointY)
   local obj = {
        Image = love.graphics.newImage("img/world2/blackboard.png"),
        Barrier=true,
        x = originPointX,
        y = originPointY
    }
    obj = newObject(obj, blackboard)
    return obj
end
function deepWall.new (originPointX,originPointY)
    local deepWallImg
    if deepWall_counter <= 100 then
        deepWallImg = "img/world2/deepWall.png"
    else
        deepWallImg = "img/world2/deepWall_hor.png"
    end
    deepWall_counter = deepWall_counter + 1
   local obj = {
        Image = love.graphics.newImage(deepWallImg),
        Barrier=true,
        x = originPointX,
        y = originPointY
    }
    obj = newObject(obj, deepWall)
    return obj
end
function deepWall_boss.new (originPointX,originPointY)
   local obj = {
        Image = love.graphics.newImage("img/world2/deepWall_boss.png"),
        Barrier=true,
        x = originPointX,
        y = originPointY
    }
    obj = newObject(obj, deepWall_boss)
    return obj
end
function lightWall.new (originPointX,originPointY)
    local lightWallImg
    if lightWall_counter <= 5 then
        lightWallImg = "img/world2/lightWall_left.png"
    elseif lightWall_counter > 5 and lightWall_counter <= 10 then
        lightWallImg = "img/world2/lightWall_right.png"
    elseif lightWall_counter > 10 and lightWall_counter <= 28 then
        lightWallImg = "img/world2/lightWall_down.png"
    elseif lightWall_counter == 29 or lightWall_counter == 30 then
        lightWallImg = "img/world2/lightWall_leftCorner.png"
    elseif lightWall_counter == 31 or lightWall_counter == 32 then
        lightWallImg = "img/world2/lightWall_rightCorner.png"
    end
    lightWall_counter = lightWall_counter + 1
   local obj = {
        Image = love.graphics.newImage(lightWallImg),
        Barrier=true,
        isSolve=false,
        x = originPointX,
        y = originPointY
    }
    obj = newObject(obj, lightWall)
    return obj
end
function floor.new (originPointX,originPointY)
   local obj = {
        Image = love.graphics.newImage("img/world2/floor.png"),
        Barrier=false,
        x = originPointX,
        y = originPointY
    }
    obj = newObject(obj, floor)
    return obj
end
function aisle.new (originPointX,originPointY)
   local obj = {
        Image = love.graphics.newImage("img/world2/aisle.png"),
        Barrier=false,
        x = originPointX,
        y = originPointY
    }
    obj = newObject(obj, aisle)
    return obj
end
function deskChair.new (originPointX,originPointY)
    local deskChairIMG
    if deskChair_counter == 1 or deskChair_counter == 18 or deskChair_counter == 34 then
        deskChairIMG = ("img/world2/deskChair_blood.png")
    else
        deskChairIMG = ("img/world2/deskChair.png")
    end
    deskChair_counter = deskChair_counter + 1
   local obj = {
        Image = love.graphics.newImage(deskChairIMG),
        Barrier=true,
        isSolve=false,
        dialog={},
        dialogLength=0,
        moveable=false,
        nx= originPointX,
        ny= originPointX,
        x = originPointX,
        y = originPointY
    }
    obj = newObject(obj, deskChair)
    return obj
end
function stair.new (originPointX,originPointY)
   local obj = {
        Image = love.graphics.newImage("img/world2/stair.png"),
        Barrier=false,
        x = originPointX,
        y = originPointY
    }
    obj = newObject(obj, stair)
    return obj
end
function dust.new (originPointX,originPointY)
   local obj = {
        Image = love.graphics.newImage("img/world2/dust.png"),
        Barrier=false,
        x = originPointX,
        y = originPointY
    }
    obj = newObject(obj, dust)
    return obj
end
function fence.new (originPointX,originPointY)
    local fenceImg
    if fence_counter <= 65 then
        fenceImg = "img/world2/fence_center.png"
    elseif fence_counter > 65 and fence_counter <= 72 then
        fenceImg = "img/world2/fence_left.png"
    elseif fence_counter > 72 then
        fenceImg = "img/world2/fence_right.png"
    end
    fence_counter = fence_counter + 1
    local obj = {
         Image = love.graphics.newImage(fenceImg),
         Barrier=true,
         x = originPointX,
         y = originPointY
     }
     obj = newObject(obj, fence)
     return obj
end
function UNG.new (originPointX,originPointY)
   local obj = {
        Image = love.graphics.newImage("img/world2/UNG.png"),
        Barrier=true,
        x = originPointX,
        y = originPointY
    }
    obj = newObject(obj, UNG)
    return obj
end

--world3
function houseWall.new (originPointX,originPointY)
   local obj = {
        Image = love.graphics.newImage("img/world3/houseWall.png"),
        Barrier=true,
        x = originPointX,
        y = originPointY
    }
    obj = newObject(obj, houseWall)
    return obj
end
function houseFloor.new (originPointX,originPointY)
   local obj = {
        Image = love.graphics.newImage("img/world3/houseFloor.png"),
        Barrier=false,
        x = originPointX,
        y = originPointY
    }
    obj = newObject(obj, houseFloor)
    return obj
end
function kotatsu.new (originPointX,originPointY)
    local kotatsuImg
    if kotatsu_fake == 1 then
        kotatsuImg = "img/world3/kotatsu.png"
    else
        kotatsuImg = "img/world3/nothing.png"
    end
    kotatsu_fake = kotatsu_fake + 1
   local obj = {
        Image = love.graphics.newImage(kotatsuImg),
        Barrier=true,
        x = originPointX,
        y = originPointY
    }
    obj = newObject(obj, kotatsu)
    return obj
end
function bed.new (originPointX,originPointY)
    local bedImg
    if bed_fake == 1 then
        bedImg = "img/world3/bed.png"
    else
        bedImg = "img/world3/nothing.png"
    end
    bed_fake = bed_fake + 1
   local obj = {
        Image = love.graphics.newImage(bedImg),
        Barrier=true,
        x = originPointX,
        y = originPointY
    }
    obj = newObject(obj, bed)
    return obj
end
function potted.new (originPointX,originPointY)
   local obj = {
        Image = love.graphics.newImage("img/world3/potted.png"),
        Barrier=true,
        x = originPointX,
        y = originPointY
    }
    obj = newObject(obj, potted)
    return obj
end
function bookcase.new (originPointX,originPointY)
   local obj = {
        Image = love.graphics.newImage("img/world3/bookcase.png"),
        Barrier=true,
        x = originPointX,
        y = originPointY
    }
    obj = newObject(obj, bookcase)
    return obj
end
function tv.new (originPointX,originPointY)
    local tvImg
    if tv_fake == 1 then
        tvImg = "img/world3/tv.png"
    else
        tvImg = "img/world3/nothing.png"
    end
    tv_fake = tv_fake + 1
   local obj = {
        Image = love.graphics.newImage(tvImg),
        Barrier=true,
        x = originPointX,
        y = originPointY
    }
    obj = newObject(obj, tv)
    return obj
end
function smallTable.new (originPointX,originPointY)
    local smallTableImg
    if smallTable_fake == 1 then
        smallTableImg = "img/world3/smallTable.png"
    else
        smallTableImg = "img/world3/nothing.png"
    end
    smallTable_fake = smallTable_fake + 1
   local obj = {
        Image = love.graphics.newImage(smallTableImg),
        Barrier=true,
        x = originPointX,
        y = originPointY
    }
    obj = newObject(obj, smallTable)
    return obj
end
function bigTable.new (originPointX,originPointY)
    local bigTableImg
    if bigTable_fake == 1 then
        bigTableImg = "img/world3/bigTable.png"
    else
        bigTableImg = "img/world3/nothing.png"
    end
    bigTable_fake = bigTable_fake + 1
   local obj = {
        Image = love.graphics.newImage(bigTableImg),
        Barrier=true,
        x = originPointX,
        y = originPointY
    }
    obj = newObject(obj, bigTable)
    return obj
end
function sofa.new (originPointX,originPointY)
    local sofaImg
    if sofa_fake == 1 then
        sofaImg = "img/world3/sofa.png"
    else
        sofaImg = "img/world3/nothing.png"
    end
    sofa_fake = sofa_fake + 1
   local obj = {
        Image = love.graphics.newImage(sofaImg),
        Barrier=true,
        x = originPointX,
        y = originPointY
    }
    obj = newObject(obj, sofa)
    return obj
end
