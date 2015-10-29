world={}

function world_load()
    require "character"
    require "benchboard"
    require "slime"
    require "barrierCreate"
    monster1 = slime.new(700,500)
    monsters = {}
    table.insert(monsters, monster1)
    character_load()
    benchboard_load()
    barrierCreate()
    mapCreate()
end

function world_update(dt)
    q3Trap[1]:update(dt)
    monster1:update(dt,character.x+world.x,character.y+world.y)
    character_run(dt)
    if world.x<world.nx and character.faceDir == "right" then
            character.animation.walking = true 
            mapMove(character.Directions.Right, dt)
           
    elseif world.x>world.nx and character.faceDir == "left" then
            character.animation.walking = true
            mapMove(character.Directions.Left, dt)
    elseif world.y<world.ny and character.faceDir == "down" then
            character.animation.walking = true
            mapMove(character.Directions.Down, dt)
    elseif world.y>world.ny and character.faceDir == "up" then
            character.animation.walking = true
            mapMove(character.Directions.Up, dt) 
    elseif love.keyboard.isDown("left") and world.y%100 == 0 and world.y == world.ny and world.x%100 == 0 and world.x == world.nx and world.leftMove==true  and character.y%100 == 0 and character.y == character.ny and character.x%100 == 0 and character.x == character.nx then
            world.delta = world.delta + dt
            if world.delta >= world.delay then
                if world.nx ~= 0  then
                    world.nx = world.x - 100
                end
                if character.animation.walking == false then
                    character.delta=0
                end
                mapMove(character.Directions.Left, dt)
                character.faceDir = "left"
            end
    elseif love.keyboard.isDown("right") and world.y%100 == 0 and world.y == world.ny and world.x%100 == 0 and world.x == world.nx and world.rightMove==true and character.y%100 == 0 and character.y == character.ny and character.x%100 == 0 and character.x == character.nx then
            world.delta = world.delta + dt
            if world.delta >= world.delay then
                if world.nx ~= 1000  then
                    world.nx = world.x + 100
                end
                if character.animation.walking == false then
                    world.delta=0
                end
                mapMove(character.Directions.Right, dt)
                character.faceDir = "right"
            end
    elseif love.keyboard.isDown("up") and world.y%100 == 0 and world.y == world.ny and world.x%100 == 0 and world.x == world.nx and world.upMove==true and character.y%100 == 0 and character.y == character.ny and character.x%100 == 0 and character.x == character.nx then
            world.delta = world.delta + dt
            if world.delta >= world.delay then
                if world.ny ~= 0 then
                    world.ny = world.y - 100
                end
                if character.animation.walking == false then
                    world.delta=0
                end
                mapMove(character.Directions.Up, dt)
                character.faceDir = "up"
            end
    elseif love.keyboard.isDown("down") and world.y%100 == 0 and world.y == world.ny and world.x%100 == 0 and world.x == world.nx and world.downMove==true and character.y%100 == 0 and character.y == character.ny and character.x%100 == 0 and character.x == character.nx then
            world.delta = world.delta + dt
            if world.delta >= world.delay then
                if world.ny ~= 500  then
                    world.ny = world.y + 100
                end
                if character.animation.walking == false then
                    world.delta=0
                end
                mapMove(character.Directions.Down, dt)
                character.faceDir = "down"
            end
        else
            world.delta = 0
            if world.y%100 == 0  and world.y == world.ny and world.x%100 == 0  and world.x == world.nx then
                character_update(dt)
            end
            character.animation.sound:stop()
        end
    
end

function world_draw()
    character_draw()
    benchboard_draw()
    barrier_draw()
    triggerDraw()
    -- monster_draw()
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
    tree[1] = tree.new(200,200)
    questionMark[1] = questionMark1.new(300,300)
    q3Trap[1] = q3Trap.new(500,500)
    q3Trap[2] = q3Trap.new(900,500)
    questionMark[2] = questionMark2.new(800,300)
    q2key = q2key.new(500,800)
    questionMark[3] = questionMark3.new(700,600)
    q3key = q3key.new(700,200)
end



function mapMove(direction, dt)
    
     if direction == character.animation.Directions.Down and question==false then
        if world.y < world.ny then
            character.animation.walking = true
            character.animation.sound:play()
            world.y = world.y + world.speed * dt
        end
        if world.y + world.speed * dt>world.ny then
            world.y = world.ny
        end
        characterSetDirection( character.animation.Directions.Down)
       
    end
    
    if direction == character.animation.Directions.Left and question==false then
        if world.x > world.nx then
            character.animation.walking = true
            character.animation.sound:play()
            world.x = world.x - world.speed * dt
        end
        if world.x - world.speed * dt<world.nx then
            world.x = world.nx
        end
        characterSetDirection( character.animation.Directions.Left)

    end
    
    if direction == character.animation.Directions.Right and question==false then
         if world.x < world.nx then
            character.animation.walking = true
            character.animation.sound:play()
            world.x = world.x + world.speed * dt
        end
        if world.x + world.speed * dt>world.nx then
            world.x = world.nx
        end
        characterSetDirection( character.animation.Directions.Right)

    end
    
    if direction == character.animation.Directions.Up and question==false then
        if world.y > world.ny then
            character.animation.walking = true
            character.animation.sound:play()
            world.y = world.y - world.speed * dt
        end
        if world.y - world.speed * dt<world.ny then
            world.y = world.ny
        end
        characterSetDirection( character.animation.Directions.Up)
        
    end
 
end

function isBarrier(barrierX,barrierY)
    if character.nx >barrierX-characterWidth and character.nx<barrierX+characterWidth and character.ny > barrierY-characterHeight and character.ny<barrierY+characterHeight then 
        character.nx =character.px
        character.ny =character.py
        character.animation.walking = true
        character.animation.sound:play()
    end
   -- if world.nx >barrierX-characterWidth and world.nx<barrierX+characterWidth and world.ny > barrierY-characterHeight and world.ny<barrierY+characterHeight then 
     --   world.nx =world.px
       -- world.ny =world.py
        --character.animation.walking = true
        --character.animation.sound:play()
    --end
end

function barrier_draw()
    for i=1,1 do
        love.graphics.draw(tree[i].Image,tree[i].x-world.x,tree[i].y-world.y)
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
    if q3Trap[1].showBar == true then
        love.graphics.setColor(255,0,0)
        love.graphics.rectangle("fill", q3Trap[1].x-world.x+100,q3Trap[1].y-world.y+50 , q3Trap[2].x-q3Trap[1].x-100, 10 )
    end
    love.graphics.draw(monster1.slimeImgFile, monster1.slimeQuads[monster1.moveStep[monster1.moveIndex]][monster1.animationIndex], monster1.nowX-world.x, monster1.nowY-world.y)
end
