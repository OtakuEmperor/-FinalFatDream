character={}
local hpDecrease=0
local characterSpeed=300
local characterX,characterY=love.graphics.getDimensions( )
local screenWidth,screenHeight=love.graphics.getDimensions( )
local heroTryCatchDelay=0.15
local heroTryCatchDelta=0
local heroTryCatchCountX=0
local heroTryCatchCountY=0
local heroTryCatchLock=true
characterHeight=100
characterWidth=100
--character.__index = character

function character_load()
    require "battle"
    require "trigger"
    battle_load()
    triggerLoad()
    characterX=500
    characterY=300
    isCharacterWake = true
    characterWakeTimer = 0
    characterCreate()
    characterLoad()
end

function character_update(dt)
    characterUpdate(dt)
    if love.keyboard.isDown("-") then
        character.hp=character.hp-1
    end
end

function character_keyPressed(key)
    if world1_dialogLock and q1_dialogLock and q2_dialogLockKey and q2_dialogLockLine and q3_dialogLock and npc_dialogLock and boss1_dialogLock and q4_dialogLockKey and q5_dialogLockKey then
        battle_keyPress(key)
    end
    if love.keyboard.isDown("q") then
        if character.water and not (character.hp == character.maxHp) then
            character.water = false
            character.hp = character.hp + 10
        end
    end
    if love.keyboard.isDown("w") then
        if character.weapon == "sword" then
            character.weapon = "gun"
            character.atk = 50
            atk_range = 500
        elseif character.weapon == "gun" then
            character.weapon = "sword"
            character.atk = 5
            atk_range = 100
        end
    end
end

function character_draw()
    love.graphics.setColor(255,255,255)
    characterDraw()
    battle_draw()
end

--------------------------characterCreat-----------------------------------
function characterCreate()
    character.x = characterX
    character.y = characterY
    character.nx=characterX
    character.ny=characterY
    character.count=false
    --character.count1=true
    --character.temp=true
    character.px=characterX
    character.py=characterY
    character.maxHp=100
    character.hp=100
    character.die=false
    character.atk=5
    character.speed = characterSpeed
    character.animation = walkCreate("img/hero.png", characterWidth, characterHeight, 4, 4)
    character.disappear=disappearCreate()
    character.Directions = {
        ["Left"] = 3,
        ["Up"] = 2,
        ["Down"] = 1,
        ["Right"] = 4
    }
    character.faceDir = "down"
    character.delay=0.15
    character.delta=0
    character.backMove=false
    character.water = false
    character.weapon = "sword"
    character.bullet = 10
    charUnderAttack = love.audio.newSource("audio/charUnderAttack.wav", "static")
end

------------------------characterLoad--------------------------------------
function characterLoad()
    for i = 1, character.animation.animations do
        local h = character.animation.height * (i-1)
        character.animation.sprites[i] = {}
        for j = 1, character.animation.frames do
            local w = character.animation.width * (j-1)
            character.animation.sprites[i][j] = love.graphics.newQuad(w, h, character.animation.width, character.animation.height, character.animation.characterImage:getWidth(), character.animation.characterImage:getHeight())
        end
    end
end

--------------------characterUpdate--------------------------------------
function characterUpdate(dt)
   -- character_run(dt)
    world.py = world.y
    world.px = world.x

    if character.hp<=0 then
        character.die=true
    end

    -- if character.die==true then
    --    character.animation.characterImage = love.graphics.newImage("img/baddies.png")
    --     character.disappear.count = character.disappear.count + dt
    --     if character.disappear.count >=character.disappear.delay then
    --        character.disappear.disappearFlog=true
    --        character.disappear.count = 0
    --     end
    -- end
    if character.backMove == true then
        character.speed = 1000
        charabackMoveUpdate(dt)
    elseif character.die==false and question==false and conversation == false then
        character.speed = characterSpeed
        moveStageCheck()
        if character.x<character.nx and character.faceDir == "right" then
             character.animation.walking = true
            characterMove(character.Directions.Right, dt)
            characterSetDirection( character.animation.Directions.Right)
        elseif character.x>character.nx and character.faceDir == "left" then
            character.animation.walking = true
            characterMove(character.Directions.Left, dt)
            characterSetDirection( character.animation.Directions.Left)

        elseif character.y<character.ny and character.faceDir == "down" then
            character.animation.walking = true
            characterMove(character.Directions.Down, dt)
            characterSetDirection( character.animation.Directions.Down)
        elseif character.y>character.ny and character.faceDir == "up" then
            character.animation.walking = true
            characterMove(character.Directions.Up, dt)
             characterSetDirection( character.animation.Directions.Up)
         elseif love.keyboard.isDown("left") and character.y%100 == 0 and character.y == character.ny and character.x%100 == 0 and character.x == character.nx then
            character.animation.walking = true
            characterSetDirection( character.animation.Directions.Left)
            character.faceDir = "left"
            character.delta = character.delta + dt
            if character.delta >= character.delay then
                character.py = character.y
            character.px = character.x
                if character.nx ~= 0 and world.leftMove==false and character.count==false then
                    character.nx = character.x - 100

                end
                if character.animation.walking == false then
                    character.delta=0
                end
                characterMove(character.Directions.Left, dt)
            end
             elseif love.keyboard.isDown("right") and character.y%100 == 0 and character.y == character.ny and character.x%100 == 0 and character.x == character.nx then
            character.animation.walking = true
            characterSetDirection( character.animation.Directions.Right)
            character.faceDir = "right"
            character.delta = character.delta + dt
            if character.delta >= character.delay then
                character.py = character.y
            character.px = character.x
                if character.nx ~= 1000 and world.rightMove==false and character.count==false then
                    character.nx = character.x + 100
                end
                if character.animation.walking == false then
                    character.delta=0
                end
                characterMove(character.Directions.Right, dt)
            end
             elseif love.keyboard.isDown("up") and character.y%100 == 0 and character.y == character.ny and character.x%100 == 0 and character.x == character.nx  then
            character.animation.walking = true
            characterSetDirection( character.animation.Directions.Up)
            character.faceDir = "up"
            character.delta = character.delta + dt
            if character.delta >= character.delay then
                character.py = character.y
            character.px = character.x
                if character.ny ~= 0 and world.upMove==false and character.count==false then
                    character.ny = character.y - 100
                end
                if character.animation.walking == false then
                    character.delta=0
                end
                characterMove(character.Directions.Up, dt)
            end
             elseif love.keyboard.isDown("down") and character.y%100 == 0 and character.y == character.ny and character.x%100 == 0 and character.x == character.nx  then
            character.animation.walking = true
            characterSetDirection( character.animation.Directions.Down)
            character.faceDir = "down"
            character.delta = character.delta + dt
            if character.delta >= character.delay then
                character.py = character.y
            character.px = character.x
                if character.ny ~= 500 and world.downMove==false and character.count==false then
                    character.ny = character.y + 100
                end
                if character.animation.walking == false then
                    character.delta=0
                end
                characterMove(character.Directions.Down, dt)
            end

        else
            if character.backMove == false then
                characterStop()
            end
            character.py = character.y
            character.px = character.x
            character.animation.sound:stop()
        end
    end
end
------------------function backMoveUpdate()--------------------
function charabackMoveUpdate(dt)
    if character.backMove == true then
        moveStageCheck()
        if character.x<character.nx and character.faceDir == "left" then
             character.animation.walking = true
            characterMove(character.Directions.Right, dt)
            characterSetDirection( character.animation.Directions.Left)
        elseif character.x>character.nx and character.faceDir == "right" then
            character.animation.walking = true
            characterMove(character.Directions.Left, dt)
            characterSetDirection( character.animation.Directions.Right)

        elseif character.y<character.ny and character.faceDir == "up" then
            character.animation.walking = true
            characterMove(character.Directions.Down, dt)
            characterSetDirection( character.animation.Directions.Up)
        elseif character.y>character.ny and character.faceDir == "down" then
            character.animation.walking = true
            characterMove(character.Directions.Up, dt)
             characterSetDirection( character.animation.Directions.Down)
        else
            character.py = character.y
            character.px = character.x
            character.animation.sound:stop()
            character.backMove =false
        end
    end
end
-----------------characterMove----------------------------------------------
function characterMove(direction, dt)
    character.animation.sound:setVolume(getVol())
    if direction == character.animation.Directions.Down and question==false and conversation == false then
        character.animation.sound:play()
        if character.y < character.ny then
            character.animation.walking = true
            character.y = character.y + character.speed * dt
        end
        if character.y + character.speed * dt>character.ny then
            character.y = character.ny
        end

    end

    if direction == character.animation.Directions.Left and question==false and conversation == false then
        character.animation.sound:play()
        if character.x > character.nx then
            character.animation.walking = true
            character.x = character.x - character.speed * dt
        end
        if character.x - character.speed * dt<character.nx then
            character.x = character.nx
        end


    end

    if direction == character.animation.Directions.Right and question==false and conversation == false then
         character.animation.sound:play()
        if character.x < character.nx then
            character.animation.walking = true
            character.x = character.x + character.speed * dt
        end
        if character.x + character.speed * dt>character.nx then
            character.x = character.nx
        end


    end

    if direction == character.animation.Directions.Up and question==false and conversation == false then
        character.animation.sound:play()
        if character.y > character.ny then
            character.animation.walking = true
            character.y = character.y - character.speed * dt
        end
        if character.y - character.speed * dt<character.ny then
            character.y = character.ny
        end


    end


end

----------------------characterSetDirection------------------------------------
function characterSetDirection(direction)
    character.animation.animating = true
    character.animation.nowAnimation = direction
end

---------------------characterStop------------------------------------------
function characterStop()
    character.animation.walking = false
    if not character.animation.walking then
        character.animation.nowFrame = 1
    end
    character.delta=0
    world.delta=0
end

function character_run(dt)
    if character.animation.walking then
        character.animation.count = character.animation.count + dt
        if character.animation.count >= character.animation.delay then
            character.animation.nowFrame = (character.animation.nowFrame % character.animation.frames) + 1
            character.animation.count = 0
        end
    end

    if isCharacterWake then
        characterWakeTimer = characterWakeTimer + dt
    else
        characterWakeTimer = 0
    end
    if characterWakeTimer >= 0.2 then
        character.hp=character.hp-0.04
        characterWakeTimer = 0
    end
    battle_update(dt)
    if character.hp > character.maxHp then
        character.hp = 100
    elseif character.hp < 0 then
        character.hp = 0
    end
end
function moveStageCheck()
    if  character.x  < 400 and world.x ~= 0 then
            world.leftMove = true
        else
            world.leftMove = false
        end

        if character.x > 600 and world.x + screenWidth < world.width then
        world.rightMove = true
        else
       -- character.py = character.y
    --character.px = character.x
        world.rightMove = false
        end
        if  character.y > 200 and world.y + screenHeight < world.height then
            world.downMove = true
        else
            world.downMove = false
        end
        if  character.y  < 300 and world.y ~= 0 then
            world.upMove = true
        else
            world.upMove = false
        end
    end
--------------------characterDraw-----------------------------------------------
function characterDraw()
    if character.disappear.disappearFlog==false then
        love.graphics.draw(character.animation.characterImage, character.animation.sprites[character.animation.nowAnimation][character.animation.nowFrame], character.x, character.y)

    end
    if character.hp>=0 then
        love.graphics.setColor(255,0,0,255)
        --love.graphics.rectangle("fill", 10, 10, character.hp*3, 5 )
    end
end

--------------------walkCreate-----------------------------------------
function walkCreate(file, width, height, frames, animations)
    local walk = {}
    --setmetatable(walk, character)
    walk.width = width
    walk.height = height
    walk.frames = frames
    walk.animations = animations
    walk.characterImage = love.graphics.newImage(file)
    walk.sprites = {}
    walk.nowFrame = 1
    walk.nowAnimation = 1
    walk.delay = 0.08
    walk.count = 0
    walk.walking = false
    walk.sound = love.audio.newSource("audio/walking.wav")
    walk.Directions = {
        ["Left"] = 3,
        ["Up"] = 2,
        ["Down"] = 1,
        ["Right"] = 4
    }
    return walk
end

--------------------disappearCreate------------------------------------
function disappearCreate()
    local die={}
    die.disappearFlog=false
    die.delay=0.3
    die.count=0
    return die
end

function getHeroX()
    return character.x
end

function getHeroY()
    return character.y
end

function hpDecline(hpDecrease)
    character.hp=character.hp-hpDecrease
    interface.isAttacked = true
    love.audio.setVolume(0.4)
    charUnderAttack:play()
    return character.hp
end

function getHeroHP()
    return character.hp
end

function getHeroMaxHP()
    return character.maxHp
end

function charaMoveBack(backFace,dt)
    if world.leftMove == true and backFace == "left" and world.backMove == false then
        if world.nx==world.x and world.nx-100 >= 300 and world.count==false then
            world.nx = world.nx -100
        elseif world.nx ~= world.x and world.nx-200 >= 300 and world.count==false then
            world.nx = world.nx-200
        end
        characterSetDirection( character.animation.Directions.Right)
        character.faceDir = "right"
        character.animation.walking = true
        mapMove(character.Directions.Left, dt)
        world.backMove =true
    elseif world.rightMove == true and backFace == "right" and world.backMove == false then
        if world.nx==world.x and world.nx+100 <= 800 and world.count==false then
            world.nx = world.nx +100
        elseif world.nx ~= world.x and world.nx+200 <= 800 and world.count==false then
            world.nx = world.nx+200
        end
        characterSetDirection( character.animation.Directions.Left)
        character.faceDir = "left"
        character.animation.walking = true
        mapMove(character.Directions.Right, dt)
        world.backMove =true
    elseif world.upMove == true and backFace == "up" and world.backMove == false then
        if world.ny==world.y and world.ny-100 >= 100 and world.count==false then
            world.ny = world.ny -100
        elseif world.ny ~= world.y and world.ny-200 >= 100 and world.count==false then
            world.ny = world.ny-200
        end
        characterSetDirection( character.animation.Directions.Down)
        character.faceDir = "down"
        character.animation.walking = true
        mapMove(character.Directions.Up, dt)
        world.backMove =true
    elseif world.downMove == true and backFace == "down" and world.backMove == false then
        if world.ny==world.y and world.ny+100 <= 500 and world.count==false then
            world.ny = world.ny +100
        elseif world.ny ~= world.y and world.ny+200 <= 100 and world.count==false then
            world.ny = world.ny+200
        end
        characterSetDirection( character.animation.Directions.Up)
        character.faceDir = "up"
        character.animation.walking = true
        mapMove(character.Directions.Down, dt)
        world.backMove =true
    else
        if backFace == "left" and character.backMove == false then
            if character.nx==character.x and character.nx-100 >= 0 and world.leftMove==false and character.count==false then
                    character.nx = character.nx -100
            elseif character.nx ~= character.x and character.nx-200 >= 0 and world.leftMove==false and character.count==false then
                    character.nx = character.nx-200
            end
            characterSetDirection( character.animation.Directions.Right)
            character.faceDir = "right"
            character.animation.walking = true
            characterMove(character.Directions.Left, dt)
            character.backMove =true
        elseif backFace == "right" and character.backMove == false then
            if character.nx==character.x and character.nx+100 <= 1000 and world.rightMove==false and character.count==false then
                    character.nx = character.nx +100
            elseif character.nx ~= character.x and character.nx+200 <= 1000 and world.rightMove==false and character.count==false then
                    character.nx = character.nx+200
            end
            characterSetDirection( character.animation.Directions.Left)
            character.faceDir = "left"
            character.animation.walking = true
            characterMove(character.Directions.Right, dt)
            character.backMove =true
        elseif backFace == "up" and character.backMove == false then
            if character.ny==character.y and character.ny-100 >= 0 and world.upMove==false and character.count==false then
                    character.ny = character.ny -100
            elseif character.ny ~= character.y and character.ny-200 >= 0 and world.upMove==false and character.count==false then
                    character.ny = character.ny-200
            end
            characterSetDirection( character.animation.Directions.Down)
            character.faceDir = "down"
            character.animation.walking = true
            characterMove(character.Directions.Up, dt)
            character.backMove =true
        elseif backFace == "down" and character.backMove == false then
            if character.ny==character.y and character.ny+100 <= 500 and world.downMove==false and character.count==false then
                    character.ny = character.ny +100
            elseif character.ny ~= character.y and character.ny+200 <= 500 and world.downMove==false and character.count==false then
                    character.ny = character.ny+200
            end
            characterSetDirection( character.animation.Directions.Up)
            character.faceDir = "up"
            character.animation.walking = true
            characterMove(character.Directions.Down, dt)
            character.backMove =true
        end
    end
end
function heroTryCatch(dt)
     if heroTryCatchLock then
     heroTryCatchCountX=character.x
     heroTryCatchCountY=character.y
     heroTryCatchLock=false
    end
     heroTryCatchDelta = heroTryCatchDelta + dt
    if heroTryCatchDelta >= heroTryCatchDelay then
        if character.x == heroTryCatchCountX and character.x%100 ~=0 then
            if character.x % 100 >50 then
                character.x = character.x - (character.x % 100) + 100
                character.nx=character.x
            else
                character.x = character.x - (character.x % 100)
                character.nx=character.x   
            end
        end
        if character.y == heroTryCatchCountY and character.y%100 ~=0 then
            if character.y % 100 >50 then
                character.y = character.y - (character.y % 100) + 100
                character.ny=character.y
            else
                character.y = character.y - (character.y % 100)   
                character.ny=character.y
            end
        end
        heroTryCatchDelta=0
        heroTryCatchLock=true
    end

end