boss2 = {}

function newObject(o, class)
    class.__index = class
    return setmetatable(o, class)
end

function boss2.new (originPointX, originPointY)
    local boss2AnimaLength = 4
    underAttackBGM_boss2 = love.audio.newSource("audio/bossHit.wav", "static")
    local obj = {
        alive = true,
        hp = 20,
        face = 1, -- down 1, up 2, left 3, right 4
        nowX = originPointX,
        nowY = originPointY,
        toX = originPointX,
        toY = originPointY,
        isRun = false,
        runDir = 1, -- up 1, down 2, left 3, right 4
        runTimer = 0,
        runCounter = 0,
        runCD = 0,
        attackSpeed = 1,
        startRun = false,
        moveStep = {},
        slimeQuads = {},
        moveIndex = 1,
        animationIndex = 1,
        animationTimer = 0,
        attacking = false,
        attacking_cool_down=0,
        slimeImgFile = love.graphics.newImage("img/world2/boss2.png")
    }
    for i=1,16 do
        obj.moveStep[i] = math.random(4)
    end
    for i=1, boss2AnimaLength do
        obj.slimeQuads[i] = {}
        for j=1,boss2AnimaLength do
            obj.slimeQuads[i][j] = love.graphics.newQuad( (200*j)-200, (200*i)-200, 200, 200, 800, 800)
        end
    end
    obj = newObject(obj, boss2)
    return obj
end

function boss2:update(dt,charX,charY)
    self.animationTimer = self.animationTimer + dt
    if self.isRun then
        self.runTimer = self.runTimer + dt
    end
    if self.startRun then
        self.runCD = self.runCD + dt
    end

    if self.alive then
        if self.attacking == true then
            self.attacking_cool_down = self.attacking_cool_down + dt
        else
            if self:attack_check(charX,charY,self.nowX,self.nowY) then
                self.attacking =true
            end
        end
        if self.attacking_cool_down >1 then
            self.attacking = false
            self.attacking_cool_down = 0
        end
    end
    if self.isRun then
        if self.runTimer > 0.04 then
            self.animationIndex = self.animationIndex + 1
            if self.animationIndex > 4 then
                self.animationIndex = 1
            end

            if self.runDir == 1 then
                if not (self.nowY <= self.toY) then
                    self.nowY = self.nowY - 50
                else
                    self.isRun = false
                end
            elseif self.runDir == 2 then
                if not (self.nowY >= self.toY) then
                    self.nowY = self.nowY + 50
                else
                    self.isRun = false
                end
            elseif self.runDir == 3 then
                if not (self.nowX <= self.toX) then
                    self.nowX = self.nowX - 50
                else
                    self.isRun = false
                end
            elseif self.runDir == 4 then
                if not (self.nowX >= self.toX) then
                    self.nowX = self.nowX + 50
                else
                    self.isRun = false
                end
            end
            self.runTimer = 0
        end
    else
        self.animationIndex = 1
    end
    if self.alive and self.startRun then
        if self.runCD > self.attackSpeed then
            self:run(character.x+world.x, character.y+world.y)
            self.runCD = 0
        end
    end
end

function boss2:getPositionX()
    return self.nowX
end

function boss2:getPositionY()
    return self.nowY
end

function boss2:underAttack(faceDir,damageBlood)
    underAttackBGM_boss2:setVolume(getVol())
    underAttackBGM_boss2:play()
    self.underAttacking = true
    self.hp = self.hp - damageBlood
    if self.hp <= 0 then
        self.alive = flase
    end
end

function boss2:attack_check(charX,charY,boss1X,boss1Y)
    if boss1X <= charX and charX <= boss1X + 100  and boss1Y <= charY and charY <= boss1Y + 100 and self.alive then
        x = hpDecline(1)
        return true
    else
        return false
    end
end

function boss2:run(characterX, characterY)
    if self.nowX == characterX then self.counter = 1 end
    if self.nowY == characterY then self.counter = 0 end
    if self.runCounter % 2 == 0 then -- run X
        if self.nowX > characterX then
            self.face = 3
            self.runDir = 3
            self.toX = characterX
            self.isRun = true
        elseif self.nowX < characterX then
            self.face = 4
            self.runDir = 4
            self.toX = characterX
            self.isRun = true
        end
    elseif self.runCounter % 2 == 1 then -- run Y
        if self.nowY > characterY then
            self.face = 2
            self.runDir = 1
            self.toY = characterY
            self.isRun = true
        elseif self.nowY < characterY then
            self.face = 1
            self.runDir = 2
            self.toY = characterY
            self.isRun = true
        end
    end
    self.runCounter = self.runCounter + 1
end
