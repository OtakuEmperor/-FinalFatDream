q2key={}
questionMark2={}
local bar={}
local barHeight={}
local keyWidth=670
local keyHeight=390
local delay = 0.15
local delta = 0
local count
-- this function is for OOP
function newObject(o, class)
    class.__index = class
    return setmetatable(o, class)
end
function question2_load()
    keyImage = love.graphics.newImage("img/key2.jpg")
    questionImage2 = love.graphics.newImage("img/question2.png")
    imageWidth2=1092
    imageHeight2=614
    for i=1,12 do
        bar[i]= false
        barHeight[i]=1
    end
    bar[1]=true
    
    q2_dialogLockKey = true
    q2_dialogLockLine = true
    q2_dialog_stateKey = 1
    q2_dialog_stateLine = 1
end
function question2_update(dt)
    
    for i=1,12 do
        if bar[i]==true then
            count=i
        end
    end
    if barHeight[1] == 2 and barHeight[2] == 1 and barHeight[3] == 2 and barHeight[4] == 0 and barHeight[5] == 0 and barHeight[6] == 2 and barHeight[7] == 0 and barHeight[8] == 1 and barHeight[9] == 2 and barHeight[10] == 1 and barHeight[11] == 0 and barHeight[12] == 2 then
        delta = delta + dt
        if delta >= 0.5 then
            question=false
            questionMark[2].isSolved = true
            for i=1,12 do
                bar[i]= false
                barHeight[i]=1
            end
            bar[1]=true
            addKey()
            sloveProblem:play()
        end
    end
end

function question2_keypressedKey(key)
    if not q2_dialogLockKey then
        if love.keyboard.isDown(" ") then
            clicksound:play()
            q2_dialog_stateKey = q2_dialog_stateKey + 1
        end
    end
end

function question2_keypressedLine(key)
    if not q2_dialogLockLine then
        if love.keyboard.isDown(" ") then
            clicksound:play()
            q2_dialog_stateLine = q2_dialog_stateLine + 1
        end
    end
    local switchR = {}
    for i=1,11 do
        switchR[i]=function()
            for j=1,12 do
                bar[j]=false
            end
            bar[i+1]=true
        end
    end
    switchR[12]=function()
            for j=1,12 do
                bar[j]=false
            end
            bar[1]=true
    end
   
    local switchL = {}
    for i=2,12 do
        switchL[i]=function()
            for j=1,12 do
                bar[j]=false
            end
            bar[i-1]=true
        end
    end
    switchL[1]=function()
            for j=1,12 do
                bar[j]=false
            end
            bar[12]=true
    end
        
    local switchU = {}
    
    for i=1,12 do 
        switchU[i]=function()
            if barHeight[i] ~=2 then
                barHeight[i]=barHeight[i]+1
            else 
                barHeight[i]=2
            end
        end
    end
    
    
    local switchD = {}
    for i=1,12 do 
        switchD[i]=function()
            if barHeight[i] ~=0 then
                barHeight[i]=barHeight[i]-1
            else 
                barHeight[i]=0
            end
        end
    end
    if q2_dialog_stateLine >= 4 then  
        if love.keyboard.isDown("right") and question == true then
            --switch&case()
            local selectR = switchR[count]
            if(selectR) then
                selectR()
            end
        end
        if love.keyboard.isDown("left") and question == true then
            --switch&case()
            local selectL = switchL[count]
            if(selectL) then
                selectL()
            end
        end
        if love.keyboard.isDown("up") and question == true then
            --switch&case()
            local selectU= switchU[count]
            if(selectU) then
                selectU()
            end
        end
        if love.keyboard.isDown("down") and question == true then
            --switch&case()
            local selectD= switchD[count]
            if(selectD) then
                selectD()
            end
        end
    end
end

function question2_draw()
    love.graphics.setColor(0,0,0,150)
    love.graphics.rectangle("fill", 0,0, 1100, 614)
    love.graphics.setColor(255,255,255)
    if showKey == true then
        love.graphics.setColor(0,0,0)
        love.graphics.rectangle("fill", (1100-keyWidth)/2-3,(614*2/3-keyHeight)/2-3, keyWidth+6,keyHeight+6)
        love.graphics.setColor(255,255,255)
        love.graphics.draw(keyImage, (1100-keyWidth)/2, (614*2/3-keyHeight)/2)
        --love.graphics.setColor(255,255,0,150)
    --love.graphics.rectangle("fill", 0, love.graphics.getHeight()*2/3, love.graphics.getWidth(), love.graphics.getHeight()*1/3)
        if q2_dialog_stateKey == 1 then
            print_dialog("", "一把鑰匙？")
        elseif q2_dialog_stateKey == 2 then
            print_dialog("", "是用來打開什麼的嗎")
        elseif q2_dialog_stateKey == 3 then
            print_dialog("", "恩......12個刻度，有什麼特別的涵義嗎")
        elseif q2_dialog_stateKey == 5 then
            q2_dialog_stateKey = 1
            q2_dialog_stateLine = 1
            question = false
            showKey = false
            showQ3Answer = false
            q2_dialogLockKey = true
        end
    else
        love.graphics.draw(questionImage2, 0, 0,0,1100/imageWidth2,614/imageHeight2)
        for i=1,12 do
           if bar[i]==true then
                love.graphics.setColor(255,0,0)
            else
                love.graphics.setColor(0,0,0) 
            end
            love.graphics.rectangle("fill", 1000*i/13+25,600-(550*barHeight[i]/3) -85, 700/12-20, 530*barHeight[i]/3 )
        end
        if q2_dialog_stateLine == 1 then
            print_dialog("", "長條圖？")
        elseif q2_dialog_stateLine == 2 then
            print_dialog("", "真是麻煩")
        elseif q2_dialog_stateLine == 3 then
            print_dialog("", "真是一個不標準的長條圖，什麼標示都沒有")
        elseif q2_dialog_stateLine == 4 then
            q2_dialogLockLine = true
        end
    end
    
end


function q2key.new (originPointX,originPointY)
    local obj = {
        Image = love.graphics.newImage("img/hint.png"),
        Barrier=true,
        x = originPointX,
        y = originPointY
    }
    obj = newObject(obj, q2key)
    return obj
end

function questionMark2.new (originPointX,originPointY)
    local obj = {
        Image = love.graphics.newImage("img/puzzle.png"),
        Barrier=true,
        isSolved=false,
        x = originPointX,
        y = originPointY
    }
    obj = newObject(obj, q3Trap)
    return obj
end
