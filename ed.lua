ed = {}

function ed_load()
    --get width and height of windows
    ed.width = love.graphics.getWidth()
    ed.height = love.graphics.getHeight()
    --load audio
    ed.bgm = love.audio.newSource("audio/ed.ogg")
    --set the end
    ed.theEnd = "THE END"
    ed.size1 = 96
    ed.font1 = love.graphics.newFont("font/FFFFORWA.TTF", ed.size1)
    ed.font3 = love.graphics.newFont("font/NotoSansCJKtc-Black.otf", 15)
    ed.range1 = 0
    ed.opacity1 = 0
    --set subtitles
    local f = love.filesystem.newFile("ed.txt")
    f:open("r")
    ed.text = tostring(f:read())
    f:close()
    ed.size2 = 32
    ed.font2 = love.graphics.newFont("font/NotoSansCJKtc-Black.otf", ed.size2)
    ed.range2 = 0
    --set hero
    ed.hero = love.graphics.newImage("img/edHero.png")
    ed.range3 = 0
    ed.opacity2 = 255
    --set time
    ed.t0 = 0
    ed.t = 0
    ed.s = 0 --(t - t0)
    ed.getT0 = false
end

function ed_update(dt)
    if ed.getT0 == false then
        ed.t0 = love.timer.getTime()
        ed.getT0 = true
    end
    ed.t = love.timer.getTime()
    ed.s = ed.t - ed.t0
    --bgm
    ed.bgm:setVolume(getVol()*0.8)
    if ed.s < 47 then
        ed.bgm:play()
    else
        ed.bgm:stop()
    end
    --quit
    if ed.s > 48 then
        gameStage = 1
    end
end

function ed_draw()
    love.graphics.setBackgroundColor(0, 0, 0)
    --draw the end
    if ed.opacity1 < 255 then
        love.graphics.setColor(255, 255, 255, ed.opacity1)
        ed.opacity1 = ed.opacity1 + 1
    else
        love.graphics.setColor(255, 255, 255, 255)
    end
    love.graphics.setFont(ed.font1)
    if ed.s < 8 then
        love.graphics.print(ed.theEnd, ed.width/4, ed.height/3)
    elseif ed.s > 8 and (ed.height - ed.range1) > -72 then
        love.graphics.print(ed.theEnd, ed.width/4, ed.height/3 - ed.range1)
        ed.range1 = ed.range1 + 1
    end

    --draw subtitle
    if ed.s > 8 then
        love.graphics.setFont(ed.font2)
        love.graphics.print(ed.text, ed.width/3, ed.height-ed.range2)
        ed.range2 = ed.range2 + 1
    end

    --draw hero
    if ed.s > 30 then
        if ed.s > 40 then
            love.graphics.setColor(255, 255, 255, ed.opacity2)
            if ed.opacity2 > 0 then
                ed.opacity2 = ed.opacity2 - 1
            end
        end
        if (ed.height-ed.range3) > (ed.height/2-100) then
            love.graphics.draw(ed.hero, ed.width/2-50, ed.height-ed.range3)
            love.graphics.print("THANK YOU FOR YOUR PLAYING!", ed.width/2-260, ed.height-ed.range3+120)
            love.graphics.print("FATS LOVE YOU", ed.width/2-120, ed.height-ed.range3+180)
            ed.range3 = ed.range3 + 1
        else
            love.graphics.draw(ed.hero, ed.width/2-50, ed.height/2-100)
            love.graphics.print("THANK YOU FOR YOUR PLAYING!", ed.width/2-260, ed.height/2+20)
            love.graphics.print("FATS LOVE YOU", ed.width/2-120, ed.height/2+80)
        end
    end


    --draw s
    love.graphics.setColor(255,255,255)
    love.graphics.setFont(ed.font3)
    love.graphics.print(tostring(ed.s), 10, 10)
end
