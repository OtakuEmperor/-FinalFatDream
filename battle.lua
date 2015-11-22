battle = {}

function battle_load()
    --attack
    attackImg = love.graphics.newImage("img/attack.png")
    quads = {}
    quads[1] = love.graphics.newQuad(-192, 0, 192, 192, 960, 768)
    for i=1, 5 do
        quads[i+1] = love.graphics.newQuad((i-1)*192, 0, 192, 192, 960, 768)
    end
    iteration = 1
    atk = false
    timer = 0.1
    atk_timeout = 1.1
    max = 6
    atk_range = 100
    -- sound load
    hitSound1 = love.audio.newSource("audio/normalAttack.ogg", "static")
    gunAttackSound = love.audio.newSource("audio/gun.wav", "static")
    noBulletSound = love.audio.newSource("audio/noBullet.wav", "static")
end

function battle_update(dt)
    -- attack sound
    atk_timeout = atk_timeout + dt
    -- print(atk_timeout)
    -- print(atk)
    if atk == true then
        -- attack animate
        timer = timer + dt
        if timer > 0.05 then
            timer = 0.01
            iteration = iteration + 1
            if iteration == 2 then
                -- attack success?
                abs_x = character.x + world.x
                abs_y = character.y + world.y
                for _, mon in ipairs(monsters) do
                    mon_abs_x = mon:getPositionX()
                    mon_abs_y = mon:getPositionY()
                    if attackMonster(abs_x, abs_y, mon_abs_x, mon_abs_y, character.faceDir) then
                        if mon.alive then
                            mon:underAttack(character.faceDir, character.atk)
                        end
                    end
                end
            end
            if iteration > max then
                atk = false
                iteration = 1
                atk_timeout = 0
            end
        end
    else
        atk = false
    end
end

function battle_keyPress(key)
    if love.keyboard.isDown(" ") and atk_timeout > 0.5 then
        if character.weapon == "sword" then
            hitSound1:play()
            atk = true
        elseif character.weapon == "gun" and character.bullet > 0 then
            gunAttackSound:play()
            character.bullet = character.bullet - 1
            atk = true
        elseif character.weapon == "gun" and character.bullet == 0 then
            noBulletSound:play()
        end
    end
end

function battle_attack(x, y, face)
    if face == "left" then
        x = x-100
    elseif face == "right" then
        x = x+100
    elseif face == "up" then
        y = y-100
    elseif face == "down" then
        y = y+100
    end

    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.draw(attackImg, quads[iteration], x, y, 0, 1/2, 1/2)
end

function attackMonster(abs_x, abs_y, mon_abs_x, mon_abs_y, face)
    if face == "up" then
        return mon_abs_x == abs_x and (abs_y - atk_range) <= mon_abs_y and mon_abs_y <= abs_y
    elseif face == "down" then
        return mon_abs_x == abs_x and abs_y <= mon_abs_y and mon_abs_y <= (abs_y + atk_range)
    elseif face == "left" then
        return (abs_x - atk_range)<= mon_abs_x and mon_abs_x <= abs_x and abs_y == mon_abs_y
    elseif face == "right" then
        return abs_x <= mon_abs_x and mon_abs_x <= (abs_x + atk_range) and abs_y == mon_abs_y
    end
end
