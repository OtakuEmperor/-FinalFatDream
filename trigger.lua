local dialogNum=0
function triggerLoad()
    question=false
    showKey = false
    showQ3Answer = false
    conversation = false
    require "question1" 
    require "question2"
    require "question3"
    require "question4"
    require "npcDialog"
    require "npcDialog2"
    question1_load()
    question2_load()
    question3_load()
    question4_load()
    npcDialog_load()
    sloveProblem = love.audio.newSource("audio/sloveProblem.ogg", "static")
end

function triggerUpdate(dt)
    if showKey == false and showQ3Answer == false then
        question1_update(dt)
        question2_update(dt)
        question3_update(dt)
        question4_update(dt)
    end
end

function triggerKeyPress(key)
-----------------day1 trigger------------------------------------------
    local switch = {
        ["right"] = function()    -- for case 1
            for i=1,5 do
                if (character.x+world.x+100)==npc[i].x and (character.y+world.y)== npc[i].y then
                    conversation = true
                    dialogNum=i
                    npc_dialogLock = false
                    love_newDialog()
                end
            end
            for i=1,3 do
                if (character.x+world.x+100)==questionMark[i].x and (character.y+world.y)== questionMark[i].y and questionMark[i].isSolved == false then
                    question = true
                    questionNum=i
                    if i == 1 then
                        q1_dialogLock = false
                    elseif i == 2 then
                        q2_dialogLockLine = false
                    end
                    love_newDialog()
                end
            end
            if (character.x+world.x+100)==q2key.x and (character.y+world.y)== q2key.y then
                question = true
                questionNum=2
                showKey = true
                q2_dialogLockKey = false
                love_newDialog()
            end
            if (character.x+world.x+100)==q3key.x and (character.y+world.y)== q3key.y then
                question = true
                questionNum=3
                showQ3Answer = true
                q3_dialogLock = false
                love_newDialog()
            end
        end,
        ["left"] = function()    -- for case 2
            for i=1,5 do
                if (character.x+world.x-100)==npc[i].x and (character.y+world.y)== npc[i].y then
                    conversation = true
                    dialogNum=i
                    npc_dialogLock = false
                    love_newDialog()
                end
            end
            for i=1,3 do
                if (character.x+world.x-100)==questionMark[i].x and (character.y+world.y)== questionMark[i].y and questionMark[i].isSolved == false then
                    question = true
                    questionNum=i
                    if i == 1 then
                        q1_dialogLock = false
                    elseif i == 2 then
                        q2_dialogLockLine = false
                    end
                    love_newDialog()
                end
            end
            if (character.x+world.x-100)==q2key.x and (character.y+world.y)== q2key.y then
                question = true
                questionNum=2
                showKey = true
                q2_dialogLockKey = false
                love_newDialog()
            end
            
            if (character.x+world.x-100)==q3key.x and (character.y+world.y)== q3key.y then
                question = true
                questionNum=3
                showQ3Answer = true
                q3_dialogLock = false
                love_newDialog()
            end

        end,
        ["down"] = function()    -- for case 3
            for i=1,5 do
                if (character.x+world.x)==npc[i].x and (character.y+world.y+100)== npc[i].y then
                    conversation = true
                    dialogNum=i
                    npc_dialogLock = false
                    love_newDialog()
                end
            end
            for i=1,3 do
                if (character.x+world.x)==questionMark[i].x and (character.y+world.y+100)== questionMark[i].y and questionMark[i].isSolved == false then
                    question = true
                    questionNum=i
                    if i == 1 then
                        q1_dialogLock = false
                    elseif i == 2 then
                        q2_dialogLockLine = false
                    end
                    love_newDialog()
                end
            end
            if (character.x+world.x)==q2key.x and (character.y+world.y+100)== q2key.y then
                question = true
                questionNum=2
                showKey = true
                q2_dialogLockKey = false
                love_newDialog()
            end
            
            if (character.x+world.x)==q3key.x and (character.y+world.y+100)== q3key.y then
                question = true
                questionNum=3
                showQ3Answer = true
                q3_dialogLock = false
                love_newDialog()
            end
            
        end,
        ["up"] = function()    -- for case 4
            for i=1,5 do
                if (character.x+world.x)==npc[i].x and (character.y+world.y-100)== npc[i].y then
                    conversation = true
                    dialogNum=i
                    npc_dialogLock = false
                    love_newDialog()
                end
            end
            for i=1,3 do
                if (character.x+world.x)==questionMark[i].x and (character.y+world.y-100)== questionMark[i].y and questionMark[i].isSolved == false then
                    question = true
                    questionNum=i
                    if i == 1 then
                        q1_dialogLock = false
                    elseif i == 2 then
                        q2_dialogLockLine = false
                    end
                    love_newDialog()
                end
            end
            if (character.x+world.x)==q2key.x and (character.y+world.y-100)== q2key.y then
                question = true
                questionNum=2
                showKey = true
                q2_dialogLockKey = false
                love_newDialog()
            end
            if (character.x+world.x)==q3key.x and (character.y+world.y-100)== q3key.y then
                question = true
                questionNum=3
                showQ3Answer = true
                q3_dialogLock = false
                love_newDialog()
            end
        end
    }
------------day2 trigger---------------------------------------
    local counter
    local switch2 = {
        ["right"] = function()    -- for case 1
            counter = 1
            for i = 100, 1100, 200 do
                for j = 500, 1100, 200 do
                    counter = counter + 1
                end
                for j = 2000, 2600, 200 do
                    if (character.x+world.x+100)==deskChair[counter].x and (character.y+world.y)== deskChair[counter].y and deskChair[counter].isSolve == false then
                        question = true
                        questionNum=4
                        showKey = true
                        q4_dialogLockKey = false
                        love_newDialog()
                    end
                    counter = counter + 1
                end
            end
            if (character.x+100)==500-world.x and character.y== 1100-world.y then
                if deskChair[20].x ~= 500 or deskChair[20].y ~= 1100 then
                    conversation = true
                    dialogNum=1
                    npc_dialogLock = false
                    love_newDialog()
                end
            end
        end,
        ["left"] = function()    -- for case 2
            counter = 1
            for i = 100, 1100, 200 do
                for j = 500, 1100, 200 do
                    counter = counter + 1
                end
                for j = 2000, 2600, 200 do
                    if (character.x+world.x-100)==deskChair[counter].x and (character.y+world.y)== deskChair[counter].y and deskChair[counter].isSolve == false then
                        question = true
                        questionNum=4
                        showKey = true
                        q4_dialogLockKey = false
                        love_newDialog()
                    end
                    counter = counter + 1
                end
            end
            if (character.x-100)==500-world.x and character.y== 1100-world.y then
                if deskChair[20].x ~= 500 or deskChair[20].y ~= 1100 then
                    conversation = true
                    dialogNum=1
                    npc_dialogLock = false
                    love_newDialog()
                end
            end
        end,
        ["down"] = function()    -- for case 3
            counter = 1
            for i = 100, 1100, 200 do
                for j = 500, 1100, 200 do
                    counter = counter + 1
                end
                for j = 2000, 2600, 200 do
                    if (character.x+world.x)==deskChair[counter].x and (character.y+world.y+100)== deskChair[counter].y and deskChair[counter].isSolve == false then
                        question = true
                        questionNum=4
                        showKey = true
                        q4_dialogLockKey = false
                        love_newDialog()
                    end
                    counter = counter + 1
                end
            end
            if (character.x)==500-world.x and character.y+100== 1100-world.y then
                if deskChair[20].x ~= 500 or deskChair[20].y ~= 1100 then
                    conversation = true
                    dialogNum=1
                    npc_dialogLock = false
                    love_newDialog()
                end
            end
        end,
        ["up"] = function()    -- for case 4
            for i=1,5 do
            --    if (character.x+world.x)==npc[i].x and (character.y+world.y-100)== npc[i].y then
              --      conversation = true
                --    dialogNum=i
                  --  npc_dialogLock = false
                --    love_newDialog()
                --end
            end
            counter = 1
            for i = 100, 1100, 200 do
                for j = 500, 1100, 200 do
                    counter = counter + 1
                end
                for j = 2000, 2600, 200 do
                    if (character.x+world.x)==deskChair[counter].x and (character.y+world.y-100)== deskChair[counter].y and deskChair[counter].isSolve == false then
                        question = true
                        questionNum=4
                        showKey = true
                        q4_dialogLockKey = false
                        love_newDialog()
                    end
                    counter = counter + 1
                end
            end
            for i=20,28 do
                if (character.x+world.x)==lightWall[i].x and (character.y+world.y-100)== lightWall[i].y and lightWall[i].isSolve == false then
                    question = true
                    questionNum=4
                    --q4_dialogLockLine = false
                    --love_newDialog()
                end
            end
            if character.x==500-world.x and character.y-100== 1100-world.y then
                if deskChair[20].x ~= 500 or deskChair[20].y ~= 1100 then
                    conversation = true
                    dialogNum=1
                    npc_dialogLock = false
                    love_newDialog()
                end
            end
        end
    }
------------------------------------------------------------------------------
    if love.keyboard.isDown("f") then
        local switchDayT = {
            [1] = function()    -- for case 1
                --switch(character.faceDir)
                local face = switch[character.faceDir]
                if(face) then
                    face()
                end
            end,
            [2] = function()    -- for case 2
                local face2 = switch2[character.faceDir]
                if(face2) then
                    face2()
                end
                if character.x==500-world.x and character.y== 1100-world.y then
                    conversation = true
                    dialogNum=1
                    npc_dialogLock = false
                    love_newDialog()
                end
            end,
            [3] = function()    -- for case 3
                local face3 = switch3[character.faceDir]
                if(face3) then
                    face3()
                end
            end,
            [4] = function()    -- for case 4
                local face4 = switch4[character.faceDir]
                if(face4) then
                    face4()
                end
            end,
            [5] = function()
                local face5 = switch5[character.faceDir]
                if(face5) then
                    face5()
                end
            end
        }
        local selectDayT= switchDayT[day_state]
            if(selectDayT) then
                selectDayT()
            end
    elseif love.keyboard.isDown("escape") then
        q1_dialog_state = 1
        q2_dialog_stateKey = 1
        q2_dialog_stateLine = 1
        q3_dialog_state = 1
        q1_dialogLock = true
        q2_dialogLockKey = true
        q2_dialogLockLine = true
        q3_dialogLock = true
        npc_dialogLock = true
        question = false
        showKey = false
        showQ3Answer = false
        conversation = false
    end

end

function triggerDraw()
    if question == true then
        local switchQuestion = {
            [1] = function()
                question1_draw()
            end,
            [2] = function()
                question2_draw()
            end,
            [3] = function()
                question3_draw()
            end,
            [4] = function()
                question4_draw()
            end
        }
        local questionN = switchQuestion[questionNum]
        if(questionN) then
            questionN()
        end
    end
    if conversation == true then
        local switchCon = {
            [1] = function()    -- for case 1
                npc_draw(dialogNum)
            end,
            [2] = function()    -- for case 2
                npc2_draw(dialogNum)
            end,
            [3] = function()    -- for case 3
                --npc3_draw(dialogNum)
            end,
            [4] = function()    -- for case 4
               -- npc4_draw(dialogNum)
            end,
            [5] = function()
               -- npc5_draw(dialogNum)
            end
        }
        local selectCon= switchCon[day_state]
        if(selectCon) then
            selectCon()
        end
    end
end
