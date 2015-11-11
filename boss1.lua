boss1 = {}

-- this function is for OOP
function newObject(o, class)
    class.__index = class
    return setmetatable(o, class)
end

function boss1.new (originPointX,originPointY)
    underAttackBGM = love.audio.newSource("audio/slimeHit.ogg", "static")
    local guardMode = 1
    local attackMode = 2
    local boss1AnimaLength = 4
    local obj = {
        attackImg = love.graphics.newImage("img/thunderBall.png"),
        quads = {},
        iteration = 1,
        timer = 0,
        attack_x = 1000,
        attack_y = 700,
        isAttack = false,
        attacking = false,
        attack_cool_down = 1,
        attacking_cool_down=0,
        alive = true,
        hp = 50,
        underAttacking = false,
        slimeImgFile = love.graphics.newImage("img/boss1.png"),
        -- boss1MoveSound = love.audio.newSource("audio/boss11.ogg", "static"),
        slimeQuads = {},
        moveIndex = 1,
        animationIndex = 1,
        alertRange = 2,
        moveMode = guardMode,
        moveStep = {},
        nowX = originPointX,
        nowY = originPointY,
        pastX = originPointX,
        pastY = originPointY,
        keyPointX = originPointX,
        keyPointY = originPointY,
        healthPoint = 10,
        moveSpeed = (math.random(25,30))*0.01,
        lastMoveStep=0, --this var is for when guardMode change to attackMode, save the movenode
        timeTick = 0
    }
    for i=1,16 do
        obj.moveStep[i] = math.random(4)
    end
    for i=1,boss1AnimaLength do
        obj.slimeQuads[i] = {}
        for j=1,boss1AnimaLength do
            obj.slimeQuads[i][j] = love.graphics.newQuad( (200*j)-200, (200*i)-200, 200, 200, 800, 800)
        end
    end
    for i=1, 10 do
        obj.quads[i] = love.graphics.newQuad(0, 0, 100, 100, 500, 100)
    end
    for i=11, 14 do
        obj.quads[i] = love.graphics.newQuad(100*(i-10), 0, 100, 100, 500, 100)
    end
    obj = newObject(obj, boss1)
    return obj
end

function boss1:update(dt,charX,charY)
    self.timeTick = self.timeTick + dt
    if self.attacking == true then
        self.attacking_cool_down = self.attacking_cool_down + dt
    else
        if attackCheck(charX,charY,self.nowX,self.nowY) then
            self.attacking =true
        end
    end
    self.attack_cool_down = self.attack_cool_down + dt
    self.timer = self.timer + dt
    if self.isAttack then
        if self.timer > 0.05 then
            self.timer = 0
            self.iteration = self.iteration + 1
        end
        if self.iteration > 14 then
            self.isAttack = false
            self.iteration = 1
        end
    end
    if self.alive == true then
        if self.timeTick > 0.7 then
            self.underAttacking = false
            self.animationIndex = self.animationIndex + 1
            if self.animationIndex > 4 then
                self.animationIndex = 1
            end
            self.timeTick = 0
        end
    end

    if self.alive == true then
        if self.attack_cool_down > 2.5 then
            self:changeAtkXY()
            self.isAttack = true
            self.attack_cool_down = 0
        end
        if self.attacking_cool_down >1 then
            self.attacking = false
            self.attacking_cool_down = 0
        end
    end
end

function boss1:getPositionX()
    return self.nowX
end

function boss1:getPositionY()
    return self.nowY
end

function boss1:underAttack(faceDir,damageBlood)
    underAttackBGM:play()
    self.underAttacking = true
    self.hp = self.hp - damageBlood
    if self.hp <= 0 then
        self.alive = flase
    end
    self.timeTick = 0
    -- if faceDir == "up" then
    --     self.pastY = self.nowY
    --     self.nowY = self.nowY - 100
    -- elseif faceDir == "down" then
    --     self.pastY = self.nowY
    --     self.nowY = self.nowY + 100
    -- elseif faceDir == "left" then
    --     self.pastX = self.nowX
    --     self.nowX = self.nowX - 100
    -- elseif faceDir == "right" then
    --     self.pastX = self.nowX
    --     self.nowX = self.nowX + 100
    -- end

end

function boss1:attack()
    love.graphics.draw(self.attackImg, self.quads[self.iteration], self.attack_x-world.x, self.attack_y-world.y)
end

function attackCheck(charX,charY,boss1X,boss1Y)
    if boss1X <= charX and charX <= boss1X + 100  and boss1Y <= charY and charY <= boss1Y + 100 then
        x = hpDecline(1)
        return true
    else
        return false
    end
end

function boss1:changeAtkXY()
    self.attack_x = math.random(8,13) * 100
    self.attack_y = math.random(5,10) * 100
    while attack_x == 1000 or attack_x == 1100 do
        self.attack_x = math.random(7,14) * 100
    end
    while attack_y == 700 or attack_y == 800 do
        self.attack_y = math.random(4,11) * 100
    end
end
