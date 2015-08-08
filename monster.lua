monster={}
local monsterSpeed=300
local monsterX,monsterY=love.graphics.getDimensions( )
local monsterHeight=100
local monsterWidth=100
--monster.__index = monster

function monster_load()
    monsterX=monsterX/2
    monsterY=monsterY/2
    monsterCreate()
    monsterLoad()
end

function monster_update(dt)
    monsterUpdate(dt)
    if love.keyboard.isDown("-") then
        monster.hp=monster.hp-1
    end
    battle_update(dt)
    battle_keyPress(key)
end


function monster_draw()
    love.graphics.setBackgroundColor(255,255,255)
    love.graphics.setColor(255,255,255,255)
    monsterDraw()
    battle_attack(monster.x,monster.y,monster.faceDir)
end

--------------------------monsterCreat-----------------------------------
function monsterCreate()
    monster.x = monsterX
    monster.y = monsterY
    monster.hp=100
    monster.die=false
    monster.speed = monsterSpeed
    monster.animation = walkCreate("img/slime.png", monsterWidth, monsterHeight, 4, 4)
    monster.disappear=disappearCreate()
    monster.Directions = {
        ["Left"] = 3,
        ["Up"] = 2,
        ["Down"] = 1,
        ["Right"] = 4
    }
    monster.faceDir = "left"
end

------------------------monsterLoad--------------------------------------
function monsterLoad()
    for i = 1, monster.animation.animations do
        local h = monster.animation.height * (i-1)
        monster.animation.sprites[i] = {}
        for j = 1, monster.animation.frames do
            local w = monster.animation.width * (j-1)
            monster.animation.sprites[i][j] = love.graphics.newQuad(w, h, monster.animation.width, monster.animation.height, monster.animation.monsterImage:getWidth(), monster.animation.monsterImage:getHeight())
        end
    end
end

--------------------monsterUpdate--------------------------------------
function monsterUpdate(dt)
    if monster.animation.walking then
        monster.animation.count = monster.animation.count + dt
        if monster.animation.count >= monster.animation.delay then
            monster.animation.nowFrame = (monster.animation.nowFrame % monster.animation.frames) + 1
            monster.animation.count = 0
        end
    end

    if monster.hp<=0 then
        monster.die=true
    end
    if monster.die==true then
        monster.animation.monsterImage = love.graphics.newImage("img/baddies.png")
        monster.disappear.count = monster.disappear.count + dt
        if monster.disappear.count >=monster.disappear.delay then
            monster.disappear.disappearFlog=true
            monster.disappear.count = 0
        end
    end

    if monster.die==false then
        if love.keyboard.isDown("left") then
            monsterMove(monster.Directions.Left, dt)
            monster.faceDir = "left"
            monster.animation.sound:play()
        elseif love.keyboard.isDown("right") then
            monsterMove(monster.Directions.Right, dt)
            monster.faceDir = "right"
            monster.animation.sound:play()
        elseif love.keyboard.isDown("up") then
            monsterMove(monster.Directions.Up, dt)
            monster.faceDir = "up"
            monster.animation.sound:play()
        elseif love.keyboard.isDown("down") then
            monsterMove(monster.Directions.Down, dt)
            monster.faceDir = "down"
            monster.animation.sound:play()
        else
            monsterStop()
            monster.animation.sound:stop()
        end
    end
end

-----------------monsterMove----------------------------------------------
function monsterMove(direction, dt)
    if direction == monster.animation.Directions.Down then
        monster.animation.walking = true
        monster.y = monster.y + monster.speed * dt
        monsterSetDirection( monster.animation.Directions.Down)
    end
    if direction == monster.animation.Directions.Left then
        monster.animation.walking = true
        monster.x = monster.x - monster.speed * dt
        monsterSetDirection( monster.animation.Directions.Left)
    end
    if direction == monster.animation.Directions.Right then
        monster.animation.walking = true
        monster.x = monster.x + monster.speed * dt
        monsterSetDirection( monster.animation.Directions.Right)
    end
    if direction == monster.animation.Directions.Up then
        monster.animation.walking = true
        monster.y = monster.y - monster.speed * dt
        monsterSetDirection( monster.animation.Directions.Up)
    end
    -- keep the monster on the screen
    if monster.x > love.graphics.getWidth()-monsterWidth then monster.x = love.graphics.getWidth()-monsterWidth
    end
    if monster.x < 0 then monster.x = 0
    end
    if monster.y > love.graphics.getHeight()-monsterHeight then monster.y = love.graphics.getHeight()-monsterHeight
    end
    if monster.y < 0 then monster.y = 0
    end
end

----------------------monsterSetDirection------------------------------------
function monsterSetDirection(direction)
    monster.animation.animating = true
    monster.animation.nowAnimation = direction
end

---------------------monsterStop------------------------------------------
function monsterStop()
    monster.animation.walking = false
    if not monster.animation.walking then
        monster.animation.nowFrame = 1
    end
end

--------------------monsterDraw-----------------------------------------------
function monsterDraw()
    if monster.disappear.disappearFlog==false then
        love.graphics.draw(monster.animation.monsterImage, monster.animation.sprites[monster.animation.nowAnimation][monster.animation.nowFrame], monster.x, monster.y)

    end
    if monster.hp>=0 then
        love.graphics.setColor(255,0,0,255)
        love.graphics.rectangle("fill", 10, 10, monster.hp*3, 5 )
    end
end

--------------------walkCreate-----------------------------------------
function walkCreate(file, width, height, frames, animations)
    local walk = {}
    --setmetatable(walk, monster)
    walk.width = width
    walk.height = height
    walk.frames = frames
    walk.animations = animations
    walk.monsterImage = love.graphics.newImage(file)
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
