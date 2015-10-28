menu = {}

function menu_load()
  --get width and height of windows
  width = love.graphics.getWidth()
  height = love.graphics.getHeight()
  --load img
  sexy = love.graphics.newImage("img/sexy.png")
  --load audio
  piano = love.audio.newSource("audio/piano.wav", "static")
  --set audio switch
  isOn1 = false
  isOn2 = false
  isOn3 = false
  --set text
  size = 48
  font = love.graphics.newFont("font/NotoSansMonoCJKtc-Regular.otf", size)
  --set otaku workshop
  size2 = 16
end

function menu_draw()
  love.graphics.setBackgroundColor(255, 255, 255)
  --set text font
  love.graphics.setFont(font)
  --get mouse position
  local x, y = love.mouse.getPosition()
  --set volume
  piano:setVolume(0.5)

  --draw FPS
  love.graphics.print(tostring(love.timer.getFPS()), 5, 5)
  --draw sexy
  love.graphics.setColor(255, 255, 255, 255)
  love.graphics.draw(sexy, width/2 - 203, 20)
  --draw start
  if x > width/4 and x < (width/4 + width/2) and y > height/2 and y <(height/2 + size*(5/4)) then
    love.graphics.setColor(255, 255, 255)
    love.graphics.rectangle("fill", width / 4, height / 2, width / 2, size * (5/4))
    love.graphics.setColor(255, 68, 170, 255)
    love.graphics.print("開 始 遊 戲", width / 4, height / 2)
    if isOn1 == false then
      piano:play()
      isOn1 = true
    end
  else
    love.graphics.setColor(255, 68, 170, 255)
    love.graphics.rectangle("fill", width / 4, height / 2, width / 2, size * (5/4))
    love.graphics.setColor(255, 255, 255)
    love.graphics.print("開 始 遊 戲", width / 4, height / 2)
    isOn1 = false
  end
  --draw continue
  if x > width/4 and x < (width/4 + width/2) and y > (height/2 + size*2) and y < (height/2 + size * (13/4)) then
    love.graphics.setColor(255, 255, 255)
    love.graphics.rectangle("fill", width / 4, height / 2 + size * 2, width / 2, size * (5/4))
    love.graphics.setColor(255, 68, 170, 255)
    love.graphics.print("繼 續 遊 戲", width / 4, height / 2 + size * 2)
    if isOn2 == false then
      piano:play()
      isOn2 = true
    end
  else
    love.graphics.setColor(255, 68, 170, 255)
    love.graphics.rectangle("fill", width / 4, height / 2 + size * 2, width / 2, size * (5/4))
    love.graphics.setColor(255, 255, 255)
    love.graphics.print("繼 續 遊 戲", width / 4, height / 2 + size * 2)
    isOn2 = false
  end
  --draw option
  if x > width/4 and x < (width/4 + width/2) and y > (height/2 + size*4) and y < (height/2 + size * (21/4)) then
    love.graphics.setColor(255, 255, 255)
    love.graphics.rectangle("fill", width / 4, height / 2 + size * 4, width / 2, size * (5/4))
    love.graphics.setColor(255, 68, 170, 255)
    love.graphics.print("遊 戲 選 項", width / 4, height / 2 + size * 4)
    if isOn3 == false then
      piano:play()
      isOn3 = true
    end
  else
    love.graphics.setColor(255, 68, 170, 255)
    love.graphics.rectangle("fill", width / 4, height / 2 + size * 4, width / 2, size * (5/4))
    love.graphics.setColor(255, 255, 255)
    love.graphics.print("遊 戲 選 項", width / 4, height / 2 + size * 4)
    isOn3 = false
  end
  --draw otaku workshop
  love.graphics.setColor(0, 0, 0)
  love.graphics.setFont(love.graphics.newFont("font/NotoSansMonoCJKtc-Regular.otf", size2))
  love.graphics.print("Otaku Workshop®2015", width - size2 * 10, height - size2 * (5/4))
end
