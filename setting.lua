setting = {}
function setting_load()
    setting.width = love.graphics.getWidth()
    setting.height = love.graphics.getHeight()
    setting.font = love.graphics.newFont("font/FFFFORWA.TTF", setting.height/5 + 3)
    setting.stage = 1
    setting.select = 0
    setting.vol = 10

end

function setting_update(dt)
    --control up and down
    if love.keyboard.isDown("down") and not(setting.stage == 4) then
        setting.stage = setting.stage + 1
        love.timer.sleep(0.2)
    elseif love.keyboard.isDown("down") and setting.stage == 4 then
        setting.stage = 1
        love.timer.sleep(0.2)
    elseif love.keyboard.isDown("up") and not(setting.stage == 1) then
        setting.stage = setting.stage - 1
        love.timer.sleep(0.2)
    elseif love.keyboard.isDown("up") and setting.stage == 1 then
        setting.stage = 4
        love.timer.sleep(0.2)
    end

    --control select
    if love.keyboard.isDown(" ") then
        setting.select = setting.stage
    end
    --control volume
    if setting.stage == 1 and love.keyboard.isDown("right") and setting.vol < 10 then
        setting.vol = setting.vol + 1
        love.timer.sleep(0.2)
    elseif setting.stage == 1 and love.keyboard.isDown("left") and setting.vol > 0 then
        setting.vol = setting.vol - 1
        love.timer.sleep(0.2)
    end

end

function setting_draw()
    love.graphics.setBackgroundColor(255, 255, 255)
    --volume
    if setting.stage == 1 then
        love.graphics.setColor(255, 255, 255)
    else
        love.graphics.setColor(100, 100, 100)
    end
    love.graphics.rectangle("fill", 0, 0, setting.width, setting.height/4)
    if setting.stage == 1 then
        love.graphics.setColor(100, 100, 100)
    else
        love.graphics.setColor(255, 255, 255)
    end
    love.graphics.setFont(setting.font)
    love.graphics.print("Vol", 0, 15)
    love.graphics.polygon("fill", setting.width/3, setting.height*9/40, setting.width/3 + setting.width*7/15 * setting.vol/10, setting.height/40 +  (setting.height/5 * (10- setting.vol)/10), setting.width/3 + setting.width*7/15 * setting.vol/10, setting.height*9/40)

    --save
    if setting.stage == 2 then
        love.graphics.setColor(255, 255, 255)
    else
        love.graphics.setColor(100, 100, 100)
    end
    love.graphics.rectangle("fill", 0, setting.height/4, setting.width, setting.height/4)
    if setting.stage == 2 then
        love.graphics.setColor(100, 100, 100)
    else
        love.graphics.setColor(255, 255, 255)
    end
    love.graphics.print("Save", setting.width - 370, setting.height/4 + 15)

    --quit
    if setting.stage == 3 then
        love.graphics.setColor(255, 255, 255)
    else
        love.graphics.setColor(100, 100, 100)
    end
    love.graphics.rectangle("fill", 0, setting.height/2, setting.width, setting.height/4)
    if setting.stage == 3 then
        love.graphics.setColor(100, 100, 100)
    else
        love.graphics.setColor(255, 255, 255)
    end
    love.graphics.print("Quit", 0, setting.height*2/4 + 15)

    --back to game
    if setting.stage == 4 then
        love.graphics.setColor(255, 255, 255)
    else
        love.graphics.setColor(100, 100, 100)
    end
    love.graphics.rectangle("fill", 0, setting.height*3/4, setting.width, setting.height/4)
    if setting.stage == 4 then
        love.graphics.setColor(100, 100, 100)
    else
        love.graphics.setColor(255, 255, 255)
    end
    love.graphics.print("Back", setting.width - 370, setting.height*3/4 + 15)
end
