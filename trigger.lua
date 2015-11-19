local dialogNum=0
function triggerLoad()
    question=false
    showKey = false
    showQ3Answer = false
    conversation = false
    require "question1" 
    require "question2"
    require "question3"
    require "npcDialog"
    question1_load()
    question2_load()
    question3_load()
    npcDialog_load()
    sloveProblem = love.audio.newSource("audio/sloveProblem.ogg", "static")
end

function triggerUpdate(dt)
    if showKey == false and showQ3Answer == false then
        question1_update(dt)
        question2_update(dt)
        question3_update(dt)
    end
end

function triggerKeyPress(key)
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
    if love.keyboard.isDown("f") then
        --switch(character.faceDir)
        local face = switch[character.faceDir]
        if(face) then
            face()
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
            end
        }
        local questionN = switchQuestion[questionNum]
        if(questionN) then
            questionN()
        end
    end
    if conversation == true then
        npc_draw(dialogNum)
    end
end
