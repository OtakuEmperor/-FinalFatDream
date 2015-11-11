kagemusha = {}

function newObject(o, class)
    class.__index = class
    return setmetatable(o, class)
end

function kagemusha.new (monster, originPointX, originPointY)
    local kagemushaAnimaLength = 4
    local obj = {
        alive = monster.alive,
        hp = monster.hp,
        mon = monster,
        nowX = originPointX,
        nowY = originPointY,
        moveStep = {},
        slimeQuads = {},
        moveIndex = 1,
        animationIndex = 1,
        slimeImgFile = love.graphics.newImage("img/bossWave.png")
    }
    for i=1,16 do
        obj.moveStep[i] = math.random(4)
    end
    for i=1,kagemushaAnimaLength do
        obj.slimeQuads[i] = {}
        for j=1,kagemushaAnimaLength do
            obj.slimeQuads[i][j] = love.graphics.newQuad(700, 100, 100, 100, 900, 300)
        end
    end
    obj = newObject(obj, kagemusha)
    return obj
end

function kagemusha:update(dt,charX,charY)
end

function kagemusha:getPositionX()
    return self.nowX
end

function kagemusha:getPositionY()
    return self.nowY
end

function kagemusha:underAttack(faceDir,damageBlood)
    self.mon:underAttack(faceDir, damageBlood)
end