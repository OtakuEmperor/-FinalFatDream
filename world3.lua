local creatMapLock=0
world3={}
local screenWidth,screenHeight=love.graphics.getDimensions( )
local characterX=500
local characterY=300
local resetKey = false
local sj1 = true
local sj2 = true
local sj3 = true
function world3_load()
    require "character"
    --require "slime"
    require "boss3"
    require "barrierCreate"
    require "interface"
    require "barrierMove"
    require "kagemusha"
    require "thunderball"
    --fight_bgm = love.audio.newSource("audio/night.mp3", "stream")
    --interface_load()
    --character_load()
end

function world3_update(dt)
    --reset Key
    if resetKey == false then
        zeroKey()
        resetKey = true
    end
    if creatMapLock==0 then
        barrierCreate3()
        mapCreate3()
        characterCreate3()
        monsterCreate3()
        creatMapLock = creatMapLock+1
    end
    interface_update(dt)
    for i, monster in ipairs(monsters) do
        monster:update(dt,character.x+world.x,character.y+world.y,dt)
    end
    love_update(dt)
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
    monsters[1].startAttack = true
end

function world3_draw()
    -- print(string.format("%s %s\r\n%s %s\r\n", "hp", character.hp, "max.hp", character.maxHp))
    barrier3_draw()
    character_draw()
    interface_draw()
    monster_draw3()
    love.graphics.setBackgroundColor(100, 100, 100)
    --testdraw()
    love.audio.setVolume(0.8 * getVol())
    fight_bgm:play()
end
function characterCreate3()
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
function mapCreate3()
    world.rightMove=false
    world.leftMove=false
    world.upMove=false
    world.downMove=false
    world.x=0
    world.y=0
    world.width=1400
    world.height=1200
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
function monsterCreate3()
     monsters = {}
    monsters[1] = boss3.new(1100, 0)
    monsters[2] = kagemusha.new(monsters[1], 1200, 0)
    monsters[3] = kagemusha.new(monsters[1], 1100, 100)
    monsters[4] = kagemusha.new(monsters[1], 1200, 100)
end
function barrierCreate3()
    --create houseFloor
    local counter = 1
    for i = 0, 1500, 100 do
        for j = 0, 1200, 100 do
            houseFloor[counter] = houseFloor.new(i, j)
            counter = counter + 1
        end
    end
    --houseWall
    counter = 1
    for j = 100, 1000, 100 do
        houseWall[counter] = houseWall.new(0, j)
        counter = counter + 1
    end
    for j = 100, 700, 100 do
        houseWall[counter] = houseWall.new(700, j)
        counter = counter + 1
    end
    houseWall[counter] = houseWall.new(0, 0)
    counter = counter + 1
    houseWall[counter] = houseWall.new(100, 0)
    counter = counter + 1
    houseWall[counter] = houseWall.new(400, 0)
    counter = counter + 1
    houseWall[counter] = houseWall.new(500, 0)
    counter = counter + 1
    houseWall[counter] = houseWall.new(600, 0)
    counter = counter + 1
    houseWall[counter] = houseWall.new(700, 0)
    counter = counter + 1
    houseWall[counter] = houseWall.new(700, 800)
    counter = counter + 1
    houseWall[counter] = houseWall.new(800, 800)
    counter = counter + 1
    houseWall[counter] = houseWall.new(900, 800)
    counter = counter + 1
    houseWall[counter] = houseWall.new(1200, 800)
    counter = counter + 1
    houseWall[counter] = houseWall.new(1300, 800)
    counter = counter + 1
    houseWall[counter] = houseWall.new(1400, 800)
    counter = counter + 1
    for i = 0, 1400, 100 do
        houseWall[counter] = houseWall.new(i, 1100)
        counter = counter + 1
    end
    for i = 0, 1400, 100 do
        houseWall[counter] = houseWall.new(i, 1200)
        counter = counter + 1
    end
    --kotatsu
    kotatsu[1] = kotatsu.new(1000, 400)
    kotatsu[2] = kotatsu.new(1100, 400)
    kotatsu[3] = kotatsu.new(1000, 500)
    kotatsu[4] = kotatsu.new(1100, 500)
    --bigTable
    bigTable[1] = bigTable.new(1300, 0)
    bigTable[2] = bigTable.new(1400, 0)
    bigTable[3] = bigTable.new(1300, 100)
    bigTable[4] = bigTable.new(1400, 100)
    --bed
    bed[1] = bed.new(800, 100)
    bed[2] = bed.new(900, 100)
    --potted
    potted[1] = potted.new(900, 700)
    potted[2] = potted.new(400, 1000)
    potted[3] = potted.new(1400, 900)
    potted[4] = potted.new(100, 100)
    potted[5] = potted.new(400, 100)
    --tv
    tv[1] = tv.new(100, 500)
    tv[2] = tv.new(100, 600)
    --smallTable
    smallTable[1] = smallTable.new(400, 500)
    smallTable[2] = smallTable.new(400, 600)
    --sofa
    sofa[1] = sofa.new(600, 500)
    sofa[2] = sofa.new(600, 600)
    --bookcase
    bookcase[1] = bookcase.new(800, 0)
    bookcase[2] = bookcase.new(1200, 700)
    bookcase[3] = bookcase.new(200, 1000)
    bookcase[4] = bookcase.new(500, 100)

    bookcase[5] = bookcase.new(1000, 0)
    bookcase[6] = bookcase.new(1400, 700)
    bookcase[7] = bookcase.new(300, 1000)
    bookcase[8] = bookcase.new(600, 100)

    bookcase[9] = bookcase.new(900, 0)
    bookcase[10] = bookcase.new(1300, 700)
    --slimeJuice
    sj[1] = sj.new(100, 1000)
    sj[2] = sj.new(800, 700)
    sj[3] = sj.new(1400, 1000)
end

function world3_keypressed(key)
    if love.keyboard.isDown("k") then
        addKey()
    end
    --get slimeJuice
    if key == "f" and (character.x+world.x) == 100 and (character.y+world.y) == 900 and character.faceDir == "down" and sj1 == true then
        character.water = true
        sj1 = false
    end
    if key == "f" and (character.x+world.x) == 800 and (character.y+world.y) == 600 and character.faceDir == "down" and sj2 == true then
        character.water = true
        sj2 = false
    end
    if key == "f" and (character.x+world.x) == 1300 and (character.y+world.y) == 1000 and character.faceDir == "right" and sj3 == true then
        character.water = true
        sj3 = false
    end
    character_keyPressed(key)
end

function barrier3_draw()
    --houseFloor
    for i=1, #houseFloor, 1 do
        love.graphics.draw(houseFloor[i].Image, houseFloor[i].x-world.x, houseFloor[i].y-world.y)
        if houseFloor[i].Barrier then
            isBarrier(houseFloor[i].x-world.x, houseFloor[i].y-world.y)
        end
    end
    --houseWall
    for i=1, #houseWall, 1 do
        love.graphics.draw(houseWall[i].Image, houseWall[i].x-world.x, houseWall[i].y-world.y)
        if houseWall[i].Barrier then
            isBarrier(houseWall[i].x-world.x, houseWall[i].y-world.y)
        end
    end
    --bigTable
    for i=1, #bigTable, 1 do
        love.graphics.draw(bigTable[i].Image, bigTable[i].x-world.x, bigTable[i].y-world.y)
        if bigTable[i].Barrier then
            isBarrier(bigTable[i].x-world.x, bigTable[i].y-world.y)
        end
    end
    --smallTable
    for i=1, #smallTable, 1 do
        love.graphics.draw(smallTable[i].Image, smallTable[i].x-world.x, smallTable[i].y-world.y)
        if smallTable[i].Barrier then
            isBarrier(smallTable[i].x-world.x, smallTable[i].y-world.y)
        end
    end
    --bigTable
    for i=1, #bigTable, 1 do
        love.graphics.draw(bigTable[i].Image, bigTable[i].x-world.x, bigTable[i].y-world.y)
        if bigTable[i].Barrier then
            isBarrier(bigTable[i].x-world.x, bigTable[i].y-world.y)
        end
    end
    --tv
    for i=1, #tv, 1 do
        love.graphics.draw(tv[i].Image, tv[i].x-world.x, tv[i].y-world.y)
        if tv[i].Barrier then
            isBarrier(tv[i].x-world.x, tv[i].y-world.y)
        end
    end
    --sofa
    for i=1, #sofa, 1 do
        love.graphics.draw(sofa[i].Image, sofa[i].x-world.x, sofa[i].y-world.y)
        if sofa[i].Barrier then
            isBarrier(sofa[i].x-world.x, sofa[i].y-world.y)
        end
    end
    --kotatsu
    for i=1, #kotatsu, 1 do
        love.graphics.draw(kotatsu[i].Image, kotatsu[i].x-world.x, kotatsu[i].y-world.y)
        if kotatsu[i].Barrier then
            isBarrier(kotatsu[i].x-world.x, kotatsu[i].y-world.y)
        end
    end
    --potted
    for i=1, #potted, 1 do
        love.graphics.draw(potted[i].Image, potted[i].x-world.x, potted[i].y-world.y)
        if potted[i].Barrier then
            isBarrier(potted[i].x-world.x, potted[i].y-world.y)
        end
    end
    --bed
    for i=1, #bed, 1 do
        love.graphics.draw(bed[i].Image, bed[i].x-world.x, bed[i].y-world.y)
        if bed[i].Barrier then
            isBarrier(bed[i].x-world.x, bed[i].y-world.y)
        end
    end
    --bookcase
    for i=1, #bookcase, 1 do
        love.graphics.draw(bookcase[i].Image, bookcase[i].x-world.x, bookcase[i].y-world.y)
        if bookcase[i].Barrier then
            isBarrier(bookcase[i].x-world.x, bookcase[i].y-world.y)
        end
    end
    --slimeJuice
    if sj1 then
        love.graphics.draw(sj[1].Image, sj[1].x-world.x, sj[1].y-world.y)
        if sj[1].Barrier then
            isBarrier(sj[1].x-world.x, sj[1].y-world.y)
        end
    end
    if sj2 then
        love.graphics.draw(sj[2].Image, sj[2].x-world.x, sj[2].y-world.y)
        if sj[2].Barrier then
            isBarrier(sj[2].x-world.x, sj[2].y-world.y)
        end
    end
    if sj3 then
        love.graphics.draw(sj[3].Image, sj[3].x-world.x, sj[3].y-world.y)
        if sj[3].Barrier then
            isBarrier(sj[3].x-world.x, sj[3].y-world.y)
        end
    end
end

function monster_draw3()
    for i, monster in ipairs(monsters) do
        if monster.alive then
            love.graphics.setColor(255,255,255)
            love.graphics.draw(monster.slimeImgFile, monster.slimeQuads[monster.face][monster.animationIndex], monster.nowX-world.x, monster.nowY-world.y)
        end
    end
    for i=1,3 do
        if monsters[1].thunderballs[i].isThunderBallAttack then
            monsters[1].thunderballs[i]:draw()
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

    end
end
