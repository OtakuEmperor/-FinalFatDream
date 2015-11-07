character={}
local hpDecrease=0
local characterSpeed=200
local characterX,characterY=love.graphics.getDimensions( )
local screenWidth,screenHeight=love.graphics.getDimensions( )
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
    characterCreate()
    characterLoad()
end

function character_update(dt)
    characterUpdate(dt)
    if love.keyboard.isDown("-") then
        character.hp=character.hp-1
    end
    battle_update(dt)
    battle_keyPress(key)
end


function character_draw()
    love.graphics.setColor(255,255,255)
    characterDraw()
    battle_attack(character.x,character.y,character.faceDir)

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
    character.hp=99
    character.die=false
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

    --if character.die==true then
      --  character.animation.characterImage = love.graphics.newImage("img/baddies.png")
        --character.disappear.count = character.disappear.count + dt
        --if character.disappear.count >=character.disappear.delay then
          --  character.disappear.disappearFlog=true
        --    character.disappear.count = 0
        --end
    --end

    if character.die==false and question==false then
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
            characterSetDirection( character.animation.Directions.Left)
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
                character.faceDir = "left"
            end
             elseif love.keyboard.isDown("right") and character.y%100 == 0 and character.y == character.ny and character.x%100 == 0 and character.x == character.nx then
            characterSetDirection( character.animation.Directions.Right)
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
                character.faceDir = "right"
            end
             elseif love.keyboard.isDown("up") and character.y%100 == 0 and character.y == character.ny and character.x%100 == 0 and character.x == character.nx  then
             characterSetDirection( character.animation.Directions.Up)
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
                character.faceDir = "up"
            end
             elseif love.keyboard.isDown("down") and character.y%100 == 0 and character.y == character.ny and character.x%100 == 0 and character.x == character.nx  then
            characterSetDirection( character.animation.Directions.Down)
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
                character.faceDir = "down"
            end

        else
            characterStop()
            character.py = character.y
            character.px = character.x
            character.animation.sound:stop()
        end
    end
end

-----------------characterMove----------------------------------------------
function characterMove(direction, dt)
    if direction == character.animation.Directions.Down and question==false then
        character.animation.sound:play()
        if character.y < character.ny then
            character.animation.walking = true
            character.y = character.y + character.speed * dt
        end
        if character.y + character.speed * dt>character.ny then
            character.y = character.ny
        end

    end

    if direction == character.animation.Directions.Left and question==false then
        character.animation.sound:play()
        if character.x > character.nx then
            character.animation.walking = true
            character.x = character.x - character.speed * dt
        end
        if character.x - character.speed * dt<character.nx then
            character.x = character.nx
        end


    end

    if direction == character.animation.Directions.Right and question==false then
         character.animation.sound:play()
        if character.x < character.nx then
            character.animation.walking = true
            character.x = character.x + character.speed * dt
        end
        if character.x + character.speed * dt>character.nx then
            character.x = character.nx
        end


    end

    if direction == character.animation.Directions.Up and question==false then
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
end

function character_run(dt)
    if character.animation.walking then
        character.animation.count = character.animation.count + dt
        if character.animation.count >= character.animation.delay then
            character.animation.nowFrame = (character.animation.nowFrame % character.animation.frames) + 1
            character.animation.count = 0
        end
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
        if  character.y > 300 and world.y + screenHeight < world.height then
            world.downMove = true
        else
            world.downMove = false
        end
        if  character.y  < 200 and world.y ~= 0 then
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
    return character.hp
end

function getHeroHP()
    return character.hp
end

function getHeroMaxHP()
    return character.maxHp
end
