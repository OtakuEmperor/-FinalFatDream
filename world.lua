world={}
tree={}
local screenWidth,screenHeight=love.graphics.getDimensions( )
function world_load()
    require "character"
    require "benchboard"
    require "monster"
    character_load()
    benchboard_load()
    monster_load()
    barrierCreate()
    mapCreate()
end

function world_update(dt)
   monster_update(dt)
    if world.rightMove and world.x<world.px and character.faceDir == "right" then
        character.animation.walking = true
        if world.x + world.speed * 0.05<world.px then
            world.x = world.x + world.speed * 0.05
        else
            world.x=world.px
            world.count1=true
        end
    
    elseif world.leftMove and world.x>world.px and character.faceDir == "left" then
        character.animation.walking = true
        if world.x - world.speed * 0.05>world.px then
            world.x = world.x - world.speed * 0.05
        else
            world.x=world.px
            world.count1=true
        end
    elseif world.downMove and world.y<world.py and character.faceDir == "down" then
        character.animation.walking = true
        if world.y + world.speed * 0.05<world.py then
            world.y = world.y + world.speed * 0.05
        else
            world.y=world.py
            world.count1=true
        end
        
    elseif world.upMove and world.y>world.py and character.faceDir == "up" then
        character.animation.walking = true
        if world.y - world.speed * 0.05>world.py then
            world.y = world.y - world.speed * 0.05
        else
            world.y=world.py
            world.count1=true
        end
    elseif world.rightMove and love.keyboard.isDown("right") and character.y%100 == 0  and character.y == character.py then
        map_run(dt)
        if world.count1 == true or character.faceDir == "right" then
            world.ny=world.py
            mapMove(character.Directions.Right, dt)
            character.faceDir = "right"
        elseif world.count1 == false then
            mapStop()
        end
    
    elseif world.leftMove and love.keyboard.isDown("left") and character.y%100 == 0  and character.y == character.py then
        map_run(dt)
        if world.count1 == true or character.faceDir == "left" then
            world.ny=world.py
            mapMove(character.Directions.Left, dt)
            character.faceDir = "left"
        elseif world.count1 == false then
            mapStop()
        end
    
    elseif world.upMove and love.keyboard.isDown("up") and character.x%100 == 0  and character.x == character.px then
        map_run(dt)
        if world.count1 == true or world.faceDir == "up" then
            world.nx=world.px
            mapMove(character.Directions.Up, dt)
            character.faceDir = "up"
        elseif world.count1 == false then 
            mapStop()
        end
        
    elseif world.downMove and love.keyboard.isDown("down") and character.x%100 == 0  and character.x == character.px then
        map_run(dt)
        if world.count1 == true or world.faceDir == "down" then
            world.nx=world.px
            mapMove(character.Directions.Down, dt)
            character.faceDir = "down"
        elseif world.count1 == false then   
            mapStop()
        end
    else
        if world.leftMove or world.rightMove or world.upMove or world.downMove then
            mapStop()
        end
        if world.y%100 == 0  and world.y == world.py and world.x%100 == 0  and world.x == world.px then
            character_update(dt)
        end
        if character.faceDir == "left" and character.nx  < 400 and world.x ~= 0 then
            world.leftMove = true
    
        elseif character.faceDir == "right" and character.nx > 600 and world.x + screenWidth < world.width then
            world.rightMove = true
        elseif character.faceDir == "down" and character.ny > 400 and world.y + screenHeight < world.height then
            world.downMove = true
        elseif character.faceDir == "up" and character.ny  < 200 and world.y ~= 0 then
            world.upMove = true
        end
    end
end

function world_draw()
    character_draw()
    benchboard_draw()
    barrier_draw()
    monster_draw()
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
end

function barrierCreate()
    tree.x=300
    tree.y=300
    tree.Image = love.graphics.newImage("img/tree.png")
    tree.Barrier=true
end

function map_run(dt)
    character.animation.count = character.animation.count + dt
    if character.animation.count >= character.animation.delay then
        character.animation.nowFrame = (character.animation.nowFrame % character.animation.frames) + 1
        character.animation.count = 0
    end
    character.animation.sound:play()
end

function mapMove(direction, dt)
    if direction == character.animation.Directions.Right then
        if world.count == false then
            if world.temp == true then
                world.px=world.x
                world.temp = false
            end
            world.nx = world.nx + world.speed * dt
        else
            character.animation.walking = true
            character.animation.sound:play()
            if world.x + world.speed * 0.03<world.nx then
                world.x = world.x + world.speed * 0.03
                world.x = math.ceil(world.x)
            else
                world.x=world.nx
                world.count=false
            end
            world.count1 = false
        end
        
        if math.abs(world.x-world.nx) > characterWidth*4/10 then
            world.count=true
            world.nx = world.px + characterWidth
            world.temp = true
        end
        characterSetDirection( character.animation.Directions.Right)
    end
    
    if direction == character.animation.Directions.Left then
        if world.count == false then
            if world.temp == true then
                world.px=world.x
                world.temp = false
            end
            world.nx = world.nx - world.speed * dt
        else
            character.animation.walking = true
            character.animation.sound:play()
            if world.x - world.speed * 0.03>world.nx then
                world.x = world.x - world.speed * 0.03
                world.x = math.ceil(world.x)
            else
                world.x=world.nx
                world.count=false
            end
            world.count1 = false
        end
        
        if math.abs(world.x-world.nx) > characterWidth*4/10 then
            world.count=true
            world.nx = world.px - characterWidth
            world.temp = true
        end
        characterSetDirection( character.animation.Directions.Left)
    end
    
    if direction == character.animation.Directions.Down then
        if world.count == false then
            if world.temp == true then
                world.py=world.y
                world.temp = false
            end
            world.ny = world.ny + world.speed * dt
        else
            character.animation.walking = true
            character.animation.sound:play()
            if world.y + world.speed * 0.03<world.ny then
                world.y = world.y + world.speed * 0.03
                world.y = math.ceil(world.y)
            else
                world.y=world.ny
                world.count=false
            end
            world.count1 = false
        end
        
        if math.abs(world.y-world.ny) > characterWidth*4/10 then
            world.count=true
            world.ny = world.py + characterWidth
            world.temp = true
        end
        characterSetDirection( character.animation.Directions.Down)
    end
    
    if direction == character.animation.Directions.Up then
        if world.count == false then
            if world.temp == true then
                world.py=world.y
                world.temp = false
            end
            world.ny = world.ny - world.speed * dt
        else
            character.animation.walking = true
            character.animation.sound:play()
            if world.y - world.speed * 0.03>world.ny then
                world.y = world.y - world.speed * 0.03
                world.y = math.ceil(world.y)
            else
                world.y=world.ny
                world.count=false
            end
            world.count1 = false
        end
        
        if math.abs(world.y-world.ny) > characterWidth*4/10 then
            world.count=true
            world.ny = world.py - characterWidth
            world.temp = true
        end
        characterSetDirection( character.animation.Directions.Up)
    end
    
    if character.faceDir == "right" and world.x + screenWidth  >= world.width then
        world.x=world.nx
        world.px=world.nx
        world.rightMove = false
    end
    
    if character.nx < 600 then
        world.rightMove = false
    end
    
    if character.faceDir == "left" and world.x == 0 then
        world.px=0
        world.nx=0
        world.leftMove = false
    end
    
    if character.nx > 400 then
        world.leftMove = false
    end
    
    if character.faceDir == "down" and world.ny + screenHeight-characterHeight >= world.height then
        world.y=world.ny
        world.py=world.ny
        world.downMove = false
    end
    
    if character.ny < 400 then
        world.downMove = false
    end
    
    if character.faceDir == "up" and world.y == 0 then
        world.py=0
        world.ny=0
        world.upMove = false
    end
    
    if character.ny > 200 then
        world.upMove = false
    end
end

function mapStop()
    character.animation.nowFrame = 1 
    if world.count == false then
        world.nx=world.px
        world.ny=world.py
        world.count1 = true
    else
        if character.faceDir == "right" then 
            world.px=world.px+characterWidth
        end
        if character.faceDir == "left" then
            world.px=world.px-characterWidth
        end
        if character.faceDir == "down" then
            world.py=world.py+characterHeight
        end
        if character.faceDir == "up" then
            world.py=world.py-characterHeight
        end
        world.count = false
        world.temp = true
    end
end

function isBarrier(barrierX,barrierY)
    if character.nx >barrierX-characterWidth and character.nx<barrierX+characterWidth and character.ny > barrierY-characterHeight and character.ny<barrierY+characterHeight then 
        character.nx =character.px
        character.ny =character.py
        character.animation.walking = true
        character.animation.sound:play()
    end
end

function barrier_draw()
    love.graphics.draw(tree.Image,tree.x-world.x,tree.y-world.y)
    if tree.Barrier then
        isBarrier(tree.x-world.x,tree.y-world.y)
    end
end
