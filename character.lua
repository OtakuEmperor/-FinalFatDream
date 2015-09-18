character={}
local characterSpeed=200
local characterX,characterY=love.graphics.getDimensions( )
characterHeight=100
characterWidth=100
--character.__index = character

function character_load()
    require "battle"
    battle_load()
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
    character.count1=true
    character.temp=true
    character.px=characterX
    character.py=characterY
    character.hp=100
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
    if character.animation.walking then
        character.animation.count = character.animation.count + dt
        if character.animation.count >= character.animation.delay then
            character.animation.nowFrame = (character.animation.nowFrame % character.animation.frames) + 1
            character.animation.count = 0
        end
    end

    if character.hp<=0 then
        character.die=true
    end
    
    if character.die==true then
        character.animation.characterImage = love.graphics.newImage("img/baddies.png")
        character.disappear.count = character.disappear.count + dt
        if character.disappear.count >=character.disappear.delay then
            character.disappear.disappearFlog=true
            character.disappear.count = 0
        end
    end

    if character.die==false then
        if character.x<character.px and character.faceDir == "right" then
            character.animation.walking = true
            if character.x + character.speed * 0.05<character.px then
                character.x = character.x + character.speed * 0.05
            else
                character.x=character.px
                character.count1=true
            end
        
        elseif character.x>character.px and character.faceDir == "left" then
            character.animation.walking = true
            if character.x - character.speed * 0.05>character.px then
                character.x = character.x - character.speed * 0.05
            else
                character.x=character.px
                character.count1=true
            end
        
        elseif character.y<character.py and character.faceDir == "down" then
            character.animation.walking = true
            if character.y + character.speed * 0.05<character.py then
                character.y = character.y + character.speed * 0.05
            else
                character.y=character.py
                character.count1=true
            end
        
        elseif character.y>character.py and character.faceDir == "up" then
            character.animation.walking = true
            if character.y - character.speed * 0.05>character.py then
                character.y = character.y - character.speed * 0.05
            else
                character.y=character.py
                character.count1=true
            end
        
        elseif love.keyboard.isDown("left")  and character.y%100 == 0 and character.y == character.py then
            if character.count1 == true or character.faceDir == "left" then
                character.ny=character.py
                characterMove(character.Directions.Left, dt)
                character.faceDir = "left"
            elseif character.count1 == false then
                characterStop()
            end
        
        elseif love.keyboard.isDown("right") and character.y%100 == 0  and character.y == character.py then
            if character.count1 == true or character.faceDir == "right" then
                character.ny=character.py
                characterMove(character.Directions.Right, dt)
                character.faceDir = "right"
            elseif character.count1 == false then
                characterStop()
            end
        
        elseif love.keyboard.isDown("up") and character.x%100 == 0  and character.x == character.px then
            if character.count1 == true or character.faceDir == "up" then
                character.nx=character.px
                characterMove(character.Directions.Up, dt)
                character.faceDir = "up"
            elseif character.count1 == false then 
                characterStop()
            end
        
        elseif love.keyboard.isDown("down") and character.x%100 == 0  and character.x == character.px then
            if character.count1 == true or character.faceDir == "down" then
                character.nx=character.px
                characterMove(character.Directions.Down, dt)
                character.faceDir = "down"
            elseif character.count1 == false then   
                characterStop()
            end
        
        else
            characterStop()
            character.animation.sound:stop()
        end
    end
end

-----------------characterMove----------------------------------------------
function characterMove(direction, dt)
    if direction == character.animation.Directions.Down then
        if character.count == false then
            if character.temp == true then
                character.py=character.y
                character.temp = false
            end
            character.ny = character.ny + character.speed * dt
        else
            character.animation.walking = true
            character.animation.sound:play()
            if character.y + character.speed * 0.03<character.ny then
                character.y = character.y + character.speed * 0.03
                character.y = math.ceil(character.y)
            else
                character.y=character.ny
                character.count=false
            end
            character.count1 = false
        end
        
        if math.abs(character.y-character.ny) > characterWidth*4/10 then
            character.count=true
            character.ny = character.py + characterWidth
            character.temp = true
        end
        characterSetDirection( character.animation.Directions.Down)
    end
    
    if direction == character.animation.Directions.Left then
        if character.count == false then
            if character.temp == true then
                character.px=character.x
                character.temp = false
            end
            character.nx = character.nx - character.speed * dt
        else
            character.animation.walking = true
            character.animation.sound:play()
            if character.x - character.speed * 0.03>character.nx then
                character.x = character.x - character.speed * 0.03
                character.x = math.ceil(character.x)
            else
                character.x=character.nx
                character.count=false
            end
            character.count1 = false
        end
        
        if math.abs(character.x-character.nx) > characterWidth*4/10 then
            character.count=true
            character.nx = character.px - characterWidth
            character.temp = true
        end
        characterSetDirection( character.animation.Directions.Left)
    end
    
    if direction == character.animation.Directions.Right then
        if character.count == false then
            if character.temp == true then
                character.px=character.x
                character.temp = false
            end
            character.nx = character.nx + character.speed * dt
        else
            character.animation.walking = true
            character.animation.sound:play()
            if character.x + character.speed * 0.03<character.nx then
                character.x = character.x + character.speed * 0.03
                character.x = math.ceil(character.x)
            else
                character.x=character.nx
                character.count=false
            end
            character.count1 = false
        end
        
        if math.abs(character.x-character.nx) > characterWidth*4/10 then
            character.count=true
            character.nx = character.px + characterWidth
            character.temp = true
        end
        characterSetDirection( character.animation.Directions.Right)
    end
    
    if direction == character.animation.Directions.Up then
        if character.count == false then
            if character.temp == true then
                character.py=character.y
                character.temp = false
            end
            character.ny = character.ny - character.speed * dt
        else
            character.animation.walking = true
            character.animation.sound:play()
            if character.y - character.speed * 0.03>character.ny then
                character.y = character.y - character.speed * 0.03
                character.y = math.ceil(character.y)
            else
                character.y=character.ny
                character.count=false
            end
            character.count1 = false
        end
        
        if math.abs(character.y-character.ny) > characterWidth*4/10 then
            character.count=true
            character.ny = character.py - characterWidth
            character.temp = true
        end
        characterSetDirection( character.animation.Directions.Up)
    end

    -- keep the character on the screen
    if character.nx > love.graphics.getWidth()-characterWidth+8 then 
        character.nx = love.graphics.getWidth()-characterWidth+8
        character.animation.walking = true
        character.animation.sound:play()
    end
    
    if character.nx < 0 then 
        character.nx = 0
        character.animation.walking = true
        character.animation.sound:play()
    end
    
    if character.ny > love.graphics.getHeight()-characterHeight then 
        character.ny = love.graphics.getHeight()-characterHeight
        character.animation.walking = true
        character.animation.sound:play()
    end
    
    if character.ny < 0 then 
        character.ny = 0
        character.animation.walking = true
        character.animation.sound:play()
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
        if character.count == false then
            character.nx=character.px
            character.ny=character.py
            character.count1 = true
        else
            if character.faceDir == "right" then 
                character.px=character.px+characterWidth
            end
            if character.faceDir == "left" then
                character.px=character.px-characterWidth
            end
            if character.faceDir == "down" then
                character.py=character.py+characterHeight
            end
            if character.faceDir == "up" then
                character.py=character.py-characterHeight
            end
            character.count = false
            character.temp = true
        end
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
