function love.load()
    
    require "world"
    
    world_load()
end

function love.update(dt)
    world_update(dt)
            
end


function love.draw()
    
    world_draw()
end
