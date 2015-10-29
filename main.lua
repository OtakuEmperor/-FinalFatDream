function love.load()
    require "world"
    require "op"
    require "menu"
    gameStage = 0
        op_load()
        menu_load()
        world_load()
end

function love.update(dt)
    if gameStage == 0 then
        op_update()
    elseif gameStage == 3 then
        world_update(dt)
    end
end


function love.draw()
    if gameStage == 0 then
        op_draw()
    elseif gameStage == 1 then
        menu_draw()
    elseif gameStage == 3 then
        world_draw()
    end
end
