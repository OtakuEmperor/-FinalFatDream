menu = {}

function menu_load()
    --get width and height of windows
    menu.width = love.graphics.getWidth()
    menu.height = love.graphics.getHeight()
    --load img
    menu.sexy = love.graphics.newImage("img/sexy.png")
    --load audio
    piano = love.audio.newSource("audio/piano.wav", "static")
    --set audio switch
    menu.isOn1 = false
    menu.isOn2 = false
    menu.isOn3 = false
    --set text
    menu.size = 48
    menu.font = love.graphics.newFont("font/NotoSansMonoCJKtc-Regular.otf", menu.size)
    --set otaku workshop
    menu.size2 = 16
    menu.font2 = love.graphics.newFont("font/NotoSansMonoCJKtc-Regular.otf", menu.size2)
end


function menu_draw()
    love.graphics.setBackgroundColor(255, 255, 255)
    --set text font
    love.graphics.setFont(menu.font)
    --set volume
    piano:setVolume(0.5)
    --draw FPS
    love.graphics.print(tostring(love.timer.getFPS()), 5, 5)
    --draw sexy
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.draw(menu.sexy, menu.width/2 - 450, 20)
    --draw start
    if love.mouse.getX() > menu.width/4 and love.mouse.getX() < (menu.width/4 + menu.width/2) and love.mouse.getY() > menu.height/2 and love.mouse.getY() <(menu.height/2 + menu.size*(5/4)) then
        love.graphics.setColor(255, 255, 255)
        love.graphics.rectangle("fill", menu.width / 4, menu.height / 2, menu.width / 2, menu.size * (5/4))
        love.graphics.setColor(255, 68, 170, 255)
        love.graphics.print("開 始 遊 戲", menu.width / 4, menu.height / 2)
        if menu.isOn1 == false then
            piano:play()
            menu.isOn1 = true
        end
        if love.mouse.isDown("l") then
            gameStage = 2
        end
    else
        love.graphics.setColor(255, 68, 170, 255)
        love.graphics.rectangle("fill", menu.width / 4, menu.height / 2, menu.width / 2, menu.size * (5/4))
        love.graphics.setColor(255, 255, 255)
        love.graphics.print("開 始 遊 戲", menu.width / 4, menu.height / 2)
        menu.isOn1 = false
    end
    --draw continue
    if love.mouse.getX() > menu.width/4 and love.mouse.getX() < (menu.width/4 + menu.width/2) and love.mouse.getY() > (menu.height/2 + menu.size*2) and love.mouse.getY() < (menu.height/2 + menu.size * (13/4)) then
        love.graphics.setColor(255, 255, 255)
        love.graphics.rectangle("fill", menu.width / 4, menu.height / 2 + menu.size * 2, menu.width / 2, menu.size * (5/4))
        love.graphics.setColor(255, 68, 170, 255)
        love.graphics.print("繼 續 遊 戲", menu.width / 4, menu.height / 2 + menu.size * 2)
        if menu.isOn2 == false then
            piano:play()
            menu.isOn2 = true
        end
    else
        love.graphics.setColor(255, 68, 170, 255)
        love.graphics.rectangle("fill", menu.width / 4, menu.height / 2 + menu.size * 2, menu.width / 2, menu.size * (5/4))
        love.graphics.setColor(255, 255, 255)
        love.graphics.print("繼 續 遊 戲", menu.width / 4, menu.height / 2 + menu.size * 2)
        menu.isOn2 = false
    end
    --draw option
    if love.mouse.getX() > menu.width/4 and love.mouse.getX() < (menu.width/4 + menu.width/2) and love.mouse.getY() > (menu.height/2 + menu.size*4) and love.mouse.getY() < (menu.height/2 + menu.size * (21/4)) then
        love.graphics.setColor(255, 255, 255)
        love.graphics.rectangle("fill", menu.width / 4, menu.height / 2 + menu.size * 4, menu.width / 2, menu.size * (5/4))
        love.graphics.setColor(255, 68, 170, 255)
        love.graphics.print("遊 戲 選 項", menu.width / 4, menu.height / 2 + menu.size * 4)
        if menu.isOn3 == false then
            piano:play()
            menu.isOn3 = true
        end
    else
        love.graphics.setColor(255, 68, 170, 255)
        love.graphics.rectangle("fill", menu.width / 4, menu.height / 2 + menu.size * 4, menu.width / 2, menu.size * (5/4))
        love.graphics.setColor(255, 255, 255)
        love.graphics.print("遊 戲 選 項", menu.width / 4, menu.height / 2 + menu.size * 4)
        menu.isOn3 = false
    end
    --draw otaku workshop
    love.graphics.setColor(0, 0, 0)
    love.graphics.setFont(menu.font2)
    love.graphics.print("Otaku Workshop®2015", menu.width - menu.size2 * 10, menu.height - menu.size2 * (5/4))
end
