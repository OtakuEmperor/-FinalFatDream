-- author: GaryTan
-- How to build your dat file
-- who, says something, force go to dialog number, choose A, choose A go to dialog, choose B, choose B go to dialog, choose C, choose C go to dialog
-- if something null please enter "nil" eg. nil,blah blah...
-- if there is no force go to dialog, default is dialog_state +1
loveavg = {}

function loveavg_load()
    fat = love.graphics.newImage("img/cg/fat.png")
    clicksound = love.audio.newSource("audio/click.wav", "stream")
    night_bgm = love.audio.newSource("audio/平和のハンモック.mp3", "stream")
    class_bgm = love.audio.newSource("audio/orange.mp3", "stream")
    class_light = love.graphics.newImage("img/cg/class_light.jpg")
    night = love.graphics.newImage("img/cg/night.jpg")
    hallway_light = love.graphics.newImage("img/cg/hallway_light.jpg")
    onefloor_light = love.graphics.newImage("img/cg/onefloor_light.jpg")
    restaurant_light = love.graphics.newImage("img/cg/restaurant_light.jpg")
    schoolroad_sunset = love.graphics.newImage("img/cg/schoolroad_sunset.jpg")
    schoolroad_light = love.graphics.newImage("img/cg/schoolroad_light.jpg")
    room_light = love.graphics.newImage("img/cg/room_light.jpg")
    computer = love.graphics.newImage("img/cg/computer.jpg")
    schoolEntry_light = love.graphics.newImage("img/cg/schoolEntry_light.jpg")
    room_night = love.graphics.newImage("img/cg/room_night.jpg")
    dialogImg = love.graphics.newImage("img/dialog.png")
    lovefont = love.graphics.newFont("font/wt006.ttf", 25)
    press_button = love.graphics.newImage("img/slimeJuice.png")
    choose = {}
    chooseLock = true
    dialogLock = false
    day_state = 1
    dialog_state = 1
    choose_no = 0
    love_fade_color = 255
    love_fade = false
    love_fade_timer = 0
    dialog_timer = 0
    says_index = 3
    says_length = 0
    waitNextDialog = false
    waitSpace = false
    space = "　"
    file_data = love.filesystem.read(string.format("day%d.dat", day_state), all)
    dialog = {}
    -- parse data
    for i in string.gmatch(file_data, "[^\n]+") do
        table.insert(dialog, i)
    end
end

function loveavg_keypressed(key)
    if not dialogLock then
        if love.keyboard.isDown(" ") then
            clicksound:play()
            if waitNextDialog then
                if not isempty(dialog_element[3]) then
                    dialog_state = tonumber(dialog_element[3])
                else
                    dialog_state = dialog_state + 1
                end
                says_index = 3
                dialog_timer = 0
            elseif waitSpace then
                waitSpace = false
            else
                says_index = says_length
            end
        end
    end
    if not chooseLock then
        if love.keyboard.isDown("up") then
            clicksound:play()
            choose[choose_no] = choose[choose_no] - 1
            if choose[choose_no] < 0 then
                choose[choose_no] = 11
            end
        elseif love.keyboard.isDown("down") then
            clicksound:play()
            choose[choose_no] = choose[choose_no] + 1
        elseif love.keyboard.isDown(" ") then
            clicksound:play()
            chooseLock = true
            dialogLock = false
            if ele_len == 9 then
                if choose[choose_no] % 3 == 0 then
                    dialog_state = tonumber(dialog_element[5])
                elseif choose[choose_no] % 3 == 1 then
                    dialog_state = tonumber(dialog_element[7])
                elseif choose[choose_no] % 3 == 2 then
                    dialog_state = tonumber(dialog_element[9])
                end
            elseif ele_len == 7 then
                if choose[choose_no] % 2 == 0 then
                    dialog_state = tonumber(dialog_element[5])
                elseif choose[choose_no] % 2 == 1 then
                    dialog_state = tonumber(dialog_element[7])
                end
            end
            says_index = 3
            dialog_timer = 0
        end
    end
end

function loveavg_draw()
    dialog_element = {}
    print_background(day_state, dialog_state)
    play_bgm(day_state, dialog_state)
    for i in string.gmatch(dialog[dialog_state], "[^,]+") do
        table.insert(dialog_element, i)
    end
    dialogStartDrawLock = true
    ele_len = table.getn(dialog_element)
    if ele_len == 1 and dialog_element[1] == "###" then
        dialogLock = true
        love_fade = true
        if love_fade_timer >= 2 then
            love.audio.stop()
            dialogLock = false
            love_fade = false
            if day_state == 1 then
                world1_dialogLock = false
                world1_change()
                love_newDialog()
                gameStage = 3
            elseif day_state == 2 then
                gameStage = 3
            end
        end
    end
    -- tachie
    if dialog_element[1] == "我" then
        tachie(fat, "left")
    end

    -- dialog
    if not (isempty(dialog_element[2])) then
        if (isempty(dialog_element[1])) then
            print_dialog("", dialog_element[2])
        else
            print_dialog(dialog_element[1], dialog_element[2])
        end
    end

    if ele_len > 5 and ele_len < 8 then
        print_choose(2, dialog_state, dialog_element[4], dialog_element[6])
    elseif ele_len > 7 then
        print_choose(3, dialog_state, dialog_element[4], dialog_element[6], dialog_element[8])
    end
end

function print_dialog(who, says)
    says_length = string.len(says)
    if string.sub(says, says_index-2, says_index) == string.sub(space, 1, 3) then
        waitSpace = true
    end
    says = string.sub(says, 1, says_index)
    if(says_index >= says_length) then
        waitNextDialog = true
    else
        waitNextDialog = false
    end
    love.graphics.setFont(lovefont)
    says_nd = " "
    if string.len(says) > 129 then
        says_nd = string.sub(says, 130)
        says = string.sub(says, 1, 129)
    end
    -- love.graphics.setColor(255, 0, 0, 200)
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.draw(dialogImg,0,love.graphics.getHeight()*2/3)
    -- love.graphics.rectangle("fill", 0, love.graphics.getHeight()*2/3, love.graphics.getWidth(), love.graphics.getHeight()*1/3)
    love.graphics.print(who, 5, love.graphics.getHeight()*2/3+5)
    love.graphics.print(says, 5, love.graphics.getHeight()*2/3+35)
    love.graphics.print(says_nd, 5, love.graphics.getHeight()*2/3+65)
    if waitSpace or waitNextDialog then
        love.graphics.draw(press_button, love.graphics.getWidth() - 50,love.graphics.getHeight() - 50)
    end
end

function tachie(img, side)
    if side == "left" then
        love.graphics.draw(img, 10,10)
    elseif side == "right" then
        love.graphics.draw(img, love.graphics.getWidth()-img:getWidth()-10, 10)
    end
end

function print_choose(n, dialog_n, a, b, c)
    love.graphics.setFont(lovefont)
    chooseLock = false
    dialogLock = true
    -- choose
    choose_no = tonumber(string.format("%d%d", day_state, dialog_n))
    if isempty(choose[choose_no]) then
        choose[choose_no] = 0
    end
    if n == 2 then
        choosehighlight(1, 2)
        love.graphics.rectangle("fill", 300, 80, 492, 50)
        choosehighlight(2, 2)
        love.graphics.rectangle("fill", 300, 180, 492, 50)
        love.graphics.setColor(255, 255, 255, 255)
        love.graphics.print(a, 546-string.len(a)*4.2, 90)
        love.graphics.print(b, 546-string.len(b)*4.2, 190)
        love.graphics.setColor(255, 255, 255, 255)
    elseif n == 3 then
        choosehighlight(1, 3)
        love.graphics.rectangle("fill", 300, 80, 492, 50)
        choosehighlight(2, 3)
        love.graphics.rectangle("fill", 300, 180, 492, 50)
        choosehighlight(3, 3)
        love.graphics.rectangle("fill", 300, 280, 492, 50)
        love.graphics.setColor(255, 255, 255, 255)
        love.graphics.print(a,546-string.len(a)*4.2, 90)
        love.graphics.print(b,546-string.len(b)*4.2, 190)
        love.graphics.print(c,546-string.len(c)*4.2, 290)
        love.graphics.setColor(255, 255, 255, 255)
    end
end

function print_background(day, dialog)
    if day == 1 then
        if (1 <= dialog and dialog <= 13) or (167 <= dialog and dialog <= 182) then
            bg = night
        elseif (14 <= dialog and dialog <= 50) or (98 <= dialog and dialog <= 155)then
            bg = class_light
        elseif 51 <= dialog and dialog <= 77 then
            bg = hallway_light
        elseif 78 <= dialog and dialog <= 82 then
            bg = onefloor_light
        elseif 83 <= dialog and dialog <= 97 then
            bg = restaurant_light
        elseif 156 <= dialog and dialog <= 166 then
            bg = schoolroad_sunset
        end
    end
    if day == 2 then
        if (1 <= dialog and dialog <= 35) or (160 <= dialog and dialog <= 162) then
            bg = room_light
        elseif (36 <= dialog and dialog <= 84) then
            bg = computer
        elseif (85 <= dialog and dialog <= 159) then
            bg = schoolroad_light
        elseif (163 <= dialog and dialog <= 209) then
            bg = schoolEntry_light
        elseif (210 <= dialog and dialog <= 305) then
            bg = class_light
        elseif (306 <= dialog and dialog <= 363) or (364 <= dialog and dialog <= 399) then
            bg = room_night
        end
    end
    love.graphics.setColor(255, 255, 255 ,love_fade_color)
    love.graphics.draw(bg, 0, 0, 0, 1092/bg:getWidth(), 614/bg:getHeight())
end

function play_bgm(day, dialog)
    if isempty(bgm) then
        bgm_name = ""
        bgm = night_bgm
    end
    if day == 1 then
        if (1 <= dialog and dialog <= 13) or (167 <= dialog and dialog <= 182) then
            if not (bgm_name == "night_bgm") then
                love.audio.stop()
                bgm = night_bgm
                bgm_name = "night_bgm"
            end
        elseif 14 <= dialog and dialog <= 166 then
            if not (bgm_name == "class_bgm") then
                love.audio.stop()
                bgm = class_bgm
                bgm_name = "class_bgm"
            end
        end
    end
    if day == 2 then
        if 1 <= dialog and dialog <= 399 then
            if not (bgm_name == "class_bgm") then
                love.audio.stop()
                bgm = class_bgm
                bgm_name = "class_bgm"
            end
        end
    end
    bgm:play()
end

function choosehighlight(index, all)
    if(choose[choose_no] % all == index - 1) then
        love.graphics.setColor(0, 0, 100, 200)
    else
        love.graphics.setColor(0, 0, 0, 200)
    end
end

function isempty(s)
    return s == nil or s == '' or s == 'nil'
end

function loveSave()
    return {choose, chooseLock, dialogLock, day_state, dialog_state, choose_no}
end

function loveLoad(data)
    choose = data[1]
    chooseLock = data[2]
    dialogLock = data[3]
    day_state = data[4]
    dialog_state = data[5]
    choose_no = data[6]
    for i, j in pairs(data[1]) do
        print(string.format("%s %s", i, j))
    end
end

function love_reloadDay()
    file_data = love.filesystem.read(string.format("day%d.dat", day_state), all)
    dialog = {}
    -- parse data
    for i in string.gmatch(file_data, "[^\n]+") do
        table.insert(dialog, i)
    end
end

function love_update(dt)
    dialog_timer = dialog_timer + dt
    if dialog_timer >= 0.02 and not waitSpace then
        says_index = says_index + 3
        dialog_timer = 0
    end
    if love_fade then
        love_fade_timer = love_fade_timer + dt
        if love_fade_timer <= 2 then
            love_fade_color = love_fade_color - 4
            if love_fade_color <= 10 then
                love_fade_color = 0
            end
        end
    else
        love_fade_timer = 0
        love_fade_color = 255
    end
end

function world1_change()
    if not isempty(choose[1136]) then
        if choose[1136] % 2 == 0 then
            monsters[8].hp = 50
            character.hp = 150
            character.maxHp = 150
            q3Trap[1].disappearDelay = 8
        elseif choose[1136] % 2 == 1 then
            monsters[8].hp = 70
            character.hp = 150
            character.maxHp = 150
            q3Trap[1].disappearDelay = 5
        end
    end
    if not isempty(choose[1136]) then
        if choose[1127] % 3 == 1 then
            monsters[8].hp = 70
            character.hp = 100
            character.maxHp = 100
            q3Trap[1].disappearDelay = 5
        elseif choose[1127] % 3 == 2 then
            monsters[8].hp = 70
            character.hp = 100
            character.maxHp = 100
            q3Trap[1].disappearDelay = 8
        end
    end
    if not isempty(choose[1136]) then
        if choose[156] % 2 == 0 then
            character.atk = 5
        elseif choose[156] % 2 == 1 then
            character.atk = 3
        end
    end
end

function love_dialogKeyPressed(dialog_state_name)
    clicksound:play()
    if waitNextDialog then
        dialog_state_name = dialog_state_name + 1
        says_index = 3
        dialog_timer = 0
    elseif waitSpace then
        waitSpace = false
    else
        says_index = says_length
    end
    return dialog_state_name
end

function love_newDialog()
    says_index = 3
    dialog_timer = 0
end
