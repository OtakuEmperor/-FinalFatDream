ed = {}

function ed_load()
    --get width and height of windows
    ed.width = love.graphics.getWidth()
    ed.height = love.graphics.getHeight()
    --load audio
    ed.bgm = love.audio.newSource("audio/ed.mp3")
    --set the end
    ed.theEnd = "xxTHE ENDxx"
    ed.size1 = 72
    ed.font1 = love.graphics.newFont("font/NotoSansCJKtc-Black.otf", ed.size1)
    ed.font3 = love.graphics.newFont("font/NotoSansCJKtc-Black.otf", 15)
    ed.range1 = 0
    ed.opacity = 0
    --set subtitles
    local f = love.filesystem.newFile("ed.txt")
    f:open("r")
    ed.text = tostring(f:read())
    f:close()
    ed.size2 = 32
    ed.font2 = love.graphics.newFont("font/NotoSansCJKtc-Black.otf", ed.size2)
    ed.range2 = 0
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
end

function ed_draw()
    love.graphics.setBackgroundColor(0, 0, 0)
    ed.bgm:setVolume(getVol()*0.8)
    ed.bgm:play()
    --draw the end
    if ed.opacity < 255 then
        love.graphics.setColor(255, 255, 255, ed.opacity)
        ed.opacity = ed.opacity + 1
    else
        love.graphics.setColor(255, 255, 255, 255)
    end
    love.graphics.setFont(ed.font1)
    if ed.s < 7 then
        love.graphics.print(ed.theEnd, ed.width/2-ed.size1*string.len(ed.theEnd)/3, ed.height/3)
    elseif ed.s > 7 and (ed.height - ed.range1) > -72 then
        love.graphics.print(ed.theEnd, ed.width/2-ed.size1*string.len(ed.theEnd)/3, ed.height/3 - ed.range1)
        ed.range1 = ed.range1 + 1
    end

    --draw subtitle
    if ed.s > 7 then
        love.graphics.setFont(ed.font2)
        love.graphics.print(ed.text, ed.width/4, ed.height-ed.range2)
        ed.range2 = ed.range2 + 1
    end

    --draw s
    love.graphics.setColor(255,255,255)
    love.graphics.setFont(ed.font3)
    love.graphics.print(tostring(ed.s), 10, 10)
end
