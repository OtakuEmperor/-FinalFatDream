beiCheeKiller = {}
function beiCheeKiller_load()
    --get width and height
    beiCheeKiller.width = love.graphics.getWidth()
    beiCheeKiller.height = love.graphics.getHeight()
    --set word
    beiCheeKiller.size = 60
    beiCheeKiller.size2 = 36
    beiCheeKiller.font = love.graphics.newFont("font/FFFFORWA.TTF", beiCheeKiller.size)
    beiCheeKiller.font2 = love.graphics.newFont("font/FFFFORWA.TTF", beiCheeKiller.size2)
    beiCheeKiller.word = ""
    --set select
    beiCheeKiller.stage = 1
    beiCheeKiller.isSelect = true
end
function beiCheeKiller_keypressed(key)
    --select accept or cancel
    if beiCheeKiller.isSelect == true then
        if key == "left" and beiCheeKiller.stage == 2 then
            beiCheeKiller.stage = 1
        elseif key == "left" and beiCheeKiller.stage == 1 then
            beiCheeKiller.stage = 2
        elseif key == "right" and beiCheeKiller.stage == 2 then
            beiCheeKiller.stage = 1
        elseif key == "right" and beiCheeKiller.stage == 1 then
            beiCheeKiller.stage = 2
        end
    end
    --press space to select
    if key == " " and beiCheeKiller.stage == 1 then
        menu.isBCK = false
    elseif key == " " and beiCheeKiller.stage == 2  then
        --save
        local data = {}
        local data2 = {}
        local bool1, bool2
        local f = love.filesystem.newFile("data.txt")
        local f2 = love.filesystem.newFile("data2.txt")
        f:open("r")
        f2:open("r")
        for line in love.filesystem.lines("data.txt") do
            table.insert(data, tonumber(line), 0)
        end
        for line in love.filesystem.lines("data2.txt") do
            table.insert(data2, line)
        end
        f:close()
        f2:close()
        if data2[1] == "true" then
            bool1 = true
        else
            bool1 = false
        end
        if data2[2] == "true" then
            bool2 = true
        else
            bool2 = false
        end
        loveLoad({data, bool1, bool2, tonumber(data2[3]), tonumber(data2[4]), tonumber(data2[5])})
        love_reloadDay()
        menu.isBCK = false
        gameStage = 2
    end
end
function beiCheeKiller_draw()
    --draw backbround
    love.graphics.setColor(0, 0, 0, 100)
    love.graphics.rectangle("fill", 0, 0, beiCheeKiller.width, beiCheeKiller.height)
    --draw dialog
    love.graphics.setColor(255, 0, 0, 255)
    love.graphics.rectangle("fill", 0, beiCheeKiller.height*2/5, beiCheeKiller.width, beiCheeKiller.height/4)
    love.graphics.setFont(beiCheeKiller.font)
    love.graphics.setColor(255, 255, 255)
    love.graphics.print(beiCheeKiller.word, beiCheeKiller.width/2 - beiCheeKiller.size * string.len(beiCheeKiller.word)/3, beiCheeKiller.height/2 - beiCheeKiller.size * (5/4))
    love.graphics.setColor(255, 100, 100)
    love.graphics.setFont(beiCheeKiller.font2)
    if beiCheeKiller.isSelect == true then
        love.graphics.print("ACCEPT", beiCheeKiller.width/3 - beiCheeKiller.size2*3, beiCheeKiller.height/2 + 50)
    end
    love.graphics.print("CANCEL", beiCheeKiller.width*2/3 - beiCheeKiller.size2*3, beiCheeKiller.height/2 + 50)
    love.graphics.setColor(255, 255, 255)
    if beiCheeKiller.stage == 1 then
        love.graphics.print("CANCEL", beiCheeKiller.width*2/3 - beiCheeKiller.size2*3, beiCheeKiller.height/2 + 50)
    elseif beiCheeKiller.stage == 2 and beiCheeKiller.isSelect == true then
        love.graphics.print("ACCEPT", beiCheeKiller.width/3 - beiCheeKiller.size2*3, beiCheeKiller.height/2 + 50)
    end
end
