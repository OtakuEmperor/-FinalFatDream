local bar={}
local barHeight={}
local keyWidth=670
local keyHeight=390
local delay = 0.15
local delta = 0
local count
function question4_load()
    questionImage4 = love.graphics.newImage("img/question4.png")
    imageWidth4=100
    imageHeight4=100
    for i=1,12 do
        bar[i]= false
        barHeight[i]=1
    end
    bar[1]=true
    q4_dialogLockKey = true
    q4_dialog_state = 2
    q4_dialog_namestate = 1
    q4_dialog_stateLine = 1
    q4_dialogLockLine = true
end

function q4_keypressedKey(key)
    if not q4_dialogLockKey  then
        if love.keyboard.isDown(" ") then
            clicksound:setVolume(getVol())
            clicksound:play()
            says_index = 3
            dialog_timer = 0
            q4_dialog_state = q4_dialog_state + 2
            q4_dialog_namestate = q4_dialog_namestate +2
        end
    end
    if not q4_dialogLockLine then
        if love.keyboard.isDown(" ") then
            clicksound:setVolume(getVol())
            clicksound:play()
            q4_dialog_stateLine = q4_dialog_stateLine +1
        end
    end
end

function question4_update(dt)
    for i=1,12 do
        if bar[i]==true then
            count=i
        end
    end
    if barHeight[1] == 2 and barHeight[2] == 1 and barHeight[3] == 0 and barHeight[4] == 2 and barHeight[5] == 2 and barHeight[6] == 1 and barHeight[7] == 0 and barHeight[8] == 1 and barHeight[9] == 2 and barHeight[10] == 1 and barHeight[11] == 0 and barHeight[12] == 2 then
        delta = delta + dt
        if delta >= 0.5 then
            question=false
            for i=20,28 do
                lightWall[i].isSolved = true
            end
            for i=1,12 do
                bar[i]= false
                barHeight[i]=1
            end
            bar[1]=true
            addKey()
            sloveProblem:setVolume(getVol())
            sloveProblem:play()
        end
    end
end

function question4_keypressedLine(key)
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

function question4_draw(dialogNum)
    love.graphics.setColor(0,0,0,150)
    love.graphics.rectangle("fill", 0,0, 1100, 614)
    love.graphics.setColor(255,255,255)
    if showKey == true then
        if q4_dialog_state == (deskChair[dialogNum].dialogLength+1) then
            showKey = false
            question = false
            q4_dialogLockKey = true
            q4_dialog_state = 2
            q4_dialog_namestate = 1
            atk_timeout = 0
        end
        if deskChair[dialogNum].dialog[q4_dialog_namestate] == "nil" then
            deskChair[dialogNum].dialog[q4_dialog_namestate] = " "
        end
                print_dialog(deskChair[dialogNum].dialog[q4_dialog_namestate],deskChair[dialogNum].dialog[q4_dialog_state])
    else
        love.graphics.draw(questionImage4, 0, 0,0,1100/imageWidth4,614/imageHeight4)
        for i=1,12 do
           if bar[i]==true then
                love.graphics.setColor(255,0,0)
            else
                love.graphics.setColor(0,0,0)
            end
            love.graphics.rectangle("fill", 1000*i/13+25,600-(550*barHeight[i]/3) -85, 700/12-20, 530*barHeight[i]/3 )
        end
        if q4_dialog_stateLine == 1 then
            print_dialog("", "ＯＥ小雞雞？")
        --elseif q4_dialog_stateLine == 2 then
          --  print_dialog("", "真是麻煩")
        elseif q4_dialog_stateLine == 3 then
          --  print_dialog("", "真是一個不標準的長條圖，什麼標示都沒有")
        --elseif q2_dialog_stateLine == 4 then
            q4_dialogLockLine = true
           q4_dialog_stateLine=1
            question = false
        end
    end
end
