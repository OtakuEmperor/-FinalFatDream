q2key={}
questionMark2={}
-- this function is for OOP
function newObject(o, class)
    class.__index = class
    return setmetatable(o, class)
end
function question2_load()
    keyImage = love.graphics.newImage("img/key.jpg")
    questionImage2 = love.graphics.newImage("img/question2.png")
    imageWidth2=1166
    imageHeight2=565
    bar1 = true
    bar2 = false
    bar3 = false
    bar4 = false
    bar5 = false
    bar6 = false
    bar7 = false
    bar8 = false
    bar9 = false
    bar10 = false
    bar11 = false
    bar12 = false
    barHeight1 = 3
    barHeight2 = 3
    barHeight3 = 3
    barHeight4 = 3
    barHeight5 = 2
    barHeight6 = 2
    barHeight7 = 2
    barHeight8 = 2
    barHeight9 = 1
    barHeight10 = 1
    barHeight11 = 1
    barHeight12 = 1
    q2delay=0.15
    q2delta=0
end
function question2_update(dt)
    local count
    if bar1 == true then 
        count=1
    elseif bar2 == true then
        count=2
    elseif bar3 == true then
        count=3
    elseif bar4 == true then
        count=4
    elseif bar5 == true then
        count=5
    elseif bar6 == true then
        count=6
    elseif bar7 == true then
        count=7
    elseif bar8 == true then
        count=8
    elseif bar9 == true then
        count=9
    elseif bar10 == true then
        count=10
    elseif bar11 == true then
        count=11
    elseif bar12 == true then
        count=12
    end
    
    local switchR = {
        [1] = function()    -- for case 1
            bar1 = false
            bar2 = true
            bar3 = false
            bar4 = false
            bar5 = false
            bar6 = false
            bar7 = false
            bar8 = false
            bar9 = false
            bar10 = false
            bar11 = false
            bar12 = false
        end,
        [2] = function()    -- for case 2
            bar1 = false
            bar2 = false
            bar3 = true
            bar4 = false
            bar5 = false
            bar6 = false
            bar7 = false
            bar8 = false
            bar9 = false
            bar10 = false
            bar11 = false
            bar12 = false
        end,
        [3] = function()    -- for case 3
            bar1 = false
            bar2 = false
            bar3 = false
            bar4 = true
            bar5 = false
            bar6 = false
            bar7 = false
            bar8 = false
            bar9 = false
            bar10 = false
            bar11 = false
            bar12 = false
        end,
        [4] = function()    -- for case 4
            bar1 = false
            bar2 = false
            bar3 = false
            bar4 = false
            bar5 = true
            bar6 = false
            bar7 = false
            bar8 = false
            bar9 = false
            bar10 = false
            bar11 = false
            bar12 = false 
        end,
        [5] = function()    -- for case 4
            bar1 = false
            bar2 = false
            bar3 = false
            bar4 = false
            bar5 = false
            bar6 = true
            bar7 = false
            bar8 = false
            bar9 = false
            bar10 = false
            bar11 = false
            bar12 = false 
        end,
        [6] = function()    -- for case 4
            bar1 = false
            bar2 = false
            bar3 = false
            bar4 = false
            bar5 = false
            bar6 = false
            bar7 = true
            bar8 = false
            bar9 = false
            bar10 = false
            bar11 = false
            bar12 = false 
        end,
        [7] = function()    -- for case 4
            bar1 = false
            bar2 = false
            bar3 = false
            bar4 = false
            bar5 = false
            bar6 = false
            bar7 = false
            bar8 = true
            bar9 = false
            bar10 = false
            bar11 = false
            bar12 = false 
        end,
        [8] = function()    -- for case 4
            bar1 = false
            bar2 = false
            bar3 = false
            bar4 = false
            bar5 = false
            bar6 = false
            bar7 = false
            bar8 = false
            bar9 = true
            bar10 = false
            bar11 = false
            bar12 = false 
        end,
        [9] = function()    -- for case 4
            bar1 = false
            bar2 = false
            bar3 = false
            bar4 = false
            bar5 = false
            bar6 = false
            bar7 = false
            bar8 = false
            bar9 = false
            bar10 = true
            bar11 = false
            bar12 = false 
        end,
        [10] = function()    -- for case 4
            bar1 = false
            bar2 = false
            bar3 = false
            bar4 = false
            bar5 = false
            bar6 = false
            bar7 = false
            bar8 = false
            bar9 = false
            bar10 = false
            bar11 = true
            bar12 = false 
        end,
        [11] = function()    -- for case 4
            bar1 = false
            bar2 = false
            bar3 = false
            bar4 = false
            bar5 = false
            bar6 = false
            bar7 = false
            bar8 = false
            bar9 = false
            bar10 = false
            bar11 = false
            bar12 = true 
        end,
        [12] = function()    -- for case 4
            bar1 = true
            bar2 = false
            bar3 = false
            bar4 = false
            bar5 = false
            bar6 = false
            bar7 = false
            bar8 = false
            bar9 = false
            bar10 = false
            bar11 = false
            bar12 = false 
        end
    }
    local switchL = {
        [1] = function()    -- for case 1
            bar1 = false
            bar2 = false
            bar3 = false
            bar4 = false
            bar5 = false
            bar6 = false
            bar7 = false
            bar8 = false
            bar9 = false
            bar10 = false
            bar11 = false
            bar12 = true
        end,
        [2] = function()    -- for case 2
            bar1 = true
            bar2 = false
            bar3 = false
            bar4 = false
            bar5 = false
            bar6 = false
            bar7 = false
            bar8 = false
            bar9 = false
            bar10 = false
            bar11 = false
            bar12 = false
        end,
        [3] = function()    -- for case 3
            bar1 = false
            bar2 = true
            bar3 = false
            bar4 = false
            bar5 = false
            bar6 = false
            bar7 = false
            bar8 = false
            bar9 = false
            bar10 = false
            bar11 = false
            bar12 = false
        end,
        [4] = function()    -- for case 4
            bar1 = false
            bar2 = false
            bar3 = true
            bar4 = false
            bar5 = false
            bar6 = false
            bar7 = false
            bar8 = false
            bar9 = false
            bar10 = false
            bar11 = false
            bar12 = false 
        end,
        [5] = function()    -- for case 4
            bar1 = false
            bar2 = false
            bar3 = false
            bar4 = true
            bar5 = false
            bar6 = false
            bar7 = false
            bar8 = false
            bar9 = false
            bar10 = false
            bar11 = false
            bar12 = false 
        end,
        [6] = function()    -- for case 4
            bar1 = false
            bar2 = false
            bar3 = false
            bar4 = false
            bar5 = true
            bar6 = false
            bar7 = false
            bar8 = false
            bar9 = false
            bar10 = false
            bar11 = false
            bar12 = false 
        end,
        [7] = function()    -- for case 4
            bar1 = false
            bar2 = false
            bar3 = false
            bar4 = false
            bar5 = false
            bar6 = true
            bar7 = false
            bar8 = false
            bar9 = false
            bar10 = false
            bar11 = false
            bar12 = false 
        end,
        [8] = function()    -- for case 4
            bar1 = false
            bar2 = false
            bar3 = false
            bar4 = false
            bar5 = false
            bar6 = false
            bar7 = true
            bar8 = false
            bar9 = false
            bar10 = false
            bar11 = false
            bar12 = false 
        end,
        [9] = function()    -- for case 4
            bar1 = false
            bar2 = false
            bar3 = false
            bar4 = false
            bar5 = false
            bar6 = false
            bar7 = false
            bar8 = true
            bar9 = false
            bar10 = false
            bar11 = false
            bar12 = false 
        end,
        [10] = function()    -- for case 4
            bar1 = false
            bar2 = false
            bar3 = false
            bar4 = false
            bar5 = false
            bar6 = false
            bar7 = false
            bar8 = false
            bar9 = true
            bar10 = false
            bar11 = false
            bar12 = false 
        end,
        [11] = function()    -- for case 4
            bar1 = false
            bar2 = false
            bar3 = false
            bar4 = false
            bar5 = false
            bar6 = false
            bar7 = false
            bar8 = false
            bar9 = false
            bar10 = true
            bar11 = false
            bar12 = false 
        end,
        [12] = function()    -- for case 4
            bar1 = false
            bar2 = false
            bar3 = false
            bar4 = false
            bar5 = false
            bar6 = false
            bar7 = false
            bar8 = false
            bar9 = false
            bar10 = false
            bar11 = true
            bar12 = false 
        end
    }
    local switchU = {
        [1] = function()    -- for case 1
           if barHeight1 ~= 3 then
                barHeight1=barHeight1+1
            elseif barHeight1 == 3 then
                barHeight1=3
            end
        end,
        [2] = function()    -- for case 2
            if barHeight2 ~= 3 then
                barHeight2=barHeight2+1
            elseif barHeight2 == 3 then
                barHeight2=3
            end
        end,
        [3] = function()    -- for case 3
           if barHeight3 ~= 3 then
                barHeight3=barHeight3+1
            elseif barHeight3 == 3 then
                barHeight3=3
            end
        end,
        [4] = function()    -- for case 4
            if barHeight4 ~= 3 then
                barHeight4=barHeight4+1
            elseif barHeight4 == 3 then
                barHeight4=3
            end
        end,
        [5] = function()    -- for case 4
            if barHeight5 ~= 3 then
                barHeight5=barHeight5+1
            elseif barHeight5 == 3 then
                barHeight5=3
            end
        end,
        [6] = function()    -- for case 4
            if barHeight6 ~= 3 then
                barHeight6=barHeight6+1
            elseif barHeight6 == 3 then
                barHeight6=3
            end
        end,
        [7] = function()    -- for case 4
            if barHeight7 ~= 3 then
                barHeight7=barHeight7+1
            elseif barHeight7 == 3 then
                barHeight7=3
            end
        end,
        [8] = function()    -- for case 4
            if barHeight8 ~= 3 then
                barHeight8=barHeight8+1
            elseif barHeight8 == 3 then
                barHeight8=3
            end
        end,
        [9] = function()    -- for case 4
            if barHeight9 ~= 3 then
                barHeight9=barHeight9+1
            elseif barHeight9 == 3 then
                barHeight9=3
            end
        end,
        [10] = function()    -- for case 4
            if barHeight10 ~= 3 then
                barHeight10=barHeight10+1
            elseif barHeight10 == 3 then
                barHeight10=3
            end
        end,
        [11] = function()    -- for case 4
            if barHeight11 ~= 3 then
                barHeight11=barHeight11+1
            elseif barHeight11 == 3 then
                barHeight11=3
            end
        end,
        [12] = function()    -- for case 4
            if barHeight12 ~= 3 then
                barHeight12=barHeight12+1
            elseif barHeight12 == 3 then
                barHeight12=3
            end
        end
    }
    local switchD = {
        [1] = function()    -- for case 1
           if barHeight1 ~= 1 then
                barHeight1=barHeight1-1
            elseif barHeight1 == 1 then
                barHeight1=1
            end
        end,
        [2] = function()    -- for case 2
            if barHeight2 ~= 1 then
                barHeight2=barHeight2-1
            elseif barHeight2 == 1 then
                barHeight2=1
            end
        end,
        [3] = function()    -- for case 3
           if barHeight3 ~= 1 then
                barHeight3=barHeight3-1
            elseif barHeight3 == 1 then
                barHeight3=1
            end
        end,
        [4] = function()    -- for case 4
            if barHeight4 ~= 1 then
                barHeight4=barHeight4-1
            elseif barHeight4 == 1 then
                barHeight4=1
            end
        end,
        [5] = function()    -- for case 4
            if barHeight5 ~= 1 then
                barHeight5=barHeight5-1
            elseif barHeight5 == 1 then
                barHeight5=1
            end
        end,
        [6] = function()    -- for case 4
            if barHeight6 ~= 1 then
                barHeight6=barHeight6-1
            elseif barHeight6 == 1 then
                barHeight6=1
            end
        end,
        [7] = function()    -- for case 4
            if barHeight7 ~= 1 then
                barHeight7=barHeight7-1
            elseif barHeight7 == 1 then
                barHeight7=1
            end
        end,
        [8] = function()    -- for case 4
            if barHeight8 ~= 1 then
                barHeight8=barHeight8-1
            elseif barHeight8 == 1 then
                barHeight8=1
            end
        end,
        [9] = function()    -- for case 4
            if barHeight9 ~= 1 then
                barHeight9=barHeight9-1
            elseif barHeight9 == 1 then
                barHeight9=1
            end
        end,
        [10] = function()    -- for case 4
            if barHeight10 ~= 1 then
                barHeight10=barHeight10-1
            elseif barHeight10 == 1 then
                barHeight10=1
            end
        end,
        [11] = function()    -- for case 4
            if barHeight11 ~= 1 then
                barHeight11=barHeight11-1
            elseif barHeight11 == 1 then
                barHeight11=1
            end
        end,
        [12] = function()    -- for case 4
            if barHeight12 ~= 1 then
                barHeight12=barHeight12-1
            elseif barHeight12 == 1 then
                barHeight12=1
            end
        end
    }
    if love.keyboard.isDown("right") and question == true then
         --switch&case()
        q2delta = q2delta + dt
        local selectR = switchR[count]
        if q2delta >= q2delay then
            if(selectR) then
                selectR()
            end
            q2delta = 0
		end  
    end
    if love.keyboard.isDown("left") and question == true then
         --switch&case()
        q2delta = q2delta + dt
        local selectL = switchL[count]
        if q2delta >= q2delay then
            if(selectL) then
                selectL()
            end
            q2delta = 0
		end  
    end
    if love.keyboard.isDown("up") and question == true then
         --switch&case()
        q2delta = q2delta + dt
        local selectU= switchU[count]
        if q2delta >= q2delay then
            if(selectU) then
                selectU()
            end
            q2delta = 0
		end  
    end
    if love.keyboard.isDown("down") and question == true then
         --switch&case()
        q2delta = q2delta + dt
        local selectD= switchD[count]
        if q2delta >= q2delay then
            if(selectD) then
                selectD()
            end
            q2delta = 0
		end  
    end
    if barHeight1 == 3 and barHeight2 == 3 and barHeight3 == 3 and barHeight4 == 3 and barHeight5 == 3 and barHeight6 == 3 and barHeight7 == 3 and barHeight8 == 3 and barHeight9 == 3 and barHeight10 == 3 and barHeight11 == 3 and barHeight12 == 3 then
        question=false
        bar1 = true
        bar2 = false
        bar3 = false
        bar4 = false
        bar5 = false
        bar6 = false
        bar7 = false
        bar8 = false
        bar9 = false
        bar10 = false
        bar11 = false
        bar12 = false
        barHeight1 = 3
        barHeight2 = 3
        barHeight3 = 3
        barHeight4 = 3
        barHeight5 = 2
        barHeight6 = 2
        barHeight7 = 2
        barHeight8 = 2
        barHeight9 = 1
        barHeight10 = 1
        barHeight11 = 1
        barHeight12 = 1
    end
end
function question2_draw()
    love.graphics.setColor(255,255,255)
    if showKey == true then
        love.graphics.draw(keyImage, 0, 0)
    else
        love.graphics.draw(questionImage2, 0, 0,0,1100/imageWidth2,614/imageHeight2)
        if bar1 == true then
            love.graphics.setColor(255,0,0)
        else
            love.graphics.setColor(0,0,0)
        end
        love.graphics.rectangle("fill", 400/13,600-(550*barHeight1/3) , 700/12, 530*barHeight1/3 )
        if bar2 == true then
            love.graphics.setColor(255,0,0)
        else
            love.graphics.setColor(0,0,0)
        end
        love.graphics.rectangle("fill", (400*2/13)+(700/12),600-(550*barHeight2/3) , 700/12, 530*barHeight2/3 )
        if bar3 == true then
            love.graphics.setColor(255,0,0)
        else
            love.graphics.setColor(0,0,0)
        end
        love.graphics.rectangle("fill", (400*3/13)+(700*2/12),600-(550*barHeight3/3) , 700/12, 530*barHeight3/3 )
        if bar4 == true then
            love.graphics.setColor(255,0,0)
        else
            love.graphics.setColor(0,0,0)
        end
        love.graphics.rectangle("fill", (400*4/13)+(700*3/12),600-(550*barHeight4/3) , 700/12, 530*barHeight4/3 )
        if bar5 == true then
            love.graphics.setColor(255,0,0)
        else
            love.graphics.setColor(0,0,0)
        end
        love.graphics.rectangle("fill", (400*5/13)+(700*4/12),600-(550*barHeight5/3) , 700/12, 530*barHeight5/3 )
        if bar6 == true then
            love.graphics.setColor(255,0,0)
        else
            love.graphics.setColor(0,0,0)
        end
        love.graphics.rectangle("fill", (400*6/13)+(700*5/12),600-(550*barHeight6/3) , 700/12, 530*barHeight6/3 )
        if bar7 == true then
            love.graphics.setColor(255,0,0)
        else
            love.graphics.setColor(0,0,0)
        end
        love.graphics.rectangle("fill", (400*7/13)+(700*6/12),600-(550*barHeight7/3) , 700/12, 530*barHeight7/3 )
        if bar8 == true then
            love.graphics.setColor(255,0,0)
        else
            love.graphics.setColor(0,0,0)
        end
        love.graphics.rectangle("fill", (400*8/13)+(700*7/12),600-(550*barHeight8/3) , 700/12, 530*barHeight8/3 )
        if bar9 == true then
            love.graphics.setColor(255,0,0)
        else
            love.graphics.setColor(0,0,0)
        end
        love.graphics.rectangle("fill", (400*9/13)+(700*8/12),600-(550*barHeight9/3) , 700/12, 530*barHeight9/3 )
        if bar10 == true then
            love.graphics.setColor(255,0,0)
        else
            love.graphics.setColor(0,0,0)
        end
        love.graphics.rectangle("fill", (400*10/13)+(700*9/12),600-(550*barHeight10/3) , 700/12, 530*barHeight10/3 )
        if bar11 == true then
            love.graphics.setColor(255,0,0)
        else
            love.graphics.setColor(0,0,0)
        end
        love.graphics.rectangle("fill", (400*11/13)+(700*10/12),600-(550*barHeight11/3) , 700/12, 530*barHeight11/3 )
        if bar12 == true then
            love.graphics.setColor(255,0,0)
        else
            love.graphics.setColor(0,0,0)
        end
        love.graphics.rectangle("fill", (400*12/13)+(700*11/12),600-(550*barHeight12/3) , 700/12, 530*barHeight12/3 )
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