local creatMapLock=0
local fuck=0
world2={}
local screenWidth,screenHeight=love.graphics.getDimensions( )
local characterX=500
local characterY=300
local resetKey = false
function world2_load()
    require "character"
    require "slime"
    require "boss2"
    require "barrierCreate"
    require "interface"
    require "barrierMove"
    require "kagemusha"
    fight_bgm2 = love.audio.newSource("audio/night2.ogg")
    --interface_load()
    --character_load()
    boss2_summon = false
    world2_fade_color = 0
    world2_fade = false
    world2_fade_timer = 0
    world2_dialog_state = 1
    world2_dialogLock = true
end

function world2_update(dt)
    --reset Key
    if resetKey == false then
        zeroKey()
        resetKey = true
    end
    if creatMapLock==0 then
        barrierCreate2()
        mapCreate2()
        characterCreate2()
        monsterCreate2()
        creatMapLock = creatMapLock+1
    end
    barrierMove_update(dt)
    love_update(dt)
    triggerUpdate(dt)
    interface_update(dt)
    for i, monster in ipairs(monsters) do
        monster:update(dt,character.x+world.x,character.y+world.y,dt)
    end
    character_run(dt)
    character.py = character.y
    character.px = character.x
    if world2_fade then
        world2_fade_timer = world2_fade_timer + dt
        if world2_fade_timer <= 2 then
            world2_fade_color = world2_fade_color + 4
            if world2_fade_color >= 250 then
                world2_fade_color = 255
            end
        end
    end
    if not (q4_dialogLockKey and q5_dialogLockKey) then
       isCharacterWake = false
    else
       isCharacterWake = true
    end
    if character.die then
       world2_fade = true
        if world2_fade_timer >= 2 then
           day_state = 3
           dialog_state = 1
           gameStage = 2
           love.audio.stop()
           love_reloadDay()
       end
    end
    if world.backMove == true then
        --if world.rightMove == true or world.leftMove == true or world.upMove == true or world.downMove == true then
        world.speed = 1000
        mapbackMoveUpdate(dt)
        --end
    elseif  question==false and conversation == false then
        world.speed = 300
        setMapMove(dt)
    end

    if not boss2_summon and interface.keyNum == 3 then
        boss2_summon = true
        monsters[1].startRun = true
    end
end

function world2_draw()
    if world2_fade then
        love.graphics.setColor(0,0,0, world2_fade_color)
    end
    -- print(string.format("%s %s\r\n%s %s\r\n", "hp", character.hp, "max.hp", character.maxHp))
    barrier2_draw()
    character_draw()
    interface_draw()
    monster_draw2()
    triggerDraw()
    love.graphics.setBackgroundColor(68, 69, 69)
    --testdraw()
    love.audio.stop(fight_bgm)
    fight_bgm2:setVolume(0.3 * getVol())
    fight_bgm2:play()
end
function monsterCreate2()
    monsters = {}
    monsters[1] = boss2.new(2400, 100)
    monsters[2] = kagemusha.new(monsters[1], 2400, 200)
    monsters[3] = kagemusha.new(monsters[1], 2500, 100)
    monsters[4] = kagemusha.new(monsters[1], 2500, 200)
    

end
function characterCreate2()
    character.x = characterX
    character.y = characterY
    character.nx=characterX
    character.ny=characterY
    character.count=false
    character.px=characterX
    character.py=characterY
    character.maxHp=100
    character.hp=100
    character.die=false
    character.atk=5
    character.speed = 300
    character.faceDir = "down"
    character.delay=0.15
    character.delta=0
    character.backMove=false
    character.water = false
end
function mapCreate2()
    world.rightMove=false
    world.leftMove=false
    world.upMove=false
    world.downMove=false
    world.x=0
    world.y=0
    world.width=2900
    world.height=3000
    world.nx=0
    world.ny=0
    world.count=false
    world.count1=true
    world.temp=true
    world.px=0
    world.py=0
    world.speed = 300
    world.delta=0
    world.delay=0.15
    world.backMove =false
end

function barrierCreate2()
    underDeskPaper=love.graphics.newImage("img/underPaper.png")
    underDeskPaper_dialog={}
    underDeskPaper_dialogLength=0
    paper_data = love.filesystem.read("npcDialog/day2Puzzle2/underPaper.dat", all)
    for k in string.gmatch(paper_data, "[^,^\n]+") do
        table.insert(underDeskPaper_dialog, k)
    end
    underDeskPaper_dialogLength = table.getn(underDeskPaper_dialog)
    question6_dialog={}
    question6_dialogLength=0
    question6_data = love.filesystem.read("npcDialog/day2Puzzle2/question6.dat", all)
    for k in string.gmatch(question6_data, "[^,^\n]+") do
        table.insert(question6_dialog, k)
    end
    question6_dialogLength = table.getn(question6_dialog)
    --blackboard
    local counter = 1
    for i = 200, 1000, 100 do
        for j = 0, 100, 100 do
            blackboard[counter] = blackboard.new(i, j)
            counter = counter + 1
        end
        for j = 1400, 1600, 100 do
            blackboard[counter] = blackboard.new(i, j)
            counter = counter + 1
        end
    end
    --deepWall
    counter = 1
    for j = 0, 2700, 100 do
        deepWall[counter] = deepWall.new(0, j)
        counter = counter + 1
    end
    for j = 0, 200, 100 do
        deepWall[counter] = deepWall.new(1200, j)
        counter = counter + 1
    end
    for j = 500, 1700, 100 do
        deepWall[counter] = deepWall.new(1200, j)
        counter = counter + 1
    end
    for j = 2000, 2700, 100 do
        deepWall[counter] = deepWall.new(1200, j)
        counter = counter + 1
    end
    for i = 1700, 1800, 100 do
        for j = 0, 2300, 100 do
            deepWall[counter] = deepWall.new(i, j)
            counter = counter + 1
        end
    end
    --deepWall_hor
    for i = 100, 1100, 100 do
        deepWall[counter] = deepWall.new(i, 1300)
        counter = counter + 1
    end
    for i = 0, 1800, 100 do
        for j = 2800, 2900, 100 do
            deepWall[counter] = deepWall.new(i, j)
            counter = counter + 1
        end
    end

    --lightWall
    counter = 1
    --lightWall_left
    for j = 0, 100, 100 do
        lightWall[counter] = lightWall.new(100, j)
        counter = counter + 1
    end
    for j = 1400, 1600, 100 do
        lightWall[counter] = lightWall.new(100, j)
        counter = counter + 1
    end
    --lightWall_right
    for j = 0, 100, 100 do
        lightWall[counter] = lightWall.new(1100, j)
        counter = counter + 1
    end
    for j = 1400, 1600, 100 do
        lightWall[counter] = lightWall.new(1100, j)
        counter = counter + 1
    end
    --lightWall_down
    for i = 200, 1000, 100 do
        lightWall[counter] = lightWall.new(i, 200)
        counter = counter + 1
    end
    for i = 200, 1000, 100 do
        lightWall[counter] = lightWall.new(i, 1700)
        counter = counter + 1
    end
    --lightWall_corner
    lightWall[counter] = lightWall.new(100, 200) --leftUp
    counter = counter + 1
    lightWall[counter] = lightWall.new(100, 1700)--leftDown
    counter = counter + 1
    lightWall[counter] = lightWall.new(1100, 200)--rightUp
    counter = counter + 1
    lightWall[counter] = lightWall.new(1100, 1700)--rightDown

    --floor
    counter = 1
    for i = 100, 1200, 100 do
        for j = 0, 2700, 100 do
            floor[counter] = floor.new(i, j)
            counter = counter + 1
        end
    end
    --aisle
    counter = 1
    for i = 1300, 1600, 100 do
        for j = 0, 2700, 100 do
            aisle[counter] = aisle.new(i, j)
            counter = counter + 1
        end
    end
    --deskChair
    counter = 1
    for i = 100, 1100, 200 do
        for j = 500, 1100, 200 do
            deskChair[counter] = deskChair.new(i, j)
            counter = counter + 1
        end
        for j = 2000, 2600, 200 do
            deskChair[counter] = deskChair.new(i, j)
            q4_data = love.filesystem.read(string.format("npcDialog/day2Puzzle2/table%d.dat", counter), all)
            for k in string.gmatch(q4_data, "[^,^\n]+") do
                table.insert(deskChair[counter].dialog, k)
            end
            deskChair[counter].dialogLength = table.getn(deskChair[counter].dialog)
            counter = counter + 1
        end
    end
    q5_data = love.filesystem.read(string.format("npcDialog/day2Puzzle2/table%d.dat", 1), all)
    for k in string.gmatch(q5_data, "[^,^\n]+") do
        table.insert(deskChair[1].dialog, k)
    end
    deskChair[1].dialogLength = table.getn(deskChair[1].dialog)
    q5_data = love.filesystem.read(string.format("npcDialog/day2Puzzle2/table%d.dat", 34), all)
    for k in string.gmatch(q5_data, "[^,^\n]+") do
        table.insert(deskChair[34].dialog, k)
    end
    deskChair[34].dialogLength = table.getn(deskChair[34].dialog)
    q5_data = love.filesystem.read(string.format("npcDialog/day2Puzzle2/table%d.dat", 44), all)
    for k in string.gmatch(q5_data, "[^,^\n]+") do
        table.insert(deskChair[44].dialog, k)
    end
    deskChair[44].dialogLength = table.getn(deskChair[44].dialog)
    deskChair[20].moveable=true
    deskChair[20].Barrier=false
    --stair
    stair[1] = stair.new(1700, 2400)
    --dust
    counter = 1
    for i = 1900, 2900, 100 do
        for j = 0, 2900, 100 do
            dust[counter] = dust.new(i, j)
            counter = counter + 1
        end
    end
    --fence
    counter = 1
    --1
    for i = 1900, 2900, 100 do
        fence[counter] = fence.new(i, 0)
        counter = counter + 1
    end
    --2
    for i = 2100, 2700, 100 do --1R1L
        fence[counter] = fence.new(i, 300)
        counter = counter + 1
    end
    --3
    for i = 1900, 2000, 100 do --1R
        fence[counter] = fence.new(i, 600)
        counter = counter + 1
    end
    for i = 2400, 2900, 100 do --1L
        fence[counter] = fence.new(i, 600)
        counter = counter + 1
    end
    --4
    for i = 1900, 2400, 100 do --1R
        fence[counter] = fence.new(i, 900)
        counter = counter + 1
    end
    for i = 2800, 2900, 100 do --1L
        fence[counter] = fence.new(i, 900)
        counter = counter + 1
    end
    --5
    for i = 1900, 2200, 100 do --1R
        fence[counter] = fence.new(i, 1200)
        counter = counter + 1
    end
    for i = 2600, 2900, 100 do --1L
        fence[counter] = fence.new(i, 1200)
        counter = counter + 1
    end
    --6
    for i = 2100, 2900, 100 do --1L
        fence[counter] = fence.new(i, 1500)
        counter = counter + 1
    end
    --7
    fence[counter] = fence.new(1900, 1800) --1R
    counter = counter + 1
    for i = 2400, 2900, 100 do
        fence[counter] = fence.new(i, 1800) --1L
        counter = counter + 1
    end
    --8
    for i = 1900, 2200, 100 do
        fence[counter] = fence.new(i, 2100) --1R
        counter = counter + 1
    end
    for i = 2700, 2900, 100 do
        fence[counter] = fence.new(i, 2100) --1L
        counter = counter + 1
    end
    --fence_left
    fence[counter] = fence.new(2000, 300)
    counter = counter + 1
    fence[counter] = fence.new(2300, 600)
    counter = counter + 1
    fence[counter] = fence.new(2700, 900)
    counter = counter + 1
    fence[counter] = fence.new(2500, 1200)
    counter = counter + 1
    fence[counter] = fence.new(2000, 1500)
    counter = counter + 1
    fence[counter] = fence.new(2300, 1800)
    counter = counter + 1
    fence[counter] = fence.new(2600, 2100)
    counter = counter + 1
    --fence_right
    fence[counter] = fence.new(2800, 300)
    counter = counter + 1
    fence[counter] = fence.new(2100, 600)
    counter = counter + 1
    fence[counter] = fence.new(2500, 900)
    counter = counter + 1
    fence[counter] = fence.new(2300, 1200)
    counter = counter + 1
    fence[counter] = fence.new(2000, 1800)
    counter = counter + 1
    fence[counter] = fence.new(2300, 2100)
    --you can not go
    UNG[1] = UNG.new(1700, 2400)
    UNG[2] = UNG.new(1800, 2700)

end

function world2_keypressed(key)
    if love.keyboard.isDown("k") then
        addKey()
    end
    character_keyPressed(key)
    triggerKeyPress(key)
    question4_keypressedLine(key)
    q4_keypressedKey(key)
    q5_keypressedKey(key)
    npc2_keypressed(key)
end

function barrier2_draw()
    --floor
    for i=1, #floor, 1 do
        love.graphics.draw(floor[i].Image, floor[i].x-world.x, floor[i].y-world.y)
        if floor[i].Barrier then
            isBarrier(floor[i].x-world.x, floor[i].y-world.y)
        end
    end
    love.graphics.draw(underDeskPaper, 500-world.x, 1100-world.y)
    --aisle
    for i=1, #aisle, 1 do
        love.graphics.draw(aisle[i].Image, aisle[i].x-world.x, aisle[i].y-world.y)
        if aisle[i].Barrier then
            isBarrier(aisle[i].x-world.x, aisle[i].y-world.y)
        end
    end
    --dust
    for i=1, #dust, 1 do
        love.graphics.draw(dust[i].Image, dust[i].x-world.x, dust[i].y-world.y)
        if dust[i].Barrier then
            isBarrier(dust[i].x-world.x, dust[i].y-world.y)
        end
    end
    --stair
    for i=1, #stair, 1 do
        love.graphics.draw(stair[i].Image, stair[i].x-world.x, stair[i].y-world.y)
        if stair[i].Barrier then
            isBarrier(stair[i].x-world.x, stair[i].y-world.y)
        end
    end
    --deepWall
    for i=1, #deepWall, 1 do
        love.graphics.draw(deepWall[i].Image, deepWall[i].x-world.x, deepWall[i].y-world.y)
        if deepWall[i].Barrier then
            isBarrier(deepWall[i].x-world.x, deepWall[i].y-world.y)
        end
    end
    --lightWall
    for i=1, #lightWall, 1 do
        love.graphics.draw(lightWall[i].Image, lightWall[i].x-world.x, lightWall[i].y-world.y)
        if lightWall[i].Barrier then
            isBarrier(lightWall[i].x-world.x, lightWall[i].y-world.y)
        end
    end
    --deskChair
    for i=1, #deskChair, 1 do
        love.graphics.draw(deskChair[i].Image, deskChair[i].x-world.x, deskChair[i].y-world.y)
        if deskChair[i].Barrier then
            isBarrier(deskChair[i].x-world.x, deskChair[i].y-world.y)
        end
        if deskChair[i].moveable then
            moveableBarrier(deskChair[i].x,deskChair[i].y)
            deskChair[i].x=getMoveableX()
            deskChair[i].y=getMoveableY()
        end
    end
    --blackboard
    for i = 1, #blackboard, 1 do
        love.graphics.draw(blackboard[i].Image, blackboard[i].x-world.x, blackboard[i].y-world.y)
        if blackboard[i].Barrier then
            isBarrier(blackboard[i].x-world.x, blackboard[i].y-world.y)
        end
    end
    --fence
    for i = 1, #fence, 1 do
        love.graphics.draw(fence[i].Image, fence[i].x-world.x, fence[i].y-world.y)
        if fence[i].Barrier then
            isBarrier(fence[i].x-world.x, fence[i].y-world.y)
        end
    end
    --UNG
    for i = 1, #UNG, 1 do
        if UNG[i].Barrier then
            isBarrier(UNG[i].x-world.x, UNG[i].y-world.y)
        end
    end
end

function monster_draw2()
    for i, monster in ipairs(monsters) do
        if monster.alive then
            love.graphics.setColor(255,255,255)
            love.graphics.draw(monster.slimeImgFile, monster.slimeQuads[monster.face][monster.animationIndex], monster.nowX-world.x, monster.nowY-world.y)
        end
    end

    --play boss bgm
    if monsters[1].alive then
        --love.audio.stop(fight_bgm2)
        --love.audio.rewind(bossBGM)
        bossBGM:setVolume(getVol()*0.4)
        bossBGM:play()
    end

    if not monsters[1].alive and monsters[1].hp <= 0 then
        world2_fade = true
        if world2_fade_timer >= 2 then
           day_state = 3
           gameStage = 2
           world2_success = true
           love.audio.stop()
           love_reloadDay()
       end
    end
end
