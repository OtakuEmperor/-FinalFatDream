local fps=false
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
    require "world2"
    require "world3"
    require "world4"
    require "world5"
    require "ed"
    gameStage = 0
    isSetting = false
    op_load()
    menu_load()
    world_load()
    world2_load()
    world3_load()
    world4_load()
    world5_load()
        loveavg_load()
        setting_load()
        ed_load()
end

function love.update(dt)
    if gameStage == 0 then
        op_update()
    elseif gameStage == 2 then
        love_update(dt)
    elseif gameStage == 3 then
        local switchDay = {
            [1] = function()    -- for case 1
                world_update(dt)
            end,
            [2] = function()    -- for case 2
                world2_update(dt)
            end,
            [3] = function()    -- for case 3
                world3_update(dt)
            end,
            [4] = function()    -- for case 4
                world4_update(dt)
            end,
            [5] = function()
                world5_update(dt)
            end
        }
        local selectDay= switchDay[day_state]
            if(selectDay) then
                selectDay()
            end
    elseif gameStage == 4 then
        ed_update()
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
        local switchDayK = {
            [1] = function()    -- for case 1
                world_keypressed(key)
            end,
            [2] = function()    -- for case 2
                world2_keypressed(key)
            end,
            [3] = function()    -- for case 3
                world3_keypressed(key)
            end,
            [4] = function()    -- for case 4
                world4_keypressed(key)
            end,
            [5] = function()
                world5_keypressed(key)
            end
        }
        local selectDayK= switchDayK[day_state]
            if(selectDayK) then
                selectDayK()
            end
    end
    --press esc to open or close setting.lua
    if key == "escape" and isSetting == false and gameStage == 2 then
        isSetting = true
    elseif key == "escape" and isSetting == true and gameStage == 2 then
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
    elseif love.keyboard.isDown("5") and love.keyboard.isDown("lalt") then
        day_state = 2
        gameStage = 3
    elseif love.keyboard.isDown("6") and love.keyboard.isDown("lalt") then
        gameStage = 4
    elseif love.keyboard.isDown("f") and love.keyboard.isDown("lalt") then
        if fps then
            fps=false
        else
            fps=true
        end
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
        local switchDayD = {
            [1] = function()    -- for case 1
                interface.days = 1
                world_draw()
            end,
            [2] = function()    -- for case 2
                interface.days = 2
                world2_draw()
            end,
            [3] = function()    -- for case 3
                interface.days = 3
                world3_draw()
            end,
            [4] = function()    -- for case 4
                world4_draw()
            end,
            [5] = function()
                world5_draw()
            end
        }
        local selectDayD= switchDayD[day_state]
            if(selectDayD) then
                selectDayD()
            end
    elseif gameStage == 4 then
        ed_draw()
    end
    if fps then
        love.graphics.print("Current FPS: "..tostring(love.timer.getFPS( )), 10, 10)
    end
end
