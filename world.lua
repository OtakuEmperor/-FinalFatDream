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
    if character.x >barrierX-characterWidth and character.x<barrierX+characterWidth and character.y > barrierY-characterHeight and character.y<barrierY+characterHeight then
        if character.nx == barrierX and character.ny == barrierY then
            character.nx = character.nx - characterWidth
        end
        character.x =character.nx
        character.y =character.ny
    end

end

function barrier_draw()
    love.graphics.draw(tree.Image,tree.x,tree.y)
    if tree.Barrier then
        isBarrier(tree.x,tree.y)
    end
end
