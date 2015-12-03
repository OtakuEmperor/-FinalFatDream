function npc2_keypressed(key)
    if not npc_dialogLock  then
        if love.keyboard.isDown(" ") then
            clicksound:setVolume(getVol())
            clicksound:play()
            says_index = 3
            dialog_timer = 0
            npc_dialog_state = npc_dialog_state + 2
            npc_dialog_namestate = npc_dialog_namestate +2
        end
    end
end

function npc2_draw(dialogNum)
    love.graphics.setColor(0,0,0,150)
    love.graphics.rectangle("fill", 0,0, 1100, 614)
    love.graphics.setColor(255,255,255)
    if npc_dialog_state == (underDeskPaper_dialogLength+1) then
        conversation = false
        npc_dialogLock = true
        npc_dialog_state = 2
        npc_dialog_namestate = 1
        atk_timeout = 0
    end
   if underDeskPaper_dialog[npc_dialog_namestate] == "nil" then
        underDeskPaper_dialog[npc_dialog_namestate] = " "
    end
          print_dialog(underDeskPaper_dialog[npc_dialog_namestate],underDeskPaper_dialog[npc_dialog_state])

    --if npc_dialog_state == (npc[dialogNum].dialogLength+1) then
        --conversation = false
        --npc_dialogLock = true
      --  npc_dialog_state = 2
    --    npc_dialog_namestate = 1
  --      atk_timeout = 0
--    end
   --if npc[dialogNum].dialog[npc_dialog_namestate] == "nil" then
     --   npc[dialogNum].dialog[npc_dialog_namestate] = " "
   -- end
 --         print_dialog(npc[dialogNum].dialog[npc_dialog_namestate],npc[dialogNum].dialog[npc_dialog_state])
end
