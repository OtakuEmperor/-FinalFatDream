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
    press_button = love.graphics.newImage("img/next/next.png")
    press_button2 = love.graphics.newImage("img/next/next2.png")
    press_button3 = love.graphics.newImage("img/next/next3.png")
    press_button_index = 1
    press_button_timer = 0
    end1 = love.graphics.newImage("img/end/end1.png")
    end2 = love.graphics.newImage("img/end/end2.png")
    end3 = love.graphics.newImage("img/end/end3.png")
    end4 = love.graphics.newImage("img/end/end4.png")
    end5 = love.graphics.newImage("img/end/end5.png")
    choose = {}
    chooseLock = true
    dialogLock = false
    day_state = 1
    day_branch = 0
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
    world1_success = false
    world2_success = false
    world3_success = false
    endding_fade = false
    space = "　"

    if day_branch == 0 then
        file_data = love.filesystem.read(string.format("day%d.dat", day_state), all)
    elseif not day_branch == 0 then
        file_data = love.filesystem.read(string.format("day%d-%d.dat", day_state, day_branch), all)
    end
    dialog = {}
    -- parse data
    for i in string.gmatch(file_data, "[^\n]+") do
        table.insert(dialog, i)
    end
end

function loveavg_keypressed(key)
    clicksound:setVolume(getVol())
    if not dialogLock then
        if love.keyboard.isDown(" ") then
            clicksound:play()
            if endding_fade then
                gameStage = 4
            else
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
    print_background(day_state, dialog_state, day_branch)
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
                isCharacterWake = true
                love_newDialog()
                gameStage = 3
            elseif day_state == 2 then
                isCharacterWake = true
                gameStage = 3
            elseif day_state == 3 then
                isCharacterWake = true
                gameStage = 3
            end
        end
    end
    -- tachie
    if dialog_element[1] == "我" then
        tachie(fat, "left")
    end

    -- dialog
    if dialog_element[1] == "end" then
        love.audio.stop()
        if not endding_fade then
            love_fade = true
            if love_fade_timer > 2 then
                endding_fade = true
                love_fade = false
                love_fade_color = 255
            end
        end
        if dialog_element[2] == "1" and endding_fade then
            love.graphics.draw(end1, 0 ,0)
        elseif dialog_element[2] == "2" and endding_fade then
            love.graphics.draw(end2, 0 ,0)
        elseif dialog_element[2] == "3" and endding_fade then
            love.graphics.draw(end3, 0 ,0)
        elseif dialog_element[2] == "4" and endding_fade then
            love.graphics.draw(end4, 0 ,0)
        elseif dialog_element[2] == "5" and endding_fade then
            love.graphics.draw(end5, 0 ,0)
        end
    else
        if not (isempty(dialog_element[2])) then
            if (isempty(dialog_element[1])) then
                print_dialog("", dialog_element[2])
            else
                print_dialog(dialog_element[1], dialog_element[2])
            end
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
        if press_button_index == 1 then
            love.graphics.draw(press_button, love.graphics.getWidth() - 50,love.graphics.getHeight() - 60, 0, 1/2, 1/2)
        elseif press_button_index == 2 then
            love.graphics.draw(press_button2, love.graphics.getWidth() - 50,love.graphics.getHeight() - 60, 0, 1/2, 1/2)
        elseif press_button_index == 3 then
            love.graphics.draw(press_button3, love.graphics.getWidth() - 50,love.graphics.getHeight() - 60, 0, 1/2, 1/2)
        end
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
    choose_no = tonumber(string.format("%d%d%d", day_state, day_branch, dialog_n))
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

function print_background(day, dialog, branch)
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
        elseif (210 <= dialog and dialog <= 312) then
            bg = class_light
        elseif (313 <= dialog and dialog <= 370) or (371 <= dialog and dialog <= 406) then
            bg = room_night
        end
    end

    if day == 3 and branch == 0 then
        if (1 <= dialog and dialog <= 31) then
            bg = room_light
        elseif (32 <= dialog and dialog <= 114) or (125 <= dialog and dialog <= 129) then
            bg = schoolroad_light
        elseif (130 <= dialog and dialog <= 144) then
            bg = class_light
        elseif (115 <= dialog and dialog <= 124) or (145 <= dialog and dialog <= 169) then
            bg = room_night
        end
    end

    if day == 3 and branch == 1 then
        if (1 <= dialog and dialog <= 31) then
            bg = room_light
        elseif (32 <= dialog and dialog <= 45) then
            bg = schoolroad_light
        elseif (46 <= dialog and dialog <= 69) then
            bg = class_light
        elseif (70 <= dialog and dialog <= 94) then
            bg = room_night
        end
    end

    if day == 3 and branch == 2 then
        if (1 <= dialog and dialog <= 3) then
            bg = room_light
        elseif (4 <= dialog and dialog <= 44) then
            bg = schoolroad_light
        elseif (45 <= dialog and dialog <= 60) then
            bg = class_light
        elseif (61 <= dialog and dialog <= 74) then
            bg = room_night
        end
    end

    if day == 3 and branch == 3 then
        if (1 <= dialog and dialog <= 3) then
            bg = room_light
        elseif (4 <= dialog and dialog <= 25) and (34 <= dialog and dialog <= 55) then
            bg = computer
        elseif (26 <= dialog and dialog <= 29) then
            bg = schoolroad_light
        elseif (30 <= dialog and dialog <= 33) then
            bg = class_light
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
        if 1 <= dialog and dialog <= 406 then
            if not (bgm_name == "class_bgm") then
                love.audio.stop()
                bgm = class_bgm
                bgm_name = "class_bgm"
            end
        end
    end
    if day == 3 then
        if not (bgm_name == "class_bgm") then
            love.audio.stop()
            bgm = class_bgm
            bgm_name = "class_bgm"
        end
    end
    bgm:setVolume(getVol())
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
    return {choose, chooseLock, dialogLock, day_state, day_branch, dialog_state, choose_no, world1_success, world2_success, world3_success}
end

function loveLoad(data)
    choose = data[1] -- int table
    chooseLock = data[2] -- boolean
    dialogLock = data[3] -- boolean
    day_state = data[4] -- int
    day_branch = data[5] -- int
    dialog_state = data[6] -- int
    choose_no = data[7] -- int
    world1_success = data[8] --boolean
    world2_success = data[9] --boolean
    world3_success = data[10] --boolean
end

function love_reloadDay()
    if day_branch == 0 then
        file_data = love.filesystem.read(string.format("day%d.dat", day_state), all)
    else
        file_data = love.filesystem.read(string.format("day%d-%d.dat", day_state, day_branch), all)
    end
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

    press_button_timer = press_button_timer + dt
    if press_button_timer > 0.3 then
        press_button_index = press_button_index + 1
        if press_button_index > 3 then
            press_button_index = 1
        end
        press_button_timer = 0
    end
end

function world1_change()
    if not isempty(choose[10136]) then
        if choose[10136] % 2 == 0 then
            monsters[8].hp = 50
            character.hp = 150
            character.maxHp = 150
            q3Trap[1].disappearDelay = 8
        elseif choose[10136] % 2 == 1 then
            monsters[8].hp = 70
            character.hp = 150
            character.maxHp = 150
            q3Trap[1].disappearDelay = 5
        end
    end
    if not isempty(choose[10136]) then
        if choose[10127] % 3 == 1 then
            monsters[8].hp = 70
            character.hp = 100
            character.maxHp = 100
            q3Trap[1].disappearDelay = 5
        elseif choose[10127] % 3 == 2 then
            monsters[8].hp = 70
            character.hp = 100
            character.maxHp = 100
            q3Trap[1].disappearDelay = 8
        end
    end
    if not isempty(choose[10136]) then
        if choose[1056] % 2 == 0 then
            character.atk = 5
        elseif choose[1056] % 2 == 1 then
            character.atk = 3
        end
    end
end

function world2_change()
    if not isempty(choose[20276]) then
        if world1_success and choose[20276] % 2 == 0 then
            character.hp = 150
            character.maxHp = 150
            monsters[1].hp = 70
            monsters[1].attackSpeed = 1
            character.bullet = 2
            character.gunAtk = 10
            character.swordAtk = 5
        elseif world1_success and choose[20276] % 2 == 1 then
            character.hp = 100
            character.maxHp = 100
            monsters[1].hp = 50
            monsters[1].attackSpeed = 1
            character.bullet = 2
            character.gunAtk = 10
            character.swordAtk = 5
        end
    end
    if not isempty(choose[2035]) then
        if choose[2035] % 3 == 1 then
            character.hp = 70
            character.maxHp = 70
            monsters[1].hp = 50
            monsters[1].attackSpeed = 1
            character.bullet = 2
            character.gunAtk = 10
            character.swordAtk = 5
        elseif choose[2035] % 3 == 2 then
            character.hp = 120
            character.maxHp = 120
            monsters[1].hp = 70
            monsters[1].attackSpeed = 0.8
            character.bullet = 3
            character.gunAtk = 10
            character.swordAtk = 7
        end
    end
    if not isempty(choose[2056]) then
        if choose[2056] % 2 == 1 then
            character.hp = 100
            character.maxHp = 100
            monsters[1].hp = 50
            monsters[1].attackSpeed = 1
            character.bullet = 2
            character.gunAtk = 10
            character.swordAtk = 5
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

function state_check()
    if day_state == 2 then
        if world1_success then
            dialog_state = 1
        else
            dialog_state = 16
        end
    end

    if day_state == 3 then
        day_branch = 0
        dialog_state = 1
        if not isempty(choose[20276]) then
            if choose[20276] % 2 == 0 then
                day_branch = 1
                if world2_success then
                    dialog_state = 17
                else
                    dialog_state = 1
                end
            end
        elseif not isempty(choose[2035]) then
            if choose[2035] % 2 == 0 then
                if not world2_success then
                    day_branch = 3
                end
            end
        elseif not isempty(choose[2056]) then
            if choose[2056] % 2 == 1 then
                if not world2_success then
                    day_branch = 2
                end
            end
        end

        if day_branch == 0 or day_branch == 1 then
            if world2_success then
                dialog_state = 17
            else
                dialog_state = 1
            end
        end
    end
end
