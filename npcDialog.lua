function npcDialog_load()
    npc_dialogLock = true
    npc_dialog_state = 2
    npc_dialog_namestate = 1
end

function npc_keypressed(key)
    if not npc_dialogLock  then
        if love.keyboard.isDown(" ") then
            clicksound:play()
            npc_dialog_state = npc_dialog_state + 2
            npc_dialog_namestate = npc_dialog_namestate +2
        end
    end
end

function npc_draw(dialogNum)
    love.graphics.setColor(0,0,0,150)
    love.graphics.rectangle("fill", 0,0, 1100, 614)    
    love.graphics.setColor(255,255,255)
    if npc_dialog_state == (npc[dialogNum].dialogLength+1) then
        conversation = false
        npc_dialogLock = true
        npc_dialog_state = 2
        npc_dialog_namestate = 1
    end
   if npc[dialogNum].dialog[npc_dialog_namestate] == "nil" then
        npc[dialogNum].dialog[npc_dialog_namestate] = " "
    end
          print_dialog(npc[dialogNum].dialog[npc_dialog_namestate],npc[dialogNum].dialog[npc_dialog_state])
    -- dialog
    --if not (isempty(npc[dialogNum].dialog[2])) then
      --  if (isempty(npc[dialogNum].dialog[1])) then
        --    print_dialog("", npc[dialogNum].dialog[npc_dialog_state+1])
        --else
          --  print_dialog(dialog_element[], dialog_element[npc_dialog_state+1])
        --end
    --end
end