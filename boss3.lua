boss3 = {}

function newObject(o, class)
    class.__index = class
    return setmetatable(o, class)
end

function boss3.new (originPointX, originPointY)
    local boss3AnimaLength = 4
    underAttackBGM_boss3 = love.audio.newSource("audio/bossHit.wav", "static")
    bossRun = love.audio.newSource("audio/bossRun.wav")
    dieBGM_boss3 = love.audio.newSource("audio/bossDie.wav", "static")
    local obj = {
        alive = true,
        hp = 20,
        face = 1, -- down 1, up 2, left 3, right 4
        nowX = originPointX,
        nowY = originPointY,
        toX = originPointX,
        toY = originPointY,
        startAttack = false,
        isRun = false,
        runDir = 1, -- up 1, down 2, left 3, right 4
        runTimer = 0,
        runCounter = 0,
        runCD = 0,
        attackSpeed = 1,
        startRun = false,
        moveStep = {},
        slimeQuads = {},
        thunderballs = {},
        moveIndex = 1,
        animationIndex = 1,
        animationTimer = 0,
        attacking = false,
        attacking_cool_down=0,
        slimeImgFile = love.graphics.newImage("img/hero.png")
    }
    for i=1,16 do
        obj.moveStep[i] = math.random(4)
    end
    for i=1, boss3AnimaLength do
        obj.slimeQuads[i] = {}
        for j=1,boss3AnimaLength do
            obj.slimeQuads[i][j] = love.graphics.newQuad( (200*j)-200, (200*i)-200, 200, 200, 800, 800)
        end
    end
    obj.thunderballs[1]=thunderball.new (700, 1000)
    obj.thunderballs[2]=thunderball.new (800, 1100)
    obj.thunderballs[3]=thunderball.new (900, 1200)
    obj = newObject(obj, boss3)
    return obj
end

function boss3:update(dt,charX,charY)
    if self.startRun then
        love.audio.rewind(bossRun)
        bossRun:setVolume(getVol())
        bossRun:play()
    else
        love.audio.stop(bossRun)
    end
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
    self.thunderballs[1]:update(dt, charX, charY)
    self.thunderballs[2]:update(dt, charX, charY)
    self.thunderballs[3]:update(dt, charX, charY)
    if self.alive == true and self.startAttack then
        if self.thunderballs[1].thunder_ball_cool_down > 2.5 then
            self.thunderballs[1].thunderball_x = charX
            self.thunderballs[1].thunderball_y = charY
            self.thunderballs[1].isThunderBallAttack = true
            self.thunderballs[1].thunder_ball_cool_down = 0
        end
        if self.thunderballs[2].thunder_ball_cool_down > 2.1 then
            self.thunderballs[2].thunderball_x = charX
            self.thunderballs[2].thunderball_y = charY
            self.thunderballs[2].isThunderBallAttack = true
            self.thunderballs[2].thunder_ball_cool_down = 0
        end
        if self.thunderballs[3].thunder_ball_cool_down > 1.7 then
            self.thunderballs[3].thunderball_x = charX
            self.thunderballs[3].thunderball_y = charY
            self.thunderballs[3].isThunderBallAttack = true
            self.thunderballs[3].thunder_ball_cool_down = 0
        end
    end
end

function boss3:getPositionX()
    return self.nowX
end

function boss3:getPositionY()
    return self.nowY
end

function boss3:underAttack(faceDir,damageBlood)
    underAttackBGM_boss3:setVolume(getVol())
    underAttackBGM_boss3:play()
    self.underAttacking = true
    self.hp = self.hp - damageBlood
    if self.hp <= 0 then
        dieBGM_boss3:setVolume(getVol())
        dieBGM_boss3:play()
        self.alive = flase
    end
    hpDecline(damageBlood)
end

function boss3:attack_check(charX,charY,boss1X,boss1Y)
    if boss1X <= charX and charX <= boss1X + 100  and boss1Y <= charY and charY <= boss1Y + 100 and self.alive then
        x = hpDecline(1)
        return true
    else
        return false
    end
end

function boss3:run(characterX, characterY)
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
