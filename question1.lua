questionMark1={}
local imageWidth=1015
local imageHeight=353
-- this function is for OOP
function newObject(o, class)
    class.__index = class
    return setmetatable(o, class)
end
function question1_load()
    questionImage = love.graphics.newImage("img/question1.jpg")
    
    block1=true
    block2=false
    block3=false
    block4=false
    blockNum1=0
    blockNum2=0
    blockNum3=0
    blockNum4=0
    q1delay=0.15
    q1delta=0
end

function question1_update(dt)
    local count
    if block1 == true then 
        count=1
    elseif block2 == true then
        count=2
    elseif block3 == true then
        count=3
    elseif block4 == true then
        count=4
    end
    local switchR = {
        [1] = function()    -- for case 1
            block1=false
            block2=true
            block3=false
            block4=false
        end,
        [2] = function()    -- for case 2
            block1=false
            block2=false
            block3=true
            block4=false
        end,
        [3] = function()    -- for case 3
            block1=false
            block2=false
            block3=false
            block4=true
        end,
        [4] = function()    -- for case 4
            block1=true
            block2=false
            block3=false
            block4=false 
        end
    }
    local switchL = {
        [1] = function()    -- for case 1
            block1=false
            block2=false
            block3=false
            block4=true
        end,
        [2] = function()    -- for case 2
            block1=true
            block2=false
            block3=false
            block4=false
        end,
        [3] = function()    -- for case 3
            block1=false
            block2=true
            block3=false
            block4=false
        end,
        [4] = function()    -- for case 4
            block1=false
            block2=false
            block3=true
            block4=false 
        end
    }
    local switchU = {
        [1] = function()    -- for case 1
           if blockNum1 ~= 9 then
                blockNum1=blockNum1+1
            elseif blockNum1 == 9 then
                blockNum1=0
            end
        end,
        [2] = function()    -- for case 2
            if blockNum2 ~= 9 then
                blockNum2=blockNum2+1
            elseif blockNum2 == 9 then
                blockNum2=0
            end
        end,
        [3] = function()    -- for case 3
           if blockNum3 ~= 9 then
                blockNum3=blockNum3+1
            elseif blockNum3 == 9 then
                blockNum3=0
            end
        end,
        [4] = function()    -- for case 4
            if blockNum4 ~= 9 then
                blockNum4=blockNum4+1
            elseif blockNum4 == 9 then
                blockNum4=0
            end
        end
    }
    local switchD = {
        [1] = function()    -- for case 1
           if blockNum1 ~= 0 then
                blockNum1=blockNum1-1
            elseif blockNum1 == 0 then
                blockNum1=9
            end
        end,
        [2] = function()    -- for case 2
            if blockNum2 ~= 0 then
                blockNum2=blockNum2-1
            elseif blockNum2 == 0 then
                blockNum2=9
            end
        end,
        [3] = function()    -- for case 3
           if blockNum3 ~= 0 then
                blockNum3=blockNum3-1
            elseif blockNum3 == 0 then
                blockNum3=9
            end
        end,
        [4] = function()    -- for case 4
            if blockNum4 ~= 0 then
                blockNum4=blockNum4-1
            elseif blockNum4 == 0 then
                blockNum4=9
            end
        end
    }
    if love.keyboard.isDown("right") and question == true then
         --switch&case()
        q1delta = q1delta + dt
        local selectR = switchR[count]
        if q1delta >= q1delay then
            if(selectR) then
                selectR()
            end
            q1delta = 0
        end  
    end
    if love.keyboard.isDown("left") and question == true then
         --switch&case()
        q1delta = q1delta + dt
        local selectL = switchL[count]
        if q1delta >= q1delay then
            if(selectL) then
                selectL()
            end
           q1delta = 0
        end  
    end
    if love.keyboard.isDown("up") and question == true then
         --switch&case()
        q1delta = q1delta + dt
        local selectU= switchU[count]
        if q1delta >= q1delay then
            if(selectU) then
                selectU()
            end
            q1delta = 0
        end  
    end
    if love.keyboard.isDown("down") and question == true then
         --switch&case()
        q1delta = q1delta + dt
        local selectD= switchD[count]
        if q1delta >= q1delay then
            if(selectD) then
                selectD()
            end
            q1delta = 0
        end  
    end
    if blockNum1 == 0 and blockNum2 == 9 then
        if blockNum3 == 0 and blockNum4 == 0 then
            q1delta = q1delta + dt
            if q1delta >= 0.5 then
                question=false
                blockNum1=0
                blockNum2=0
                blockNum3=0
                blockNum4=0
                block1=true
                block2=false
                block3=false
                block4=false
                q1delta = 0
                addKey()
            end
        end
    end
end

function question1_draw()
    love.graphics.setColor(0,0,0,150)
    love.graphics.rectangle("fill", 0,0, 1100, 614)
    love.graphics.setColor(0,0,0)
    love.graphics.rectangle("fill", 40, (love.graphics.getHeight()*2/3-imageHeight)/2-3, 1021, 359 )
    love.graphics.setColor(255,255,255)
    --love.graphics.rectangle("fill", 0, love.graphics.getHeight()*2/3, love.graphics.getWidth(), love.graphics.getHeight()*1/3)
    --love.graphics.rectangle("fill", 0, 378, 1100, 307 )
    love.graphics.draw(questionImage, 43, (love.graphics.getHeight()*2/3-imageHeight)/2 )
    if block1 == true then
        love.graphics.setColor(255,0,0)
    else
        love.graphics.setColor(0,0,0)
    end
    love.graphics.rectangle("fill", 197, love.graphics.getHeight()*2/3+(love.graphics.getHeight()*1/3-100)/2-3, 106, 106 )
    
    if block2 == true then
        love.graphics.setColor(255,0,0)
    else
        love.graphics.setColor(0,0,0)
    end
    love.graphics.rectangle("fill", 397,love.graphics.getHeight()*2/3+(love.graphics.getHeight()*1/3-100)/2-3, 106, 106 )
    
    if block3 == true then
        love.graphics.setColor(255,0,0)
    else
        love.graphics.setColor(0,0,0)
    end
    love.graphics.rectangle("fill", 597, love.graphics.getHeight()*2/3+(love.graphics.getHeight()*1/3-100)/2-3, 106, 106 )
    
    if block4 == true then
        love.graphics.setColor(255,0,0)
    else
        love.graphics.setColor(0,0,0)
    end
    love.graphics.rectangle("fill", 797, love.graphics.getHeight()*2/3+(love.graphics.getHeight()*1/3-100)/2-3, 106, 106 )
    love.graphics.setColor(255,255,255)
    love.graphics.rectangle("fill", 200, love.graphics.getHeight()*2/3+(love.graphics.getHeight()*1/3-100)/2, 100, 100 ) 
    love.graphics.rectangle("fill", 400, love.graphics.getHeight()*2/3+(love.graphics.getHeight()*1/3-100)/2, 100, 100 )
    love.graphics.rectangle("fill", 600, love.graphics.getHeight()*2/3+(love.graphics.getHeight()*1/3-100)/2, 100, 100 )
    love.graphics.rectangle("fill", 800, love.graphics.getHeight()*2/3+(love.graphics.getHeight()*1/3-100)/2, 100, 100 )
    love.graphics.setColor(0,0,0)
    love.graphics.setFont(love.graphics.newFont(100))
    love.graphics.print(blockNum1, 220, 453)
    love.graphics.print(blockNum2, 420, 453)
    love.graphics.print(blockNum3, 620, 453)
    love.graphics.print(blockNum4, 820, 453)
    
end

function questionMark1.new (originPointX,originPointY)
    local obj = {
        Image = love.graphics.newImage("img/puzzle.png"),
        Barrier=true,
        x = originPointX,
        y = originPointY
    }
    obj = newObject(obj, q3Trap)
    return obj
end
