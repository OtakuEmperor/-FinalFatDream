function love.load()
    require "world"
    require "op"
    require "menu"
    require "loveavg"
    gameStage = 1
        op_load()
        menu_load()
        world_load()
        loveavg_load()
end

function love.update(dt)
    if gameStage == 0 then
        op_update()
    elseif gameStage == 3 then
        world_update(dt)
    end
end

function love.keypressed(key)
    if gameStage == 2 then
        loveavg_keypressed(key)
    end
end

function love.draw()
    if gameStage == 0 then
        op_draw()
    elseif gameStage == 1 then
        menu_draw()
    elseif gameStage == 2 then
        loveavg_draw()
    elseif gameStage == 3 then
        world_draw()
    end
end
