world={}
local screenWidth,screenHeight=love.graphics.getDimensions( )
function world_load()
    require "character"
    require "slime"
    require "boss1"
    require "barrierCreate"
    require "interface"
    require "barrierMove"
    require "kagemusha"
    monsters = {}
    monsters[1] = slime.new(700,500)
    monsters[2] = slime.new(1200,500)
    monsters[3] = boss1.new(1000,700)
    monsters[4] = kagemusha.new(monsters[3], 1100, 700)
    monsters[5] = kagemusha.new(monsters[3], 1100, 800)
    monsters[6] = kagemusha.new(monsters[3], 1000, 800)
    fight_bgm = love.audio.newSource("audio/night.mp3", "stream")
    interface_load()
    character_load()
    barrierCreate()
    mapCreate()
end

function world_update(dt)
    barrierMove_update(dt)
    triggerUpdate(dt)
    triggerKeyPress(key)
    q3Trap[1]:update(dt)
    character_run(dt)
    character.py = character.y
    character.px = character.x
    if question==false then
    moveStageCheck()
    if world.x<world.nx and character.faceDir == "right" then
            character.animation.walking = true
            mapMove(character.Directions.Right, dt)
            characterSetDirection( character.animation.Directions.Right)
    elseif world.x>world.nx and character.faceDir == "left" then
            character.animation.walking = true
            mapMove(character.Directions.Left, dt)
            characterSetDirection( character.animation.Directions.Left)
    elseif world.y<world.ny and character.faceDir == "down" then
            character.animation.walking = true
            mapMove(character.Directions.Down, dt)
            characterSetDirection( character.animation.Directions.Down)
    elseif world.y>world.ny and character.faceDir == "up" then
            character.animation.walking = true
            mapMove(character.Directions.Up, dt)
            characterSetDirection( character.animation.Directions.Up)
    elseif love.keyboard.isDown("left") and world.y%100 == 0 and world.y == world.ny and world.x%100 == 0 and world.x == world.nx and world.leftMove==true  and character.y%100 == 0 and character.y == character.ny and character.x%100 == 0 and character.x == character.nx then
            characterSetDirection( character.animation.Directions.Left)
            character.faceDir = "left"
            world.delta = world.delta + dt
            if world.delta >= world.delay then
            world.py = world.y
            world.px = world.x
            if world.nx ~= 0 and world.count==false then
                    world.nx = world.x - 100
                end
                if character.animation.walking == false then
                    character.delta=0
                end
                mapMove(character.Directions.Left, dt)
            end
    elseif love.keyboard.isDown("right") and world.y%100 == 0 and world.y == world.ny and world.x%100 == 0 and world.x == world.nx and world.rightMove==true and character.y%100 == 0 and character.y == character.ny and character.x%100 == 0 and character.x == character.nx then
            characterSetDirection( character.animation.Directions.Right)
            character.faceDir = "right"
            world.delta = world.delta + dt
            if world.delta >= world.delay then
            world.py = world.y
            world.px = world.x
            if world.nx ~= (world.width-1000) and world.count==false then
                    world.nx = world.x + 100
                end
                if character.animation.walking == false then
                    world.delta=0
                end
                mapMove(character.Directions.Right, dt)
            end
    elseif love.keyboard.isDown("up") and world.y%100 == 0 and world.y == world.ny and world.x%100 == 0 and world.x == world.nx and world.upMove==true and character.y%100 == 0 and character.y == character.ny and character.x%100 == 0 and character.x == character.nx then
            characterSetDirection( character.animation.Directions.Up)
            character.faceDir = "up"
            world.delta = world.delta + dt
            if world.delta >= world.delay then
                world.py = world.y
            world.px = world.x
                if world.ny ~= 0 and world.count==false then
                    world.ny = world.y - 100
                end
                if character.animation.walking == false then
                    world.delta=0
                end
                mapMove(character.Directions.Up, dt)
            end
    elseif love.keyboard.isDown("down") and world.y%100 == 0 and world.y == world.ny and world.x%100 == 0 and world.x == world.nx and world.downMove==true and character.y%100 == 0 and character.y == character.ny and character.x%100 == 0 and character.x == character.nx then
            characterSetDirection( character.animation.Directions.Down)
            character.faceDir = "down"
            world.delta = world.delta + dt
            if world.delta >= world.delay then
                world.py = world.y
                world.px = world.x
                if world.ny ~= (world.height-500) and world.count==false then
                    world.ny = world.y + 100
                end
                if character.animation.walking == false then
                    world.delta=0
                end
                mapMove(character.Directions.Down, dt)
            end
        else
            if world.y%100 == 0  and world.y == world.ny and world.x%100 == 0  and world.x == world.nx then
                character_update(dt)
            else
                character.animation.sound:stop()
            end
            world.py = world.y
            world.px = world.x
        end
    end
    for i, monster in ipairs(monsters) do
        monster:update(dt,character.x+world.x,character.y+world.y)
    end
end

function world_draw()
    barrier_draw()
    character_draw()
    trap_draw()
    monster_draw()
    triggerDraw()
    interface_draw()
    --testdraw()
    love.audio.setVolume(0.8)
    fight_bgm:play()
end

function mapCreate()
    world.rightMove=false
    world.leftMove=false
    world.upMove=false
    world.downMove=false
    world.x=0
    world.y=0
    world.width=2000
    world.height=2000
    world.nx=0
    world.ny=0
    world.count=false
    world.count1=true
    world.temp=true
    world.px=0
    world.py=0
    world.speed = 200
    world.delta=0
    world.delay=0.15
end

function barrierCreate()
    tree[1] = tree.new(900,200)
    questionMark[1] = questionMark1.new(300,1300)
    q3Trap[1] = q3Trap.new(1600, 1800)
    q3Trap[2] = q3Trap.new(2000, 1800)
    q3Trap[2].Image = love.graphics.newImage("img/fortRight.png")
    questionMark[2] = questionMark2.new(1100,300)
    q2key = q2key.new(1900,700)
    questionMark[3] = questionMark3.new(1800,1900)
    q3key = q3key.new(1800,1500)
    --create stones
    stone[1] = stone.new(400, 900)
    stone[2] = stone.new(400, 1100)
    stone[3] = stone.new(500, 800)
    stone[4] = stone.new(500, 1200)
    stone[5] = stone.new(600, 700)
    stone[6] = stone.new(600, 1300)
    stone[7] = stone.new(700, 600)
    stone[8] = stone.new(700, 1400)
    stone[9] = stone.new(800, 500)
    stone[10] = stone.new(800, 1500)
    stone[11] = stone.new(1200, 500)
    stone[12] = stone.new(1200, 1500)
    stone[13] = stone.new(1300, 600)
    stone[14] = stone.new(1300, 1400)
    stone[15] = stone.new(1400, 700)
    stone[16] = stone.new(1400, 1300)
    stone[17] = stone.new(1500, 800)
    stone[18] = stone.new(1500, 1200)
    stone[19] = stone.new(1600, 900)
    stone[20] = stone.new(1600, 1100)
    stone[21] = stone.new(1700, 1900)
    --create forest
    forest[1] = forest.new(200, 100)
    forest[2] = forest.new(300, 1200)
    forest[3] = forest.new(100, 500)
    forest[4] = forest.new(600, 200)
    forest[5] = forest.new(500, 1400)
    forest[6] = forest.new(1000, 1000)
    forest[7] = forest.new(300, 1800)
    forest[8] = forest.new(900, 1800)
    forest[9] = forest.new(1500, 1500)
    forest[10] = forest.new(1600, 1600)
    forest[11] = forest.new(1700, 1500)
    forest[12] = forest.new(1600, 1700)
    forest[13] = forest.new(1500, 700)
    forest[14] = forest.new(1900, 100)
    forest[15] = forest.new(1200, 1600)
    forest[16] = forest.new(900, 100)
    forest[17] = forest.new(1900, 1900)
    forest[18] = forest.new(2000, 1900)
    --create grass
    local counter = 1
    for i = 0, 2000, 100 do
        for j = 0, 2000, 100 do
            grass[counter] = grass.new(i, j)
            counter = counter + 1
        end
    end
end

function world_keypressed(key)
    question1_keypressed(key)
    question2_keypressedKey(key)
    question2_keypressedLine(key)
    question3_keypressed(key)
end

function mapMove(direction, dt)

     if direction == character.animation.Directions.Down and question==false then
        character.animation.sound:play()
        if world.y < world.ny then
            character.animation.walking = true
            world.y = world.y + world.speed * dt
        end

        if world.y + world.speed * dt>world.ny then
            world.y = world.ny

        end


    end


    if direction == character.animation.Directions.Left and question==false then
        character.animation.sound:play()
        if world.x > world.nx then
            character.animation.walking = true
            world.x = world.x - world.speed * dt
        end

        if world.x - world.speed * dt<world.nx then
            world.x = world.nx

        end


    end


    if direction == character.animation.Directions.Right and question==false then
        character.animation.sound:play()
        if world.x < world.nx then
            character.animation.walking = true
            world.x = world.x + world.speed * dt
        end
        if world.x + world.speed * dt>world.nx then
            world.x = world.nx

        end


    end


    if direction == character.animation.Directions.Up and question==false then
        character.animation.sound:play()
        if world.y > world.ny then
            character.animation.walking = true
            world.y = world.y - world.speed * dt
        end

        if world.y - world.speed * dt<world.ny then
            world.y = world.ny

        end


    end
end

function isBarrier(barrierX,barrierY)
    if character.nx >barrierX-characterWidth and character.nx<barrierX+characterWidth and character.ny > barrierY-characterHeight and character.ny<barrierY+characterHeight then
        character.x =character.px
        character.y =character.py
        character.nx =character.px
        character.ny =character.py
        world.x =world.px
        world.y =world.py
        world.nx =world.px
        world.ny =world.py
        world.count=true
        character.count=true
    else
        character.count=false
        world.count=false
    end
    for i, monster in ipairs(monsters) do
        if monster.nowX-world.x ==barrierX and monster.nowY-world.y == barrierY then
            monster.nowX=monster.pastX
            monster.nowY=monster.pastY
        end
    end
    for i=1,1 do
        tree[i].nx=getMoveableNx()
        tree[i].ny=getMoveableNy()
        if tree[i].nx-world.x > barrierX-100 and tree[i].nx-world.x < barrierX+100 and tree[i].ny-world.y > barrierY-100 and tree[i].ny-world.y < barrierY+100  then
           -- tree[i].nx=getMoveablePx()
            --tree[i].ny=getMoveablePy()
            --changeMoveableN(tree[i].nx,tree[i].ny)
            --tree[i].x=getMoveablePx()
        --    tree[i].y=getMoveablePy()
          --  changeMoveable(tree[i].x,tree[i].y)
        --    tree[i].Barrier=true
          --  tree[i].moveable=false
        else
 
        end
    end
end

function barrier_draw()

    for i=1,441 do
        love.graphics.draw(grass[i].Image, grass[i].x-world.x, grass[i].y-world.y)
        if grass[i].Barrier then
            isBarrier(grass[i].x-world.x, grass[i].y-world.y)
        end
    end
    --draw stones
    for i=1,21 do
        love.graphics.draw(stone[i].Image, stone[i].x-world.x, stone[i].y-world.y)
        if stone[i].Barrier then
            isBarrier(stone[i].x-world.x, stone[i].y-world.y)
        end
    end
    --draw forest
    for i=1,18 do
        love.graphics.draw(forest[i].Image, forest[i].x-world.x, forest[i].y-world.y)
        if forest[i].Barrier then
            isBarrier(forest[i].x-world.x, forest[i].y-world.y)
        end
    end
    for i=1,1 do
        love.graphics.draw(tree[i].Image,tree[i].x-world.x,tree[i].y-world.y)
        if tree[i].moveable then
            moveableBarrier(tree[i].x,tree[i].y)
            tree[i].x=getMoveableX()
            tree[i].y=getMoveableY()
        end
        if tree[i].Barrier then
            isBarrier(tree[i].x-world.x,tree[i].y-world.y)
        end
    end
    for i=1,3 do
        love.graphics.draw(questionMark[i].Image,questionMark[i].x-world.x,questionMark[i].y-world.y)
        if questionMark[i].Barrier then
            isBarrier(questionMark[i].x-world.x,questionMark[i].y-world.y)
        end
    end
    for i=1,2 do
        love.graphics.draw(q3Trap[i].Image,q3Trap[i].x-world.x,q3Trap[i].y-world.y)
        if q3Trap[i].Barrier then
            isBarrier(q3Trap[i].x-world.x,q3Trap[i].y-world.y)
        end
    end

    love.graphics.draw(q3key.Image,q3key.x-world.x,q3key.y-world.y)
    if q3key.Barrier then
        isBarrier(q3key.x-world.x,q3key.y-world.y)
    end
    love.graphics.draw(q2key.Image,q2key.x-world.x,q2key.y-world.y)
    if q2key.Barrier then
        isBarrier(q2key.x-world.x,q2key.y-world.y)
    end
end
function monster_draw()
    for i, monster in ipairs(monsters) do
        if monster.alive then
            if monster.underAttacking == true then
                love.graphics.setColor(255,0,0)
            else
                love.graphics.setColor(255,255,255)
            end
            love.graphics.draw(monster.slimeImgFile, monster.slimeQuads[monster.moveStep[monster.moveIndex]][monster.animationIndex], monster.nowX-world.x, monster.nowY-world.y)
        end
        if monster.isThunderBallAttack then
            monster:thunder_ball_attack()
        end
        if monster.isWaveAttack then
            monster:wave_attack()
        end
    end
end
function trap_draw()
    if q3Trap[1].showBar == true then
        love.graphics.setColor(255,0,0)
        love.graphics.rectangle("fill", q3Trap[1].x-world.x+100,q3Trap[1].y-world.y+50 , q3Trap[2].x-q3Trap[1].x-100, 10 )
    end
end
