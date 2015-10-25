function triggerLoad()
    question=false
    showKey = false
    showQ3Answer = false
    require "question1" 
    require "question2"
    require "question3"
    question1_load()
    question2_load()
    question3_load()
end

function triggerUpdate(dt)
    if showKey == false and showQ3Answer == false then
        question1_update(dt)
        question2_update(dt)
        question3_update(dt)
    end
end

function triggerKeyPress(dt)
    
    local switch = {
        ["right"] = function()    -- for case 1
            if (character.x+world.x+100)==tree.x and (character.y+world.y)== tree.y then
                question = true
                questionNum=1
            end
            if (character.x+world.x+100)==q2key.x and (character.y+world.y)== q2key.y then
                question = true
                questionNum=2
                showKey = true
            end
            if (character.x+world.x+100)==questionMark2.x and (character.y+world.y)== questionMark2.y then
                question = true
                questionNum=2
            end
            if (character.x+world.x+100)==questionMark3.x and (character.y+world.y)== questionMark3.y then
                question = true
                questionNum=3
            end
            if (character.x+world.x+100)==q3key.x and (character.y+world.y)== q3key.y then
                question = true
                questionNum=3
                showQ3Answer = true
            end
        end,
        ["left"] = function()    -- for case 2
            if (character.x+world.x-100)==tree.x and (character.y+world.y)== tree.y then
                question = true
                questionNum=1
            end
            if (character.x+world.x-100)==q2key.x and (character.y+world.y)== q2key.y then
                question = true
                questionNum=2
                showKey = true
            end
            if (character.x+world.x-100)==questionMark2.x and (character.y+world.y)== questionMark2.y then
                question = true
                questionNum=2
            end
            if (character.x+world.x-100)==q3key.x and (character.y+world.y)== q3key.y then
                question = true
                questionNum=3
                showQ3Answer = true
            end
            if (character.x+world.x-100)==questionMark3.x and (character.y+world.y)== questionMark3.y then
                question = true
                questionNum=3
            end
        end,
        ["down"] = function()    -- for case 3
            if (character.x+world.x)==tree.x and (character.y+world.y+100)== tree.y then
                question = true
                questionNum=1
            end
            if (character.x+world.x)==q2key.x and (character.y+world.y+100)== q2key.y then
                question = true
                questionNum=2
                showKey = true
            end
            if (character.x+world.x)==questionMark2.x and (character.y+world.y+100)== questionMark2.y then
                question = true
                questionNum=2
            end
            if (character.x+world.x)==q3key.x and (character.y+world.y+100)== q3key.y then
                question = true
                questionNum=3
                showQ3Answer = true
            end
            if (character.x+world.x)==questionMark3.x and (character.y+world.y+100)== questionMark3.y then
                question = true
                questionNum=3
            end
        end,
        ["up"] = function()    -- for case 4
            if (character.x+world.x)==tree.x and (character.y+world.y-100)== tree.y then
                question = true
                questionNum=1
            end
            if (character.x+world.x)==q2key.x and (character.y+world.y-100)== q2key.y then
                question = true
                questionNum=2
                showKey = true
            end
            if (character.x+world.x)==questionMark2.x and (character.y+world.y-100)== questionMark2.y then
                question = true
                questionNum=2
            end
            if (character.x+world.x)==q3key.x and (character.y+world.y-100)== q3key.y then
                question = true
                questionNum=3
                showQ3Answer = true
            end
            if (character.x+world.x)==questionMark3.x and (character.y+world.y-100)== questionMark3.y then
                question = true
                questionNum=3
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
        question = false
        showKey = false
        showQ3Answer = false
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
end