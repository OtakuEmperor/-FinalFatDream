battle = {}

function battle_load()
    --attack
    attackImg = love.graphics.newImage("img/attack.png")
    quads = {}
    quads[" "] = {}
    quads[" "][1] = love.graphics.newQuad(-192, 0, 192, 192, 960, 768)
    for i=1, 5 do
        quads[" "][i+1] = love.graphics.newQuad((i-1)*192, 0, 192, 192, 960, 768)
    end
    iteration = 1
    atk = false
    timer = 0.1
    max = 6

    --sound
    hitSound1 = love.audio.newSource("audio/a1.ogg", "static")
    hitSound2 = love.audio.newSource("audio/a2.ogg", "static")
    hitSound3 = love.audio.newSource("audio/a3.ogg", "static")
end

function battle_update(dt)
    if atk == true then
        hitSoundChoose = math.random(3)
        if hitSoundChoose == 1 then hitSound1:play()
        elseif hitSoundChoose == 2 then hitSound2:play()
        elseif hitSoundChoose == 3 then hitSound3:play()
        end

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
    if quads[key] then
        atk = true
    end
end

function battle_attack(x, y)
    love.graphics.draw(attackImg, quads[" "][iteration], x, y)
end
