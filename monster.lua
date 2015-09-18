monster = {}

function monster_load()
    monsterImg = love.graphics.newImage("img/slime.png")
    monsterQuads = {}
    for i=1,4 do
        monsterQuads[i] = {}
        for j=1,4 do
            monsterQuads[i][j] = love.graphics.newQuad( (100*j)-100, (100*i)-100, 100, 100, 400, 400)
        end
    end
    postion = 1
    tick = 0
    monster_an = 1
    moveMode = {3, 3, 3, 3, 2, 2, 2, 2, 4, 4, 4, 4, 1, 1, 1, 1}
    movePostion = 1
    originPointX = 700
    originPointY = 500
    nowX = originPointX
    nowY = originPointY
    hp = 10
    moveSound = love.audio.newSource("audio/slime1.ogg", "static")
end

function monster_update(dt)
    tick = tick + dt
    if tick > 0.25 then
        tick = 0
        monster_an = monster_an + 1
        if monster_an > 4  then
            if moveMode[movePostion] == 1 then
                nowY = nowY + 100
            end
            if moveMode[movePostion] == 2 then
                nowY = nowY - 100
            end
            if moveMode[movePostion] == 3 then
                nowX = nowX - 100
            end
            if moveMode[movePostion] == 4 then
                nowX = nowX + 100
            end
            movePostion = movePostion + 1
            if movePostion > table.getn(moveMode) then
                movePostion = 1
            end
            animationDone = false
            moveSound:play()
            monster_an = 1
        end
    end
    print(monster_an)
    
end

function monster_draw()
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.draw(monsterImg, monsterQuads[postion][monster_an], nowX, nowY)
end
