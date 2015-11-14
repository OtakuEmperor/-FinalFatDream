function npcDialog_load()
    npc_dialogLock = true
    npc_dialog_state = 1
end

function npc_keypressed(key)
    if not npc_dialogLock  then
        if love.keyboard.isDown(" ") then
            clicksound:play()
            npc_dialog_state = npc_dialog_state + 1
        end
    end
end

function npc_draw(dialogNum)
    local switchDialog = {
            [1] = function()
                love.graphics.setColor(0,0,0,150)
                love.graphics.rectangle("fill", 0,0, 1100, 614)    
                love.graphics.setColor(255,255,255)    
            if npc_dialog_state == 1 then
            print_dialog("", "oe小雞雞")
        elseif npc_dialog_state == 3 then
            conversation = false
            npc_dialogLock = true
            npc_dialog_state=1
        end
            end,
            [2] = function()
                love.graphics.setColor(0,0,0,150)
                love.graphics.rectangle("fill", 0,0, 1100, 614)    
            love.graphics.setColor(255,255,255)    
            if npc_dialog_state == 1 then
            print_dialog("", "恩......")
        elseif npc_dialog_state == 3 then
            conversation = false
            npc_dialogLock = true
            npc_dialog_state=1
        end
            end,
            [3] = function()
                love.graphics.setColor(0,0,0,150)
                love.graphics.rectangle("fill", 0,0, 1100, 614)    
            love.graphics.setColor(255,255,255)    
            if npc_dialog_state == 1 then
            print_dialog("", "恩......")
        elseif npc_dialog_state == 3 then
            conversation = false
            npc_dialogLock = true
            npc_dialog_state=1
        end
            end,
            [4] = function()
                love.graphics.setColor(0,0,0,150)
                love.graphics.rectangle("fill", 0,0, 1100, 614)    
            love.graphics.setColor(255,255,255)    
            if npc_dialog_state == 1 then
            print_dialog("", "恩......")
        elseif npc_dialog_state == 3 then
            conversation = false
            npc_dialogLock = true
            npc_dialog_state=1
        end
            end,
            [5] = function()
                love.graphics.setColor(0,0,0,150)
                love.graphics.rectangle("fill", 0,0, 1100, 614)    
            love.graphics.setColor(255,255,255)    
            if npc_dialog_state == 1 then
            print_dialog("", "恩......")
        elseif npc_dialog_state == 3 then
            conversation = false
            npc_dialogLock = true
            npc_dialog_state=1
        end
            end
        }
    local dialogN = switchDialog[dialogNum]
        if(dialogN) then
            dialogN()
        end
end