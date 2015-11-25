local q5Floor={}
local keyWidth=670
local keyHeight=390
local delay = 0.15
local delta = 0
local counter
local colorLock=true
local Image = love.graphics.newImage("img/world2/aisle.png")
local isImage = love.graphics.newImage("img//world2/aisleBlue.png")
local isImage2 = love.graphics.newImage("img//world2/aisleRed.png")
-- this function is for OOP
function newObject(o, class)
    class.__index = class
    return setmetatable(o, class)
end
function question5_load()
    questionImage5 = love.graphics.newImage("img/day2Puzzle2Key.png")
    
    imageWidth5=80
    imageHeight5=600
    q5_dialogLockKey = true
    q5_dialog_state = 2
    q5_dialog_namestate = 1
    counter = 1
    charLastSetpX = 0
    charLastSetpY = 0
    lastSetpCounter = 1
    for i = 1300, 1600, 100 do
        for j = 0, 2700, 100 do
            q5Floor[counter] = q5Floor.new(i, j)
            counter = counter + 1
        end
    end
end

function q5_keypressedKey(key)
    if not q5_dialogLockKey  then
        if love.keyboard.isDown(" ") then
            clicksound:play()
            says_index = 3
            dialog_timer = 0
            q5_dialog_state = q5_dialog_state + 2
            q5_dialog_namestate = q5_dialog_namestate +2
        end
    end
end

function question5_update(dt)
    if (character.x+world.x)==1200 and (character.y+world.y)==300 then
        q5Set()
    end
    counter = 1
    for i = 1300, 1600, 100 do
        for j = 0, 2700, 100 do
            if q5Floor[counter].isBarrier then
                aisle[counter].Image=isImage2
            end
            if (character.x+world.x)==q5Floor[counter].x and (character.y+world.y)==q5Floor[counter].y then
                if q5Floor[counter].isWalked ==false and q5Floor[counter].isOn == false then
                    aisle[counter].Image=isImage
                    q5Floor[counter].isWalked=true
                    q5Floor[counter].isOn = true
                    q5Floor[lastSetpCounter].isOn = false
                    lastSetpCounter = counter
                elseif q5Floor[counter].isWalked == true and q5Floor[counter].isOn == false then
                    q5Set()
                    q5Floor[counter].isWalked = true
                    q5Floor[counter].isOn = true
                    q5Floor[lastSetpCounter].isOn = false
                    lastSetpCounter = 1

                end
                --q5Set()
            end
            if charLastSetpX ~= (character.x + world.x) and charLastSetpY ~= (character.y + world.y) then
            end
            counter = counter + 1
        end
    end

end

function question5_keypressedLine(key)
    --if not q2_dialogLockLine then
      --  if love.keyboard.isDown(" ") then
        --    q2_dialog_stateLine = love_dialogKeyPressed(q2_dialog_stateLine)
        --end
    --end
    
end

function question5_draw(dialogNum)
    love.graphics.setColor(0,0,0,150)
    love.graphics.rectangle("fill", 0,0, 1100, 614)
    love.graphics.setColor(255,255,255)
    if showKey == true then
        if q5_dialog_state == (deskChair[dialogNum].dialogLength+1) then
                    showKey = false
                    question = false
                    q5_dialogLockKey = true
                    q5_dialog_state = 2
                    q5_dialog_namestate = 1
                    atk_timeout = 0
                end
        if deskChair[dialogNum].dialog[q5_dialog_namestate] == "nil" then
            deskChair[dialogNum].dialog[q5_dialog_namestate] = " "
        end
                print_dialog(deskChair[dialogNum].dialog[q5_dialog_namestate],deskChair[dialogNum].dialog[q5_dialog_state])   
    
    else
        love.graphics.draw(questionImage5, 550-imageWidth5/2, 0)
        --love.graphics.draw(questionImage5, 307-imageWidth5/2, 0,0,1100/,614/imageHeight5)
        --if q2_dialog_stateLine == 1 then
          --  print_dialog("", "長條圖？")
        --elseif q2_dialog_stateLine == 2 then
          --  print_dialog("", "真是麻煩")
        --elseif q2_dialog_stateLine == 3 then
          --  print_dialog("", "真是一個不標準的長條圖，什麼標示都沒有")
        --elseif q2_dialog_stateLine == 4 then
          --  q2_dialogLockLine = true
        --end
    end
end

function q5Floor.new (originPointX,originPointY)
    local obj = {
        isWalked=false,
        isBarrier=false,
        isOn=false,
        x = originPointX,
        y = originPointY
    }
    obj = newObject(obj, q5Floor)
    return obj
end
    
function q5Set()
    local count = 1
    for i = 1300, 1600, 100 do
        for j = 0, 2700, 100 do
            q5Floor[count].isWalked=false
            q5Floor[count].isOn = false
                q5Floor[count].isBarrier=false
                aisle[count].Image=Image
                count = count + 1
        end
    end
    q5Floor[5].isWalked=true
    q5Floor[5].isBarrier=true
    q5Floor[10].isWalked=true 
    q5Floor[10].isBarrier=true
    q5Floor[11].isWalked=true
    q5Floor[11].isBarrier=true
    q5Floor[18].isWalked=true
    q5Floor[18].isBarrier=true
    q5Floor[27].isWalked=true
    q5Floor[27].isBarrier=true
    q5Floor[28].isWalked=true
    q5Floor[28].isBarrier=true
    q5Floor[35].isWalked=true
    q5Floor[35].isBarrier=true
    q5Floor[36].isWalked=true
    q5Floor[36].isBarrier=true
    q5Floor[56].isWalked=true
    q5Floor[56].isBarrier=true
    q5Floor[75].isWalked=true
    q5Floor[75].isBarrier=true
    for i=89,94 do
        q5Floor[i].isWalked=true
        q5Floor[i].isBarrier=true
    end
    q5Floor[105].isWalked=true 
    q5Floor[105].isBarrier=true
    q5Floor[108].isWalked=true 
    q5Floor[108].isBarrier=true
    q5Floor[109].isWalked=true 
    q5Floor[109].isBarrier=true
    q5Floor[111].isWalked=true
    q5Floor[111].isBarrier=true
    q5Floor[1].isWalked=true
    q5Floor[1].isBarrier=true
    q5Floor[2].isWalked=true
    q5Floor[2].isBarrier=true
    q5Floor[3].isWalked=true
    q5Floor[3].isBarrier=true
    q5Floor[29].isWalked=true
    q5Floor[29].isBarrier=true
    q5Floor[30].isWalked=true
    q5Floor[30].isBarrier=true
    q5Floor[31].isWalked=true
    q5Floor[31].isBarrier=true
    q5Floor[57].isWalked=true
    q5Floor[57].isBarrier=true
    q5Floor[58].isWalked=true
    q5Floor[58].isBarrier=true
    q5Floor[59].isWalked=true
    q5Floor[59].isBarrier=true
    q5Floor[85].isWalked=true
    q5Floor[85].isBarrier=true
    q5Floor[86].isWalked=true
    q5Floor[86].isBarrier=true
    q5Floor[87].isWalked=true
    q5Floor[87].isBarrier=true
    ------people---------------
    for i=15,17 do
        q5Floor[i].isWalked=true
    end
    for i=24,26 do
        q5Floor[i].isWalked=true
    end
    for i=43,46 do
        q5Floor[i].isWalked=true
    end
    q5Floor[54].isWalked=true
    q5Floor[55].isWalked=true
    for i=60,67 do
        q5Floor[i].isWalked=true
    end
    for i=72,74 do
        q5Floor[i].isWalked=true
    end
    for i=83,84 do
        q5Floor[i].isWalked=true
    end
    q5Floor[88].isWalked=true
    q5Floor[95].isWalked=true
    q5Floor[112].isWalked=true
end
    
function q5Floor:update(dt)
    
end
