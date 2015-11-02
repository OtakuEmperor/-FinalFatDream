q3Trap={}
q3key={}
questionMark3={}
local keyWidth=1080
local keyHeight=527
local q3Block={}
local q3BlockNum={}
local delay=0.15
local delta=0
-- this function is for OOP
function newObject(o, class)
    class.__index = class
    return setmetatable(o, class)
end

function question3_load()
    q3KeyImage = love.graphics.newImage("img/key3.jpg")
    questionImage3 = love.graphics.newImage("img/question2.png")
    imageWidth3=1166
    imageHeight3=565
    for i=1,20 do
        q3Block[i] = false
        q3BlockNum[i] = 0
    end
    q3Block[1] = true
end

function question3_update(dt)
    local count
    for i=1,20 do
        if q3Block[i] == true then
            count = i
        end
    end
    local switchR = {}
    for i=1 ,19 do
        switchR[i] = function()    -- for case i
            for j=1,20 do
                q3Block[j]=false
            end
            q3Block[i+1]=true
        end
    end
    switchR[20] = function()    -- for case i
        for j=1,20 do
            q3Block[j]=false
        end
        q3Block[1]=true
    end
    local switchL = {}
    for i=2 ,20 do
        switchL[i] = function()    -- for case i
            for j=1,20 do
                q3Block[j]=false
            end
            q3Block[i-1]=true
        end
    end
    switchL[1] = function()    -- for case i
        for j=1,20 do
            q3Block[j]=false
        end
        q3Block[20]=true
    end
    local switchU = {}
    for i=11 ,20 do
        switchU[i] = function()    -- for case i
            for j=1,20 do
                q3Block[j]=false
            end
            q3Block[i-10]=true
        end
    end
    local switchD = {}
    for i=1 ,10 do
        switchD[i] = function()    -- for case i
            for j=1,20 do
                q3Block[j]=false
            end
            q3Block[i+10]=true
        end
    end
    if love.keyboard.isDown("right") and question == true then
         --switch&case()
        delta = delta + dt
        local selectR = switchR[count]
        if delta >= delay then
            if(selectR) then
                selectR()
            end
            delta = 0
		end  
    end
    if love.keyboard.isDown("left") and question == true then
         --switch&case()
        delta = delta + dt
        local selectL = switchL[count]
        if delta >= delay then
            if(selectL) then
                selectL()
            end
            delta = 0
		end  
    end
    if love.keyboard.isDown("up") and question == true then
         --switch&case()
        delta = delta + dt
        local selectU = switchU[count]
        if delta >= delay then
            if(selectU) then
                selectU()
            end
            delta = 0
		end  
    end
    if love.keyboard.isDown("down") and question == true then
         --switch&case()
        delta = delta + dt
        local selectD = switchD[count]
        if delta >= delay then
            if(selectD) then
                selectD()
            end
            delta = 0
		end  
    end
    if love.keyboard.isDown("9") and question == true then
        delta = delta + dt
        selectR = switchR[count]
        if delta >= delay+0.1  then
            q3BlockNum[count]=9
            if(selectR) then
                selectR()
            end
            delta = 0
		end  
    end
    if love.keyboard.isDown("8") and question == true then
        delta = delta + dt
        selectR = switchR[count]
        if delta >= delay+0.1  then
            q3BlockNum[count]=8
            if(selectR) then
                selectR()
            end
            delta = 0
		end  
    end
    if love.keyboard.isDown("7") and question == true then
        delta = delta + dt
        selectR = switchR[count]
        if delta >= delay+0.1  then
            q3BlockNum[count]=7
            if(selectR) then
                selectR()
            end
            delta = 0
		end  
    end
    if love.keyboard.isDown("6") and question == true then
        delta = delta + dt
        selectR = switchR[count]
        if delta >= delay+0.1  then
            q3BlockNum[count]=6
            if(selectR) then
                selectR()
            end
            delta = 0
		end  
    end
    if love.keyboard.isDown("5") and question == true then
        delta = delta + dt
        selectR = switchR[count]
        if delta >= delay+0.1  then
            q3BlockNum[count]=5
            if(selectR) then
                selectR()
            end
            delta = 0
		end  
    end
    if love.keyboard.isDown("4") and question == true then
        delta = delta + dt
        selectR = switchR[count]
        if delta >= delay+0.1  then
            q3BlockNum[count]=4
            if(selectR) then
                selectR()
            end
            delta = 0
		end  
    end
    if love.keyboard.isDown("3") and question == true then
        delta = delta + dt
        selectR = switchR[count]
        if delta >= delay+0.1  then
            q3BlockNum[count]=3
            if(selectR) then
                selectR()
            end
            delta = 0
		end  
    end
    if love.keyboard.isDown("2") and question == true then
        delta = delta + dt
        selectR = switchR[count]
        if delta >= delay+0.1  then
            q3BlockNum[count]=2
            if(selectR) then
                selectR()
            end
            delta = 0
		end  
    end
    if love.keyboard.isDown("1") and question == true then
        delta = delta + dt
        selectR = switchR[count]
        if delta >= delay+0.1  then
            q3BlockNum[count]=1
            if(selectR) then
                selectR()
            end
            delta = 0
		end  
    end
    if love.keyboard.isDown("0") and question == true then
        delta = delta + dt
        selectR = switchR[count]
        if delta >= delay+0.1 then
            q3BlockNum[count]=0
            if(selectR) then
                selectR()
            end
            delta = 0
		end  
    end
    if q3BlockNum[1] == 1 and q3BlockNum[2] == 2 and q3BlockNum[3] == 3 and q3BlockNum[4] == 4 and q3BlockNum[5] == 5 and q3BlockNum[6] == 6 and q3BlockNum[7] == 7 and q3BlockNum[8] == 8 and q3BlockNum[9] == 9 and q3BlockNum[10] == 0 and q3BlockNum[11] == 0 and q3BlockNum[12] == 1 and q3BlockNum[13] == 2 and q3BlockNum[14] == 3 and q3BlockNum[15] == 4 and q3BlockNum[16] == 5 and q3BlockNum[17] == 6 and q3BlockNum[18] == 7 and q3BlockNum[19] == 8 and q3BlockNum[20] == 9 then
        question=false
        for i=1,20 do
            q3Block[i] = false
            q3BlockNum[i] = 0
        end
        q3Block[1] = true
        addKey()
    end
end

function question3_draw()
    local blockWidth=60
    local blockHeight=60
    love.graphics.setColor(0,0,0,150)
    love.graphics.rectangle("fill", 0,0, 1100, 614)
    love.graphics.setColor(255,255,255)
    if showQ3Answer == true then
        love.graphics.draw(q3KeyImage, (1100-keyWidth)/2, (614-keyHeight)/2, 0)
        love.graphics.setColor(255,255,255)
    else
        love.graphics.draw(questionImage3, 0, 0,0,1100/imageWidth3,614/imageHeight3)
        for i=1,5 do
            if q3Block[i] == true then
                love.graphics.setColor(255,0,0)
            else
                love.graphics.setColor(0,0,0)
            end
            love.graphics.rectangle("line", 100+((i-1)*(20+blockWidth)),200 , blockWidth, blockHeight )
            love.graphics.setColor(0,0,0)
            love.graphics.setFont(love.graphics.newFont(50))
            love.graphics.print(q3BlockNum[i], 114+((i-1)*(20+blockWidth)), 200)
        end
        for i=6,10 do
            if q3Block[i] == true then
                love.graphics.setColor(255,0,0)
            else
                love.graphics.setColor(0,0,0)
            end
            love.graphics.rectangle("line", 200+((i-1)*(20+blockWidth)),200 , blockWidth, blockHeight )
            love.graphics.setColor(0,0,0)
            love.graphics.setFont(love.graphics.newFont(50))
            love.graphics.print(q3BlockNum[i], 214+((i-1)*(20+blockWidth)), 200)
        end
        for i=11,15 do
            if q3Block[i] == true then
                love.graphics.setColor(255,0,0)
            else
                love.graphics.setColor(0,0,0)
            end
            love.graphics.rectangle("line", 100+((i-11)*(20+blockWidth)),400 , blockWidth, blockHeight )
            love.graphics.setColor(0,0,0)
            love.graphics.setFont(love.graphics.newFont(50))
            love.graphics.print(q3BlockNum[i], 114+((i-11)*(20+blockWidth)), 400)
        end
        for i=16,20 do
            if q3Block[i] == true then
                love.graphics.setColor(255,0,0)
            else
                love.graphics.setColor(0,0,0)
            end
            love.graphics.rectangle("line", 200+((i-11)*(20+blockWidth)),400 , blockWidth, blockHeight )
            love.graphics.setColor(0,0,0)
            love.graphics.setFont(love.graphics.newFont(50))
            love.graphics.print(q3BlockNum[i], 214+((i-11)*(20+blockWidth)), 400)
        end
    end
end

function q3Trap.new (originPointX,originPointY)
    local obj = {
        Image = love.graphics.newImage("img/tree.png"),
        Barrier=true,
        x = originPointX,
        y = originPointY,
        showBar=true,
        showDelay=1,
        disappearDelay=3,
        delta=0
    }
    obj = newObject(obj, q3Trap)
    return obj
end
function q3Trap:update(dt)
    self.delta = self.delta + dt
    if self.showBar == true then
        if self.delta >= self.showDelay then
            self.showBar=false
            self.delta=0
        end
    end
    if self.showBar == false then
        if self.delta >= self.disappearDelay then
            self.showBar=true
            self.delta=0
        end
    end
end

function q3key.new (originPointX,originPointY)
    local obj = {
        Image = love.graphics.newImage("img/tree.png"),
        Barrier=true,
        x = originPointX,
        y = originPointY
    }
    obj = newObject(obj, q3key)
    return obj
end
function questionMark3.new (originPointX,originPointY)
    local obj = {
        Image = love.graphics.newImage("img/tree.png"),
        Barrier=true,
        x = originPointX,
        y = originPointY
    }
    obj = newObject(obj, questionMark3)
    return obj
end