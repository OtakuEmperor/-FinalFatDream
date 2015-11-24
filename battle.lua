battle = {}

function battle_load()
    --attack
    swordAtkImg = love.graphics.newImage("img/attack.png")
    fireBullet1 = love.graphics.newImage("img/fireBullet1.png")
    fireBullet2 = love.graphics.newImage("img/fireBullet2.png")
    fireBullet3 = love.graphics.newImage("img/fireBullet3.png")
    fireBullet4 = love.graphics.newImage("img/fireBullet4.png")
    fireBullet5 = love.graphics.newImage("img/fireBullet5.png")
    fireBullet6 = love.graphics.newImage("img/fireBullet6.png")

    swordAtkAnimate = {}
    for i=1, 5 do
        swordAtkAnimate[i] = love.graphics.newQuad(i*192, 0, 192, 192, 960, 768)
    end
    swordAtkIndex = 1
    swordAtk = false
    swordAtkTimer = 0

    gunAtkIndex = 1
    gunAtk = false
    gunAtkTimer = 0
    gunDestCounter = 0

    atkTimer = 0.5
    atk_range = 100

    battle_x = 0
    battle_y = 0
    battleFace = "down"
    -- sound load
    hitSound1 = love.audio.newSource("audio/normalAttack.ogg", "static")
    gunAttackSound = love.audio.newSource("audio/gun.wav", "static")
    noBulletSound = love.audio.newSource("audio/noBullet.wav", "static")
end

function battle_update(dt)
    atkTimer = atkTimer + dt
    if swordAtk then
        swordAtkTimer = swordAtkTimer + dt
        if swordAtkTimer > 0.05 then
            swordAtkIndex = swordAtkIndex + 1
            if swordAtkIndex > 5 then
                swordAtk = false
                swordAtkIndex = 1
            end
            swordAtkTimer = 0
        end
    end

    if gunAtk then
        gunAtkTimer = gunAtkTimer + dt
        if gunAtkTimer > 0.05 then
            gunAtkIndex = gunAtkIndex + 1
            if gunAtkIndex > 6 then
                gunAtkIndex = 4
            end
            if gunAtkIndex % 4 == 0 then
                if battleFace == "up" then
                    battle_y = battle_y - 100
                elseif battleFace == "down" then
                    battle_y = battle_y + 100
                elseif battleFace == "left" then
                    battle_x = battle_x - 100
                elseif battleFace == "right" then
                    battle_x = battle_x + 100
                end
                gunDestCounter = gunDestCounter + 100
                if doAttackDamage(100+gunDestCounter) then
                    gunAtk = false
                end
            end
            if gunDestCounter == atk_range then
                gunAtk = false
                gunDestCounter = 0
            end
            gunAtkTimer = 0
        end
    end
end

function battle_keyPress(key)
    if love.keyboard.isDown(" ") and atkTimer > 1 then
        if character.weapon == "sword" then
            hitSound1:play()
            swordAtk = true
            battle_x = getHeroX()
            battle_y = getHeroY()
            battleFace = character.faceDir
            doAttackDamage(atk_range)
        elseif character.weapon == "gun" and character.bullet > 0 then
            gunAttackSound:play()
            character.bullet = character.bullet - 1
            gunAtk = true
            battle_x = getHeroX()
            battle_y = getHeroY()
            battleFace = character.faceDir
            if battleFace == "up" then
                battle_y = battle_y - 100
            elseif battleFace == "down" then
                battle_y = battle_y + 100
            elseif battleFace == "left" then
                battle_x = battle_x - 100
            elseif battleFace == "right" then
                battle_x = battle_x + 100
            end
            if doAttackDamage(100) then
                gunAtk = false
            end
        elseif character.weapon == "gun" and character.bullet == 0 then
            noBulletSound:play()
        end
    end
end

function battle_draw()
    love.graphics.setColor(255, 255, 255, 255)
    if swordAtk then
        if battleFace == "left" then
            love.graphics.draw(swordAtkImg, swordAtkAnimate[swordAtkIndex], battle_x-100, battle_y, 0, 1/2, 1/2)
        elseif battleFace == "right" then
            love.graphics.draw(swordAtkImg, swordAtkAnimate[swordAtkIndex], battle_x+100, battle_y, 0, 1/2, 1/2)
        elseif battleFace == "up" then
            love.graphics.draw(swordAtkImg, swordAtkAnimate[swordAtkIndex], battle_x, battle_y-100, 0, 1/2, 1/2)
        elseif battleFace == "down" then
            love.graphics.draw(swordAtkImg, swordAtkAnimate[swordAtkIndex], battle_x, battle_y+100, 0, 1/2, 1/2)
        end
    end

    if gunAtk then
        if battleFace == "left" then
            if gunAtkIndex == 1 then
                love.graphics.draw(fireBullet1, battle_x, battle_y)
            elseif gunAtkIndex == 2 then
                love.graphics.draw(fireBullet2, battle_x, battle_y)
            elseif gunAtkIndex == 3 then
                love.graphics.draw(fireBullet3, battle_x, battle_y)
            elseif gunAtkIndex == 4 then
                love.graphics.draw(fireBullet4, battle_x, battle_y)
            elseif gunAtkIndex == 5 then
                love.graphics.draw(fireBullet5, battle_x, battle_y)
            elseif gunAtkIndex == 6 then
                love.graphics.draw(fireBullet6, battle_x, battle_y)
            end
        elseif battleFace == "right" then
            if gunAtkIndex == 1 then
                love.graphics.draw(fireBullet1, battle_x, battle_y)
            elseif gunAtkIndex == 2 then
                love.graphics.draw(fireBullet2, battle_x, battle_y)
            elseif gunAtkIndex == 3 then
                love.graphics.draw(fireBullet3, battle_x, battle_y)
            elseif gunAtkIndex == 4 then
                love.graphics.draw(fireBullet4, battle_x, battle_y)
            elseif gunAtkIndex == 5 then
                love.graphics.draw(fireBullet5, battle_x, battle_y)
            elseif gunAtkIndex == 6 then
                love.graphics.draw(fireBullet6, battle_x, battle_y)
            end
        elseif battleFace == "up" then
            if gunAtkIndex == 1 then
                love.graphics.draw(fireBullet1, battle_x, battle_y)
            elseif gunAtkIndex == 2 then
                love.graphics.draw(fireBullet2, battle_x, battle_y)
            elseif gunAtkIndex == 3 then
                love.graphics.draw(fireBullet3, battle_x, battle_y)
            elseif gunAtkIndex == 4 then
                love.graphics.draw(fireBullet4, battle_x, battle_y)
            elseif gunAtkIndex == 5 then
                love.graphics.draw(fireBullet5, battle_x, battle_y)
            elseif gunAtkIndex == 6 then
                love.graphics.draw(fireBullet6, battle_x, battle_y)
            end
        elseif battleFace == "down" then
            if gunAtkIndex == 1 then
                love.graphics.draw(fireBullet1, battle_x, battle_y)
            elseif gunAtkIndex == 2 then
                love.graphics.draw(fireBullet2, battle_x, battle_y)
            elseif gunAtkIndex == 3 then
                love.graphics.draw(fireBullet3, battle_x, battle_y)
            elseif gunAtkIndex == 4 then
                love.graphics.draw(fireBullet4, battle_x, battle_y)
            elseif gunAtkIndex == 5 then
                love.graphics.draw(fireBullet5, battle_x, battle_y)
            elseif gunAtkIndex == 6 then
                love.graphics.draw(fireBullet6, battle_x, battle_y)
            end
        end
    end
end

function attackMonster(abs_x, abs_y, mon_abs_x, mon_abs_y, face, range)
    if face == "up" then
        return mon_abs_x == abs_x and (abs_y - range) <= mon_abs_y and mon_abs_y <= abs_y
    elseif face == "down" then
        return mon_abs_x == abs_x and abs_y <= mon_abs_y and mon_abs_y <= (abs_y + range)
    elseif face == "left" then
        return (abs_x - range)<= mon_abs_x and mon_abs_x <= abs_x and abs_y == mon_abs_y
    elseif face == "right" then
        return abs_x <= mon_abs_x and mon_abs_x <= (abs_x + range) and abs_y == mon_abs_y
    end
end

function doAttackDamage(range)
    -- attack success?
    abs_x = character.x + world.x
    abs_y = character.y + world.y
    isAttackMonster = false
    for _, mon in ipairs(monsters) do
        mon_abs_x = mon:getPositionX()
        mon_abs_y = mon:getPositionY()
        if attackMonster(abs_x, abs_y, mon_abs_x, mon_abs_y, character.faceDir, range) then
            if mon.alive then
                mon:underAttack(character.faceDir, character.atk)
                isAttackMonster = true
            end
        end
    end
    return isAttackMonster
end
