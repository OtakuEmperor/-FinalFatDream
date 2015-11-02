q2key={}
questionMark2={}
local bar={}
local barHeight={}
local keyWidth=670
local keyHeight=390
local delay = 0.15
local delta = 0
-- this function is for OOP
function newObject(o, class)
    class.__index = class
    return setmetatable(o, class)
end
function question2_load()
    keyImage = love.graphics.newImage("img/key2.jpg")
    questionImage2 = love.graphics.newImage("img/question2.png")
    imageWidth2=1166
    imageHeight2=565
    for i=1,12 do
        bar[i]= false
        barHeight[i]=1
    end
    bar[1]=true
end
function question2_update(dt)
    local count
    for i=1,12 do
        if bar[i]==true then
            count=i
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
        local selectU= switchU[count]
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
        local selectD= switchD[count]
        if delta >= delay then
            if(selectD) then
                selectD()
            end
            delta = 0
		end  
    end
    if barHeight[1] == 2 and barHeight[2] == 1 and barHeight[3] == 2 and barHeight[4] == 0 and barHeight[5] == 0 and barHeight[6] == 2 and barHeight[7] == 0 and barHeight[8] == 1 and barHeight[9] == 2 and barHeight[10] == 1 and barHeight[11] == 0 and barHeight[12] == 2 then
        question=false
        for i=1,12 do
        bar[i]= false
        barHeight[i]=1
        end
        bar[1]=true
        addKey()
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
    else
        love.graphics.draw(questionImage2, 0, 0,0,1100/imageWidth2,614/imageHeight2)
        for i=1,12 do
           if bar[i]==true then
                love.graphics.setColor(255,0,0)
            else
                love.graphics.setColor(0,0,0) 
            end
            love.graphics.rectangle("fill", 1000*i/13,600-(550*barHeight[i]/3) , 700/12, 530*barHeight[i]/3 )
        end
    end
end


function q2key.new (originPointX,originPointY)
    local obj = {
        Image = love.graphics.newImage("img/tree.png"),
        Barrier=true,
        x = originPointX,
        y = originPointY
    }
    obj = newObject(obj, q2key)
    return obj
end

function questionMark2.new (originPointX,originPointY)
    local obj = {
        Image = love.graphics.newImage("img/tree.png"),
        Barrier=true,
        x = originPointX,
        y = originPointY
    }
    obj = newObject(obj, q3Trap)
    return obj
end