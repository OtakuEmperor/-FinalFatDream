interface = {}

function interface_load()
    --set water and weapon img
    interface.waterImg = "water.png"
    interface.weaponImg = "weapon.png"
    --load audio
    interface.changeWeapon = love.audio.newSource("audio/changeWeapon.wav")
    interface.pick = love.audio.newSource("audio/pick.wav")
    interface.drink = love.audio.newSource("audio/drink.wav")
    --load img
    interface.key = love.graphics.newImage("img/key.png") --32px
    interface.key2 = love.graphics.newImage("img/key2.png") --32px
    interface.water = love.graphics.newImage("img/"..interface.waterImg) --32px
    interface.weapon = love.graphics.newImage("img/"..interface.weaponImg) --32px
    --interface.arrow = love.graphics.newImage("img/arrow.png") --32px
    --get width and height of windows
    interface.width = love.graphics.getWidth()
    interface.height = love.graphics.getHeight()
    --set font
    interface.font = love.graphics.newFont("font/FFFFORWA.TTF", 36)
    itemfont = love.graphics.newFont("font/FFFFORWA.TTF", 12)
    --set days
    interface.days = 0
    --set day(true) or night(false)
    interface.dn = true
    --set key number
    interface.keyNum = 0
    --set bleeding
    interface.opacity = 100
    interface.isAttacked = false
    interface.questionLock = false
    --water img and audio
    slimeJuice = love.graphics.newImage("img/slimeJuice.png")
    interface.waterPicked = false
    interface.isDrink = false
    --weapon img and audio
    sword = love.graphics.newImage("img/sword.png")
    gun = love.graphics.newImage("img/gun.png")
    interface.weaponIsPlayed = false
    --heartBeat
    heartBeat_timer = 0
    heartBeat_timeout = 0.2
    heartBeat_draw_state = 1
    heartBeat_x = 150
    heartBeat_y = 0
    heartbeat1 = love.graphics.newImage("img/heartbeat1.png")
    heartbeat2 = love.graphics.newImage("img/heartbeat2.png")
    heartbeat3 = love.graphics.newImage("img/heartbeat3.png")
    heartbeat4 = love.graphics.newImage("img/heartbeat4.png")
    heartbeat5 = love.graphics.newImage("img/heartbeat5.png")
    heartbeat6 = love.graphics.newImage("img/heartbeat6.png")
    heartbeat7 = love.graphics.newImage("img/heartbeat7.png")
    heartbeat8 = love.graphics.newImage("img/heartbeat8.png")
    heartbeat9 = love.graphics.newImage("img/heartbeat9.png")
    heartbeat10 = love.graphics.newImage("img/heartbeat10.png")
end

function interface_update(dt)
    heartBeat_timer = heartBeat_timer + dt
    if heartBeat_timer > heartBeat_timeout then
        heartBeat_draw_state = heartBeat_draw_state + 1
        if heartBeat_draw_state > 10 then
            heartBeat_draw_state = 1
        end
        heartBeat_timer = 0
    end
end

function interface_draw()
    charHP = getHeroHP()
    charMaxHP = getHeroMaxHP()
    wakeOriginNumber = (100-((charHP/charMaxHP)*100.0))
    --draw red red
    if wakeOriginNumber > 80 and wakeOriginNumber < 100 then
        love.graphics.setColor(255, 0, 0, (wakeOriginNumber-80)*5)
        love.graphics.rectangle("fill", 0, 0, interface.width, interface.height)
    end
    --draw heartbeat
    love.graphics.setColor(255, 255, 255, 255)
    if heartBeat_draw_state == 1 then
        love.graphics.draw(heartbeat1, heartBeat_x, heartBeat_y)
    elseif heartBeat_draw_state == 2 then
        love.graphics.draw(heartbeat2, heartBeat_x, heartBeat_y)
    elseif heartBeat_draw_state == 3 then
        love.graphics.draw(heartbeat3, heartBeat_x, heartBeat_y)
    elseif heartBeat_draw_state == 4 then
        love.graphics.draw(heartbeat4, heartBeat_x, heartBeat_y)
    elseif heartBeat_draw_state == 5 then
        love.graphics.draw(heartbeat5, heartBeat_x, heartBeat_y)
    elseif heartBeat_draw_state == 6 then
        love.graphics.draw(heartbeat6, heartBeat_x, heartBeat_y)
    elseif heartBeat_draw_state == 7 then
        love.graphics.draw(heartbeat7, heartBeat_x, heartBeat_y)
    elseif heartBeat_draw_state == 8 then
        love.graphics.draw(heartbeat8, heartBeat_x, heartBeat_y)
    elseif heartBeat_draw_state == 9 then
        love.graphics.draw(heartbeat9, heartBeat_x, heartBeat_y)
    elseif heartBeat_draw_state == 10 then
        love.graphics.draw(heartbeat10, heartBeat_x, heartBeat_y)
    end

    if wakeOriginNumber > 10 then
        wake = string.format("%.1f%%", wakeOriginNumber)
    else
        wake = string.format("0%.1f%%", wakeOriginNumber)
    end
    if wakeOriginNumber >= 80 and wakeOriginNumber <= 90 then
        heartBeat_timeout = 0.1
    elseif wakeOriginNumber >= 90 then
        heartBeat_timeout = 0.05
    elseif wakeOriginNumber < 80 then
        heartBeat_timeout = 0.2
    end
    love.graphics.setBackgroundColor(178, 203, 148)

    --draw bleeding
    if interface.opacity > 0 and interface.isAttacked == true then
        interface.opacity = interface.opacity - 5
        love.graphics.setColor(255, 0, 0, interface.opacity)
        love.graphics.rectangle("fill", 0, 0, interface.width, interface.height)
    else
        interface.opacity = 100
        interface.isAttacked = false
    end

    --draw wake
    love.graphics.setFont(interface.font)
    love.graphics.setColor(255, 0, 0)
    love.graphics.print(wake, interface.width * (1/20), interface.height * (1/20))

    --draw key
    if interface.days ~= 3 then
        love.graphics.setColor(255, 255, 255, 200)
        love.graphics.draw(interface.key2, interface.width * (9/200), interface.height * (1/8))
        love.graphics.draw(interface.key2, interface.width * (9/200) + 32, interface.height * (1/8))
        love.graphics.draw(interface.key2, interface.width * (9/200) + 64, interface.height * (1/8))
        love.graphics.setColor(255, 255, 255, 255)
        if interface.keyNum == 1 then
            love.graphics.draw(interface.key, interface.width * (9/200), interface.height * (1/8))
        elseif interface.keyNum == 2 then
            love.graphics.draw(interface.key, interface.width * (9/200), interface.height * (1/8))
            love.graphics.draw(interface.key, interface.width * (9/200) + 32, interface.height * (1/8))
        elseif interface.keyNum == 3 then
            love.graphics.draw(interface.key, interface.width * (9/200), interface.height * (1/8))
            love.graphics.draw(interface.key, interface.width * (9/200) + 32, interface.height * (1/8))
            love.graphics.draw(interface.key, interface.width * (9/200) + 64, interface.height * (1/8))
            if interface.questionLock == false then
                if day_state == 1 then
                    monsters[8]:summon()
                end
                interface.questionLock = true
            end
        end
    end
    --draw water
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.draw(interface.water, 30, interface.height - 70, 0, 0.64, 0.64)
    love.graphics.setColor(255, 255, 255, 255)
    if character.water then
        love.graphics.draw(slimeJuice, 30, interface.height - 70, 0, 0.64, 0.64)
        if interface.waterPicked then
            interface.pick:setVolume(getVol())
            interface.pick:play()
            interface.waterPicked = false
        end
        interface.isDrink = true
    else
        if interface.isDrink then
            interface.drink:setVolume(getVol())
            interface.drink:play()
            interface.isDrink = false
        end
        interface.waterPicked = true
    end
    --draw weapon
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.draw(interface.weapon, 100, interface.height - 70, 0, 0.64, 0.64)
    love.graphics.setColor(255, 255, 255, 255)
    if character.weapon == "sword" then
        love.graphics.draw(sword, 110, interface.height - 60, 0, 0.64, 0.64)
        if interface.weaponIsPlayed then
            interface.changeWeapon:setVolume(getVol())
            interface.changeWeapon:play()
            interface.weaponIsPlayed = false
        end
    elseif character.weapon == "gun" then
        love.graphics.setFont(itemfont)
        love.graphics.print(character.bullet, 140, interface.height - 60)
        love.graphics.draw(gun, 110, interface.height - 60, 0, 0.7, 0.7)
        if not interface.weaponIsPlayed then
            interface.changeWeapon:setVolume(getVol())
            interface.changeWeapon:play()
            interface.weaponIsPlayed = true
        end
    end
    --draw days
    if interface.dn == true then
        love.graphics.setColor(0, 128, 255)
    elseif interface.dn == false then
        love.graphics.setColor(0, 0, 0)
    end
    love.graphics.circle("fill", interface.width, 0, 70)
    love.graphics.setFont(love.graphics.newFont("font/FFFFORWA.TTF", 28))
    love.graphics.setColor(255, 255, 255)
    love.graphics.print("D" .. interface.days, interface.width - 48, 10)
end

--set amount of keys
function addKey()
    interface.keyNum = interface.keyNum + 1
end
function zeroKey()
    interface.keyNum = 0
end
