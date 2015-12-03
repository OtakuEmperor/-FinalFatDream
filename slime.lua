slime = {}

-- this function is for OOP
function newObject(o, class)
    class.__index = class
    return setmetatable(o, class)
end

function slime.new (originPointX,originPointY)
    underAttackBGM = love.audio.newSource("audio/slimeHit.ogg", "static")
    local guardMode = 1
    local attackMode = 2
    local slimeAnimaLength = 6
    local obj = {
        alive = true,
        dying = false,
        hp = 10,
        face = "left",
        underAttacking = false,
        attacking = false,
        attacking_cool_down = 0,
        slimeImgFile = love.graphics.newImage("img/slime.png"),
        slimeMoveSound = love.audio.newSource("audio/slime1.ogg", "static"),
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
    for i=1,slimeAnimaLength do
        obj.slimeQuads[i] = {}
        for j=1,slimeAnimaLength do
            obj.slimeQuads[i][j] = love.graphics.newQuad( (100*j)-100, (100*i)-100, 100, 100, 600, 400)
        end
    end
    obj = newObject(obj, slime)
    return obj
end

function slime:update(dt,charX,charY,dt)
    self.timeTick = self.timeTick + dt
    if self.dying == false then
        if self.attacking == true then
            self.attacking_cool_down = self.attacking_cool_down + dt
        else
            if slimeAttackCheck(charX,charY,self.nowX,self.nowY,self.face,dt) then
                self.attacking =true
            end
        end
        if self.attacking_cool_down > 1 then
            self.attacking = false
            self.attacking_cool_down = 0
        end
        if self.timeTick > self.moveSpeed then
            self.underAttacking = false
            self.timeTick = 0
            self.animationIndex = self.animationIndex + 1
            if self.animationIndex > 4  then
                self.distance = math.sqrt(math.pow((charX-self.keyPointX), 2)+ math.pow((charY-self.keyPointY), 2))
                self.guardRange = self.alertRange*100*math.sqrt(2)
                if self.distance > self.guardRange and self.moveMode == 2 then
                    self.moveStep[self.moveIndex] = self.lastMoveStep
                    self.moveMode = 1 --one is for guardMode
                elseif self.distance <= self.guardRange then
                    self.moveMode = 2 --two is for attackMode
                else
                    self.moveMode = 1
                end
                if self.moveMode == 1 then
                    if self.moveStep[self.moveIndex] == 1 and (self.nowY-self.keyPointY<(100*self.alertRange)) then
                        self.pastY = self.nowY
                        self.nowY = self.nowY + 100
                        self.face = "down"
                    end
                    if self.moveStep[self.moveIndex] == 2 and (self.keyPointY-self.nowY<(100*self.alertRange)) then
                        self.pastY = self.nowY
                        self.nowY = self.nowY - 100
                        self.face = "up"
                    end
                    if self.moveStep[self.moveIndex] == 3 and (self.keyPointX-self.nowX<(100*self.alertRange))then
                        self.pastX = self.nowX
                        self.nowX = self.nowX - 100
                        self.face = "left"
                    end
                    if self.moveStep[self.moveIndex] == 4 and (self.nowX-self.keyPointX<(100*self.alertRange))then
                        self.pastX = self.nowX
                        self.nowX = self.nowX + 100
                        self.face = "right"
                    end
                    self.moveIndex = self.moveIndex + 1
                else
                    self.lastMoveStep = self.moveStep[self.moveIndex]
                    if charX > self.nowX then
                        self.moveStep[self.moveIndex] = 1
                        self.pastX = self.nowX
                        self.nowX = self.nowX + 100
                        self.face = "right"
                    elseif charX < self.nowX then
                        self.moveStep[self.moveIndex] = 2
                        self.pastX = self.nowX
                        self.nowX = self.nowX - 100
                        self.face = "left"
                    elseif charY > self.nowY then
                        self.moveStep[self.moveIndex] = 3
                        self.pastY = self.nowY
                        self.nowY = self.nowY + 100
                        self.face = "down"
                    elseif charY < self.nowY then
                        self.moveStep[self.moveIndex] = 4
                        self.pastY = self.nowY
                        self.nowY = self.nowY - 100
                        self.face = "up"
                    end
                end

                if self.moveIndex > table.getn(self.moveStep) then
                    self.moveIndex = 1
                end
                -- self.slimeMoveSound:play()
                self.animationIndex = 1
            end
        end
    else
        if self.timeTick > 0.5 then
            self.alive = false
        end
    end
end

function slime:getPositionX()
    return self.nowX
end

function slime:getPositionY()
    return self.nowY
end

function slime:underAttack(faceDir,damageBlood)
    underAttackBGM:setVolume(getVol())
    underAttackBGM:play()
    self.underAttacking = true
    self.animationIndex = 5
    self.hp = self.hp - damageBlood
    if self.hp <= 0 then
        character.water = true
        self:die()
    end
    self.timeTick = 0
    if faceDir == "up" then
        self.pastY = self.nowY
        self.nowY = self.nowY - 100
    elseif faceDir == "down" then
        self.pastY = self.nowY
        self.nowY = self.nowY + 100
    elseif faceDir == "left" then
        self.pastX = self.nowX
        self.nowX = self.nowX - 100
    elseif faceDir == "right" then
        self.pastX = self.nowX
        self.nowX = self.nowX + 100
    end

end

function slime:die()
    self.dying = true
    self.animationIndex = 6
end

function slimeAttackCheck(charX,charY,slimeX,slimeY,slimeFace,dt)
    if slimeX +100> charX and slimeX-100 <charX and slimeY+100> charY and slimeY-100<charY then
    --if math.abs<100 and math.abs<100 then
    --if slimeX == charX and slimeY == charY then
        hpDecline(5)
        if character.x ~= character.nx or world.x ~= world.nx then
            if character.faceDir=="right" then
                charaMoveBack("left",dt)
            elseif character.faceDir=="left" then
                charaMoveBack("right",dt)
            end
        elseif character.y ~=character.ny or world.y ~= world.ny then
            if character.faceDir=="up" then
                charaMoveBack("down",dt)
            elseif character.faceDir=="down" then
                charaMoveBack("up",dt)
            end
        else
            charaMoveBack(slimeFace,dt)
        end
        q1_dialog_state = 1
        q2_dialog_stateKey = 1
        q2_dialog_stateLine = 1
        q3_dialog_state = 1
        q1_dialogLock = true
        q2_dialogLockKey = true
        q2_dialogLockLine = true
        q3_dialogLock = true
        npc_dialogLock = true
        question = false
        showKey = false
        showQ3Answer = false
        conversation = false
        return true
    else
        return false
    end
end
