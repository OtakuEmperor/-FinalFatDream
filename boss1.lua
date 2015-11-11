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
        thunder_ball_img = love.graphics.newImage("img/thunderBall.png"),
        thunder_ball_quads = {},
        thunder_ball_index = 1,
        thunder_ball_timer = 0,
        thunder_ball_x = 1000,
        thunder_ball_y = 700,
        thunder_ball_dmg_taken = false,
        isThunderBallAttack = false,
        wave_img = love.graphics.newImage("img/bossWave.png"),
        wave_quads = {},
        wave_index = 1,
        wave_timer = 0,
        wave_dmg_taken = false,
        isWaveAttack = false,
        attacking = false,
        thunder_ball_cool_down = 1,
        wave_cool_down = 1,
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
        obj.thunder_ball_quads[i] = love.graphics.newQuad(0, 0, 100, 100, 500, 100)
    end
    for i=11, 14 do
        obj.thunder_ball_quads[i] = love.graphics.newQuad(100*(i-10), 0, 100, 100, 500, 100)
    end
    for i = 1, 8 do
        obj.wave_quads[i] = {}
        for j = 1, 10 do
            obj.wave_quads[i][j] = love.graphics.newQuad(100, 100, 100, 100, 900, 300)
        end
    end
    for i = 1, 3 do
        for j = 11, 13 do
            obj.wave_quads[i][j] = love.graphics.newQuad(100*(i-1)+300*(j-11), 0, 100, 100, 900, 300)
        end
    end
    for j = 11, 13 do
       obj.wave_quads[4][j] = love.graphics.newQuad(300*(j-11), 100, 100, 100, 900, 300)
    end
    for j = 11, 13 do
       obj.wave_quads[5][j] = love.graphics.newQuad(200+300*(j-11), 100, 100, 100, 900, 300)
    end
    for i = 6, 8 do
        for j = 11, 13 do
            obj.wave_quads[i][j] = love.graphics.newQuad(100*(i-6)+300*(j-11), 200, 100, 100, 900, 300)
        end
    end
    obj = newObject(obj, boss1)
    return obj
end

function boss1:update(dt,charX,charY)
    self.timeTick = self.timeTick + dt
    if self.attacking == true then
        self.attacking_cool_down = self.attacking_cool_down + dt
    else
        if self:attack_check(charX,charY,self.nowX,self.nowY) then
            self.attacking =true
        end
    end
    self.thunder_ball_cool_down = self.thunder_ball_cool_down + dt
    self.thunder_ball_timer = self.thunder_ball_timer + dt
    self.wave_cool_down = self.wave_cool_down + dt
    self.wave_timer = self.wave_timer + dt
    if self.isThunderBallAttack then
        if self.thunder_ball_timer > 0.05 then
            self.thunder_ball_timer = 0
            self.thunder_ball_index = self.thunder_ball_index + 1
            if self.thunder_ball_index >= 11 and not self.thunder_ball_dmg_taken then
                if charX == self.thunder_ball_x and charY == self.thunder_ball_y then
                    hpDecline(5)
                    self.thunder_ball_dmg_taken = true
                end
            end
        end
        if self.thunder_ball_index > 14 then
            self.isThunderBallAttack = false
            self.thunder_ball_dmg_taken = false
            self.thunder_ball_index = 1
        end
    end
    if self.isWaveAttack then
        if self.wave_timer > 0.1 then
            self.wave_timer = 0
            self.wave_index = self.wave_index + 1
            if self.wave_index >= 11 and not self.wave_dmg_taken then
                if charX >= self.nowX - 100 and charX <= self.nowX + 200 and charY >= self.nowY - 100 and charY <= self.nowY + 200 then
                    hpDecline(3)
                    self.wave_dmg_taken = true
                end
            end
        end
        if self.wave_index > 13 then
            self.isWaveAttack = false
            self.wave_dmg_taken = false
            self.wave_index = 1
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
        if self.thunder_ball_cool_down > 2.5 then
            self:changeAtkXY(charX, charY)
            self.isThunderBallAttack = true
            self.thunder_ball_cool_down = 0
        end
        if self.attacking_cool_down >1 then
            self.attacking = false
            self.attacking_cool_down = 0
        end
        if self.wave_cool_down > 5 then
            self.isWaveAttack = true
            self.wave_cool_down = 0
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

function boss1:thunder_ball_attack()
    love.graphics.draw(self.thunder_ball_img, self.thunder_ball_quads[self.thunder_ball_index], self.thunder_ball_x-world.x, self.thunder_ball_y-world.y)
end

function boss1:wave_attack()
    love.graphics.draw(self.wave_img, self.wave_quads[1][self.wave_index], self.nowX-world.x-100, self.nowY-world.y-100)
    love.graphics.draw(self.wave_img, self.wave_quads[2][self.wave_index], self.nowX-world.x, self.nowY-world.y-100)
    love.graphics.draw(self.wave_img, self.wave_quads[2][self.wave_index], self.nowX-world.x+100, self.nowY-world.y-100)
    love.graphics.draw(self.wave_img, self.wave_quads[3][self.wave_index], self.nowX-world.x+200, self.nowY-world.y-100)
    love.graphics.draw(self.wave_img, self.wave_quads[4][self.wave_index], self.nowX-world.x-100, self.nowY-world.y)
    love.graphics.draw(self.wave_img, self.wave_quads[5][self.wave_index], self.nowX-world.x+200, self.nowY-world.y)
    love.graphics.draw(self.wave_img, self.wave_quads[4][self.wave_index], self.nowX-world.x-100, self.nowY-world.y+100)
    love.graphics.draw(self.wave_img, self.wave_quads[5][self.wave_index], self.nowX-world.x+200, self.nowY-world.y+100)
    love.graphics.draw(self.wave_img, self.wave_quads[6][self.wave_index], self.nowX-world.x-100, self.nowY-world.y+200)
    love.graphics.draw(self.wave_img, self.wave_quads[7][self.wave_index], self.nowX-world.x, self.nowY-world.y+200)
    love.graphics.draw(self.wave_img, self.wave_quads[7][self.wave_index], self.nowX-world.x+100, self.nowY-world.y+200)
    love.graphics.draw(self.wave_img, self.wave_quads[8][self.wave_index], self.nowX-world.x+200, self.nowY-world.y+200)
end

function boss1:attack_check(charX,charY,boss1X,boss1Y)
    if boss1X <= charX and charX <= boss1X + 100  and boss1Y <= charY and charY <= boss1Y + 100 and self.alive then
        x = hpDecline(1)
        return true
    else
        return false
    end
end

function boss1:changeAtkXY(x, y)
    self.thunder_ball_x = x
    self.thunder_ball_y = y
end
