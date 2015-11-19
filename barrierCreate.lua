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
lightWall={}
floor={}
deskChair={}
stair={}
dust={}
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
    obj = newObject(obj, tree)
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
   local obj = {
        Image = love.graphics.newImage("img/world2/deepWall.png"),
        Barrier=true,
        x = originPointX,
        y = originPointY
    }
    obj = newObject(obj, deepWall)
    return obj
end
function lightWall.new (originPointX,originPointY)
   local obj = {
        Image = love.graphics.newImage("img/world2/lightWall.png"),
        Barrier=true,
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
function deskChair.new (originPointX,originPointY)
   local obj = {
        Image = love.graphics.newImage("img/world2/deskChair.png"),
        Barrier=true,
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
