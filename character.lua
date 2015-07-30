character={}
local characterSpeed=300
local characterX,characterY=love.graphics.getDimensions( )
local characterHeight=100
local characterWidth=100
--character.__index = character

function character_load()
    require "battle"
    battle_load()
    characterX=characterX/2
    characterY=characterY/2
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
    love.graphics.setBackgroundColor(255,255,255)
    love.graphics.setColor(255,255,255,255)
    characterDraw()
    battle_attack(character.x,character.y,character.faceDir)
end

--------------------------characterCreat-----------------------------------
function characterCreate()
    character.x = characterX
    character.y = characterY
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
    character.faceDir = "left"
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
        if love.keyboard.isDown("left") then
            characterMove(character.Directions.Left, dt)
            character.faceDir = "left"
            character.animation.sound:play()
        elseif love.keyboard.isDown("right") then
            characterMove(character.Directions.Right, dt)
            character.faceDir = "right"
            character.animation.sound:play()
        elseif love.keyboard.isDown("up") then
            characterMove(character.Directions.Up, dt)
            character.faceDir = "up"
            character.animation.sound:play()
        elseif love.keyboard.isDown("down") then
            characterMove(character.Directions.Down, dt)
            character.faceDir = "down"
            character.animation.sound:play()
        else
            characterStop()
            character.animation.sound:stop()
        end
    end
end

-----------------characterMove----------------------------------------------
function characterMove(direction, dt)
    if direction == character.animation.Directions.Down then
        character.animation.walking = true
        character.y = character.y + character.speed * dt
        characterSetDirection( character.animation.Directions.Down)
    end
    if direction == character.animation.Directions.Left then
        character.animation.walking = true
        character.x = character.x - character.speed * dt
        characterSetDirection( character.animation.Directions.Left)
    end
    if direction == character.animation.Directions.Right then
        character.animation.walking = true
        character.x = character.x + character.speed * dt
        characterSetDirection( character.animation.Directions.Right)
    end
    if direction == character.animation.Directions.Up then
        character.animation.walking = true
        character.y = character.y - character.speed * dt
        characterSetDirection( character.animation.Directions.Up)
    end
    -- keep the character on the screen
    if character.x > love.graphics.getWidth()-characterWidth then character.x = love.graphics.getWidth()-characterWidth
    end
    if character.x < 0 then character.x = 0
    end
    if character.y > love.graphics.getHeight()-characterHeight then character.y = love.graphics.getHeight()-characterHeight
    end
    if character.y < 0 then character.y = 0
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

--------------------characterDraw-----------------------------------------------
function characterDraw()
    if character.disappear.disappearFlog==false then
        love.graphics.draw(character.animation.characterImage, character.animation.sprites[character.animation.nowAnimation][character.animation.nowFrame], character.x, character.y)

    end
    if character.hp>=0 then
        love.graphics.setColor(255,0,0,255)
        love.graphics.rectangle("fill", 10, 10, character.hp*3, 5 )
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
