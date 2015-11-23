local creatMapLock=0
world5={}
local screenWidth,screenHeight=love.graphics.getDimensions( )
local characterX=500
local characterY=300
local resetKey = false
function world5_load()
    require "character"
    --require "slime"
    --require "boss1"
    require "barrierCreate"
    require "interface"
    require "barrierMove"
    --require "kagemusha"
    --monsters = {}
    --fight_bgm = love.audio.newSource("audio/night.mp3", "stream")
    --interface_load()
    --character_load()

end

function world5_update(dt)
    --reset Key
    if resetKey == false then
        zeroKey()
        resetKey = true
    end
    if creatMapLock==0 then
        barrierCreate5()
        mapCreate5()
        characterCreate5()
        creatMapLock = creatMapLock+1
    end
    interface_update(dt)
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
end

function world5_draw()
    -- print(string.format("%s %s\r\n%s %s\r\n", "hp", character.hp, "max.hp", character.maxHp))
    barrier5_draw()
    character_draw()
    interface_draw()
    --testdraw()
    love.audio.setVolume(0.8)
    fight_bgm:play()
end
function characterCreate5()
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
function mapCreate5()
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
    world.speed = 300
    world.delta=0
    world.delay=0.15
    world.backMove =false
end

function barrierCreate5()
    --create grass
    local counter = 1
    for i = 0, 2000, 100 do
        for j = 0, 2000, 100 do
            grass[counter] = grass.new(i, j)
            counter = counter + 1
        end
    end
end

function world5_keypressed(key)
    if love.keyboard.isDown("k") then
        addKey()
    end
    character_keyPressed(key)
end

function barrier5_draw()

    for i=1,441 do
        love.graphics.draw(grass[i].Image, grass[i].x-world.x, grass[i].y-world.y)
        if grass[i].Barrier then
            isBarrier(grass[i].x-world.x, grass[i].y-world.y)
        end
    end
end
