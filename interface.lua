interface = {}

function interface_load()
    --set water and weapon img
    interface.waterImg = "water.png"
    interface.weaponImg = "weapon.png"
    --load img
    interface.key = love.graphics.newImage("img/key.png") --32px
    interface.key2 = love.graphics.newImage("img/key2.png") --32px
    interface.water = love.graphics.newImage("img/"..interface.waterImg) --32px
    interface.weapon = love.graphics.newImage("img/"..interface.weaponImg) --32px
    --interface.arrow = love.graphics.newImage("img/arrow.png") --32px
    --get width and height of windows
    interface.width = love.graphics.getWidth()
    interface.height = love.graphics.getHeight()
    --set days
    interface.days = 1
    --set day(true) or night(false)
    interface.dn = true
    --set key number
    interface.keyNum = 0
    --set bleeding
    interface.opacity = 100
    interface.isAttacked = false
    interface.questionLock = false
end

function interface_draw()
    charHP = getHeroHP()
    charMaxHP = getHeroMaxHP()
    wake = (charMaxHP-((charHP/charMaxHP)*100.0))
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
    love.graphics.setFont(love.graphics.newFont("font/FFFFORWA.TTF", 36))
    love.graphics.setColor(255, 0, 0)
    love.graphics.print(wake, interface.width * (1/20), interface.height * (1/20))

    --draw key
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
            monsters[8]:summon()
            interface.questionLock = true
        end
    end
    --draw water
    love.graphics.setColor(0, 0, 0, 127)--set opacity50
    love.graphics.draw(interface.water, interface.width * (4/20), interface.height * (9/160))
    --draw weapon
    love.graphics.setColor(0, 0, 0, 127)--set opacity50
    love.graphics.draw(interface.weapon, interface.width * (4/20), interface.height * (21/160))
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
