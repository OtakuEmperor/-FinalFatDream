-- author: GaryTan
-- How to build your dat file
-- who, says something, force go to dialog number, choose A, choose A go to dialog, choose B, choose B go to dialog, choose C, choose C go to dialog
-- if something null please enter "nil" eg. nil,blah blah...
-- if there is no force go to dialog, default is dialog_state +1


function love.load()
    fat = love.graphics.newImage("img/fat.png")
    clicksound = love.audio.newSource("audio/click.wav", "stream")
    class_light = love.graphics.newImage("img/class_light.jpg")
    font = love.graphics.newFont("font/msjh.ttc", 25)
    love.graphics.setFont(font)
    file_data = love.filesystem.read("day1.dat", all)
    dialog = {}
    -- parse data
    for i in string.gmatch(file_data, "%S+") do
        table.insert(dialog, i)
    end
    choose = {}
    for i = 1, 999 do choose[i] = 0 end
    chooseLock = true
    dialogLock = false
    dialog_state = 1
    choose_no = 0
end

function love.keypressed(key)
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
                    dialog_state = dialog_element[5]
                elseif choose[choose_no] % 3 == 1 then
                    dialog_state = dialog_element[7]
                elseif choose[choose_no] % 3 == 2 then
                    dialog_state = dialog_element[9]
                end
            elseif ele_len == 7 then
                if choose[choose_no] % 2 == 0 then
                    dialog_state = dialog_element[5]
                elseif choose[choose_no] % 2 == 1 then
                    dialog_state = dialog_element[7]
                end
            end
        end
    end

    if not dialogLock then
        if love.keyboard.isDown(" ") then
            clicksound:play()
            if not isempty(dialog_element[3]) then
                dialog_state = tonumber(dialog_element[3])
            else
                dialog_state = dialog_state + 1
            end
        end
    end
end

function love.draw()
    dialog_element = {}
    love.graphics.draw(class_light, 0, 0, 0, 1092/class_light:getWidth(), 614/class_light:getHeight())
    for i in string.gmatch(dialog[dialog_state], "[^,]+") do
        table.insert(dialog_element, i)
    end
    ele_len = table.getn(dialog_element)

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
    says_nd = ""
    if string.len(says) > 129 then
        says_nd = string.sub(says, 130)
        says = string.sub(says, 1, 129)
    end
    love.graphics.setColor(0, 0, 0, 200)
    love.graphics.rectangle("fill", 0, love.graphics.getHeight()*2/3, love.graphics.getWidth(), love.graphics.getHeight()*1/3)
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.print(who, 5, love.graphics.getHeight()*2/3+5)
    love.graphics.print(says, 5, love.graphics.getHeight()*2/3+35)
    love.graphics.print(says_nd, 5, love.graphics.getHeight()*2/3+65)
end

function tachie(img, side)
    if side == "left" then
        love.graphics.draw(img, 10,10)
    elseif side == "right" then
        love.graphics.draw(img, love.graphics.getWidth()-img:getWidth()-10, 10)
    end
end

function print_choose(n, dialog_n, a, b, c)
    chooseLock = false
    dialogLock = true
    -- choose
    choose_no = dialog_n
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

function choosehighlight(index, all)
    if(choose[choose_no] % all == index - 1) then
        love.graphics.setColor(0, 0, 100, 200)
    else
        love.graphics.setColor(0, 0, 0, 200)
    end
end

function isempty(s)
    return s == nil or s == '' or s == 'nil'end