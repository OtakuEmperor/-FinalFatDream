benchboard = {}

function benchboard_load()
    --load image
    benchboard.settings = love.graphics.newImage("img/settings.png")
    --get width and height of windows
    benchboard.width = love.graphics.getWidth()
    benchboard.height = love.graphics.getHeight()
    --set hp
    benchboard.hp = 100
    benchboard.hpMax = 100
    benchboard.hpFont = love.graphics.newFont(16)
end

function benchboard_draw()
    love.graphics.setBackgroundColor(220, 255, 220)
    --draw hp
    love.graphics.setColor(255, 20, 147)
    love.graphics.rectangle("fill", 0, 0, benchboard.width * benchboard.hp / benchboard.hpMax, benchboard.height / 30)
    love.graphics.setFont(benchboard.hpFont)
    love.graphics.setColor(255, 255, 255)
    love.graphics.print(benchboard.hp .. "/" .. benchboard.hpMax, 0, 0)
    --draw icon
    love.graphics.draw(benchboard.settings, benchboard.width - 24, benchboard.height - 24) --24x24p
end
