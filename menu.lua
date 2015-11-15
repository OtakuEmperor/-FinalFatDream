menu = {}

function menu_load()
    --get width and height of windows
    menu.width = love.graphics.getWidth()
    menu.height = love.graphics.getHeight()
    --load img
    menu.sexy = love.graphics.newImage("img/title.png")
    menu.starSky = love.graphics.newImage("img/starSky.png")
    menu.starSky2 = love.graphics.newImage("img/starSky2.png")
    --set text
    menu.size = 48
    menu.font = love.graphics.newFont("font/FFFFORWA.TTF", menu.size)
    --set otaku workshop
    menu.size2 = 16
    menu.font2 = love.graphics.newFont("font/NotoSansMonoCJKtc-Regular.otf", menu.size2)
    --set select
    menu.stage = 1
    --set bg
    menu.op = 0
    menu.flag = true
end

function menu_keypressed(key)
    --control up and down
    if key == "down" and menu.stage ~= 3  then
        menu.stage = menu.stage + 1
    elseif key == "down" and menu.stage == 3 then
        menu.stage = 1
    elseif key == "up" and menu.stage ~= 1 then
        menu.stage = menu.stage - 1
    elseif key == "up" and menu.stage == 1 then
        menu.stage = 3
    end
    --control space
    if key == " " and menu.stage == 1 then
        gameStage = 2
    end

    if key == " " and menu.stage == 2 then
        local data = {}
        local data2 = {}
        local f = love.filesystem.newFile("data.txt")
        local f2 = love.filesystem.newFile("data2.txt")
        f:open("r")
        f2:open("r")
        for line in love.filesystem.lines("data.txt") do
            table.insert(data, line)
        end
        for line in love.filesystem.lines("data2.txt") do
            table.insert(data2, line)
        end
        f:close()
        f2:close()
        loveLoad({data, data2[1], data2[2], data[3], data[4], data[5]})
    end
end

function menu_draw()
    --draw backbround
    love.graphics.setBackgroundColor(0, 0, 0)
    love.graphics.draw(menu.starSky, 0, 0)
    if menu.flag == true then
        menu.op = menu.op + 2
        if menu.op == 254 then
            menu.flag = false
        end
    else
        menu.op = menu.op - 2
        if menu.op == 0 then
            menu.flag = true
        end
    end
    love.graphics.setColor(255, 255, 255, menu.op)
    love.graphics.draw(menu.starSky2, 0, 0)
    --set text font
    love.graphics.setFont(menu.font)
    --draw FPS
    --love.graphics.print(tostring(love.timer.getFPS()), 5, 5)
    --draw sexy title
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.draw(menu.sexy, menu.width/2 - 450, menu.height/10, 0, 3/4, 3/4)
    --draw start
    if menu.stage == 1 then
        love.graphics.setColor(127, 127, 127)
        love.graphics.rectangle("fill", menu.width/3, menu.height/2, menu.width/3, menu.height/10)
        love.graphics.setColor(255, 255, 255)
        love.graphics.print("Start", menu.width/3, menu.height/2)
    else
        love.graphics.setColor(0, 0, 0, 0)
        love.graphics.rectangle("fill", menu.width/3, menu.height/2, menu.width/3, menu.height/10)
        love.graphics.setColor(127, 127, 127)
        love.graphics.print("Start", menu.width/3, menu.height/2)
    end
    --draw continue
    if menu.stage == 2 then
        love.graphics.setColor(127, 127, 127)
        love.graphics.rectangle("fill", menu.width/3, menu.height/2 + 100, menu.width/3, menu.height/10)
        love.graphics.setColor(255, 255, 255)
        love.graphics.print("Continue", menu.width/3, menu.height/2 + 100)
    else
        love.graphics.setColor(0, 0, 0, 0)
        love.graphics.rectangle("fill", menu.width/3, menu.height/2 + 100, menu.width/3, menu.height/10)
        love.graphics.setColor(127, 127, 127)
        love.graphics.print("Continue", menu.width/3, menu.height/2 + 100)
    end
    --draw option
    if menu.stage == 3 then
        love.graphics.setColor(127, 127, 127)
        love.graphics.rectangle("fill", menu.width/3, menu.height/2 + 200, menu.width/3, menu.height/10)
        love.graphics.setColor(255, 255, 255)
        love.graphics.print("About", menu.width/3, menu.height/2 + 200)
    else
        love.graphics.setColor(0, 0, 0, 0)
        love.graphics.rectangle("fill", menu.width/3, menu.height/2 + 200, menu.width/3, menu.height/10)
        love.graphics.setColor(127, 127, 127)
        love.graphics.print("About", menu.width/3, menu.height/2 + 200)
    end
    --draw otaku workshop
    love.graphics.setColor(255, 255, 255)
    love.graphics.setFont(menu.font2)
    love.graphics.print("STINKY & ITCHY®2015", menu.width - menu.size2 * 10, menu.height - menu.size2 * (5/4))
end
