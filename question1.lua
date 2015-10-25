function question1_load()
    questionImage = love.graphics.newImage("img/question1.jpg")
    imageWidth=661
    imageHeight=419
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
    if blockNum1 == 1 and blockNum2 == 2 then
        if blockNum3 == 3 and blockNum4 == 4 then
            question=false
            blockNum1=0
            blockNum2=0
            blockNum3=0
            blockNum4=0
            block1=true
            block2=false
            block3=false
            block4=false
        end
    end
end

function question1_draw()
    love.graphics.setColor(255,255,255)
    love.graphics.rectangle("fill", 0, 307, 1100, 307 )
    love.graphics.draw(questionImage, 0, 0,0,1100/imageWidth,307/imageHeight )
    if block1 == true then
        love.graphics.setColor(255,0,0)
    else
        love.graphics.setColor(0,0,0)
    end
    love.graphics.rectangle("line", 200, 400, 100, 100 )
    if block2 == true then
        love.graphics.setColor(255,0,0)
    else
        love.graphics.setColor(0,0,0)
    end
    love.graphics.rectangle("line", 400, 400, 100, 100 )
    if block3 == true then
        love.graphics.setColor(255,0,0)
    else
        love.graphics.setColor(0,0,0)
    end
    love.graphics.rectangle("line", 600, 400, 100, 100 )
    if block4 == true then
        love.graphics.setColor(255,0,0)
    else
        love.graphics.setColor(0,0,0)
    end
     love.graphics.rectangle("line", 800, 400, 100, 100 )
    love.graphics.setColor(0,0,0)
    love.graphics.setFont(love.graphics.newFont(100))
    love.graphics.print(blockNum1, 220, 393)
    love.graphics.print(blockNum2, 420, 393)
    love.graphics.print(blockNum3, 620, 393)
    love.graphics.print(blockNum4, 820, 393)
    
end