menu = {}

function menu_load()
    --get width and height of windows
    menu.width = love.graphics.getWidth()
    menu.height = love.graphics.getHeight()
    --load img
    menu.sexy = love.graphics.newImage("img/sexy.png")
    --set text
    menu.size = 48
    menu.font = love.graphics.newFont("font/FFFFORWA.TTF", menu.size)
    --set otaku workshop
    menu.size2 = 16
    menu.font2 = love.graphics.newFont("font/NotoSansMonoCJKtc-Regular.otf", menu.size2)
    --set select
    menu.stage = 1
    menu.select = 0
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

end

function menu_draw()
    love.graphics.setBackgroundColor(255, 255, 255)
    --set text font
    love.graphics.setFont(menu.font)
    --draw FPS
    love.graphics.print(tostring(love.timer.getFPS()), 5, 5)
    --draw sexy
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.draw(menu.sexy, menu.width/2 - 450, 20)
    --draw start
    if menu.stage == 1 then
        love.graphics.setColor(50, 50, 50)
        love.graphics.rectangle("fill", menu.width/3, menu.height/2, menu.width/3, menu.height/10)
        love.graphics.setColor(255, 255, 255)
        love.graphics.print("Start", menu.width/3, menu.height/2)
    else
        love.graphics.setColor(255, 255, 255)
        love.graphics.rectangle("fill", menu.width/3, menu.height/2, menu.width/3, menu.height/10)
        love.graphics.setColor(50, 50, 50)
        love.graphics.print("Start", menu.width/3, menu.height/2)
    end
    --draw continue
    if menu.stage == 2 then
        love.graphics.setColor(50, 50, 50)
        love.graphics.rectangle("fill", menu.width/3, menu.height/2 + 100, menu.width/3, menu.height/10)
        love.graphics.setColor(255, 255, 255)
        love.graphics.print("Continue", menu.width/3, menu.height/2 + 100)
    else
        love.graphics.setColor(255, 255, 255)
        love.graphics.rectangle("fill", menu.width/3, menu.height/2 + 100, menu.width/3, menu.height/10)
        love.graphics.setColor(50, 50, 50)
        love.graphics.print("Continue", menu.width/3, menu.height/2 + 100)
    end
    --draw option
    if menu.stage == 3 then
        love.graphics.setColor(50, 50, 50)
        love.graphics.rectangle("fill", menu.width/3, menu.height/2 + 200, menu.width/3, menu.height/10)
        love.graphics.setColor(255, 255, 255)
        love.graphics.print("About", menu.width/3, menu.height/2 + 200)
    else
        love.graphics.setColor(255, 255, 255)
        love.graphics.rectangle("fill", menu.width/3, menu.height/2 + 200, menu.width/3, menu.height/10)
        love.graphics.setColor(50, 50, 50)
        love.graphics.print("About", menu.width/3, menu.height/2 + 200)
    end
    --draw otaku workshop
    love.graphics.setColor(0, 0, 0)
    love.graphics.setFont(menu.font2)
    love.graphics.print("Otaku Workshop®2015", menu.width - menu.size2 * 10, menu.height - menu.size2 * (5/4))
end
