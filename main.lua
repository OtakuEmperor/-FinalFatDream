function love.load()
    --remove mouse
    local state = not love.mouse.isVisible()   -- the opposite of whatever it currently is
    love.mouse.setVisible(state)
    --------
    require "op"
    require "menu"
    require "loveavg"
    require "setting"
    require "world"
    gameStage = 0
    isSetting = false
        op_load()
        menu_load()
        world_load()
        loveavg_load()
        setting_load()
end

function love.update(dt)
    if gameStage == 0 then
        op_update()
    elseif gameStage == 2 then
        love_update(dt)
    elseif gameStage == 3 then
        world_update(dt)
    end
end

function love.keypressed(key)
    if gameStage == 1 then
        if not menu.isBCK then
            menu_keypressed(key)
        else
            beiCheeKiller_keypressed(key)
        end
    elseif gameStage == 2 then
        if isSetting == true then
            setting_keypressed(key)
        else
            loveavg_keypressed(key)
        end
    elseif gameStage == 3 then
        world_keypressed(key)
    end
    --press esc to open or close setting.lua
    if key == "escape" and isSetting == false then
        isSetting = true
    elseif key == "escape" and isSetting == true then
        isSetting = false
    end

    if love.keyboard.isDown("0") and love.keyboard.isDown("lalt") then
        gameStage = 0
    elseif love.keyboard.isDown("1") and love.keyboard.isDown("lalt") then
        gameStage = 1
    elseif love.keyboard.isDown("2") and love.keyboard.isDown("lalt") then
        gameStage = 2
    elseif love.keyboard.isDown("3") and love.keyboard.isDown("lalt") then
        gameStage = 3
    elseif love.keyboard.isDown("4") and love.keyboard.isDown("lalt") then
        love.filesystem.remove("data.txt")
        love.filesystem.remove("data2.txt")
    end
end

function love.draw()
    if gameStage == 0 then
        op_draw()
    elseif gameStage == 1 then
        menu_draw()
    elseif gameStage == 2 then
        loveavg_draw()
        if isSetting == true then
            setting_draw()
        end
    elseif gameStage == 3 then
        world_draw()
    end
end
