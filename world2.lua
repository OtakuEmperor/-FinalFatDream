local creatMapLock=0
local fuck=0
world2={}
local screenWidth,screenHeight=love.graphics.getDimensions( )
local characterX=500
local characterY=300
function world2_load()
    require "character"
    --require "slime"
    require "boss2"
    require "barrierCreate"
    require "interface"
    require "barrierMove"
    --require "kagemusha"
    monsters = {}
    monsters[1] = boss2.new(2400, 100)
    --fight_bgm = love.audio.newSource("audio/night.mp3", "stream")
    interface_load()
    character_load()

end

function world2_update(dt)
    triggerUpdate(dt)
    if creatMapLock==0 then
        barrierCreate2()
        mapCreate2()
        characterCreate2()
        creatMapLock = creatMapLock+1
    end
    interface_update(dt)
    for i, monster in ipairs(monsters) do
        monster:update(dt,character.x+world.x,character.y+world.y,dt)
    end
    character_run(dt)
    character.py = character.y
    character.px = character.x
   -- if world1_fade then
     --   world1_fade_timer = world1_fade_timer + dt
       -- if world1_fade_timer <= 2 then
         --   world1_fade_color = world1_fade_color + 4
           -- if world1_fade_color >= 250 then
             --   world1_fade_color = 255
            --end
        --end
    --end
    --if not (world1_dialogLock and q1_dialogLock and q2_dialogLockKey and q2_dialogLockLine and q3_dialogLock and npc_dialogLock and boss1_dialogLcok) then
      --  isCharacterWake = false
    --else
      --  isCharacterWake = true
    --end
    if character.die then
       -- world1_fade = true
        --if world1_fade_timer >= 2 then
        --    day_state = 2
          --  dialog_state = 16
    --        gameStage = 2
      --      love_reloadDay()
    --    end
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
end

function world2_draw()
    -- print(string.format("%s %s\r\n%s %s\r\n", "hp", character.hp, "max.hp", character.maxHp))
    barrier2_draw()
    character_draw()
    interface_draw()
    monster_draw()
    triggerDraw()
    love.graphics.setBackgroundColor(68, 69, 69)
    --testdraw()
    love.audio.setVolume(0.8)
    fight_bgm:play()
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
    for i = 0, 1800, 100 do
        for j = 2800, 2900, 100 do
            deepWall[counter] = deepWall.new(i, j)
            counter = counter + 1
        end
    end
    for i = 100, 1100, 100 do
        deepWall[counter] = deepWall.new(i, 1300)
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
    --light_corner
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
        fuck = counter
        for j = 2000, 2600, 200 do
            deskChair[counter] = deskChair.new(i, j)
            counter = counter + 1
        end
    end
    --stair
    counter = 1
    for i = 1700, 1800, 100 do
        for j = 2400, 2700, 100 do
            stair[counter] = stair.new(i, j)
            counter = counter + 1
        end
    end
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
end

function world2_keypressed(key)
    if love.keyboard.isDown("k") then
        addKey()
    end
    character_keyPressed(key)
    triggerKeyPress(key)
    question4_keypressedLine(key)
end

function barrier2_draw()
    --floor
    for i=1, #floor, 1 do
        love.graphics.draw(floor[i].Image, floor[i].x-world.x, floor[i].y-world.y)
        if floor[i].Barrier then
            isBarrier(floor[i].x-world.x, floor[i].y-world.y)
        end
    end
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
    love.graphics.print(fuck, 200, 200)
end

function monster_draw()
    for i, monster in ipairs(monsters) do
        if monster.alive then
            love.graphics.setColor(255,255,255)
            love.graphics.draw(monster.slimeImgFile, monster.slimeQuads[monster.face][monster.animationIndex], monster.nowX-world.x, monster.nowY-world.y)
        end
    end
end
