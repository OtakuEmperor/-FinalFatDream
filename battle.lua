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
    max = 6
    atk_range = 100
    -- sound load
    hitSound1 = love.audio.newSource("audio/a1.ogg", "static")
    hitSound2 = love.audio.newSource("audio/a2.ogg", "static")
    hitSound3 = love.audio.newSource("audio/a3.ogg", "static")
end

function battle_update(dt)
    -- attack sound
    if atk == true then
        hitSoundChoose = math.random(3)
        if hitSoundChoose == 1 then hitSound1:play()
        elseif hitSoundChoose == 2 then hitSound2:play()
        elseif hitSoundChoose == 3 then hitSound3:play()
        end

        -- attack animate
        timer = timer + dt
        if timer > 0.05 then
            timer = 0.01
            iteration = iteration + 1
            if iteration > max then
                atk = false
                iteration = 1
            end
        end
    end
end

function battle_keyPress(key)
    if love.keyboard.isDown(" ") and not atk then
        -- attack success?
        abs_x = character.x + world.x
        abs_y = character.y + world.y
        for _, mon in ipairs(monsters) do
            mon_abs_x = mon:getPositionX()
            mon_abs_y = mon:getPositionY()
            if attackMonster(abs_x, abs_y, mon_abs_x, mon_abs_y, character.faceDir) then
                mon:underAttack(character.faceDir, 5)
            end
        end
        atk = true
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
