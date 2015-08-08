world={}
tree={}
function world_load()
    require "character"
    require "benchboard"
    character_load()
    benchboard_load()
    barrierCreat()
end

function world_update(dt)
   character_update(dt)
end

function world_draw()
    character_draw()
    benchboard_draw()
    barrier_draw()
end

function barrierCreat()
    tree.x=300
    tree.y=300
    tree.Image = love.graphics.newImage("img/tree.png")
    tree.Barrier=true
end

function isBarrier(barrierX,barrierY)
    if character.nx >barrierX-characterWidth and character.nx<barrierX+characterWidth and character.ny > barrierY-characterHeight and character.ny<barrierY+characterHeight then 
        --if character.nx == barrierX and character.ny == barrierY then
          --  character.nx = character.nx - characterWidth
        --end
        character.nx =character.px
        character.ny =character.py
        character.animation.walking = true
        character.animation.sound:play()
    end
    
end

function barrier_draw()
    love.graphics.draw(tree.Image,tree.x,tree.y)
    if tree.Barrier then
        isBarrier(tree.x,tree.y)
    end
end