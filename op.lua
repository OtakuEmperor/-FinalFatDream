op = {}

function op_load()
  --get width and height of windows
  width = love.graphics.getWidth()
  height = love.graphics.getHeight()
  --set start time
  t0 = love.timer.getTime()
  --load img
  logo = love.graphics.newImage("img/logo.png") --512px
  --set time range of logo
  logoRange1 = 2 --fade-in or fade-out time
  logoRange2 = 2 --stop time
  logoTotalRange = logoRange1 * 2 + logoRange2
  --set text
  text = "癢臭肥宅工作室"
  size = 72
  font = love.graphics.newFont("font/NotoSansCJKtc-Black.otf", size)
  --set time range of text
  textRange1 = 2
  textRange2 = 2
  --load audio
  guileTheme = love.audio.newSource("audio/GuileTheme.mp3")
  guileTheme:setVolume(0)
end

function op_update(dt)
  --set dynamic time
  t = love.timer.getTime()
end

function op_draw()
  love.graphics.setBackgroundColor(255, 255, 255)
  --draw logo
  if (t - t0) < logoRange1 then --fade in
    love.graphics.setColor(255, 255, 255, 255 * (t - t0) / logoRange1)
    love.graphics.draw(logo, width / 2 - 256, height / 2 - 256)
    guileTheme:play()
  elseif (t - t0) == logoRange1 or (t - t0) > logoRange1 and (t - t0) < (logoRange1 + logoRange2) then --stop
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.draw(logo, width / 2 - 256, height / 2 - 256)
  elseif (t - t0) > (logoRange1 + logoRange2) and (t - t0) < (logoRange1 * 2 + logoRange2) then --fade out
    love.graphics.setColor(255, 255, 255,255 - 255 * (t - t0 - logoRange1 - logoRange2) / logoRange1)
    love.graphics.draw(logo, width / 2 - 256, height / 2 - 256)
  end
  --draw text
  if (t - t0) > logoTotalRange and (t - t0) < (logoTotalRange + textRange1) then
    love.graphics.setColor(0, 0, 0, 255 * (t - t0 - logoTotalRange) / textRange1)
    love.graphics.setFont(font)
    love.graphics.print(text, width / 2 - font:getWidth(text) / 2, height / 2 - size)
  elseif (t - t0) == (logoTotalRange + textRange1) or (t - t0) > (logoTotalRange + textRange1) and (t - t0) < (logoTotalRange + textRange1 + textRange2) then
    love.graphics.setColor(0, 0, 0, 255)
    love.graphics.setFont(font)
    love.graphics.print(text, width / 2 - font:getWidth(text) / 2, height / 2 - size)
  elseif (t - t0) > (logoTotalRange + textRange1 + textRange2) and (t - t0) < (logoTotalRange + textRange1 * 2 + textRange2) then
    love.graphics.setColor(0, 0, 0,255 - 255 * (t - t0 - logoTotalRange - textRange1 - textRange2) / textRange1)
    love.graphics.setFont(font)
    love.graphics.print(text, width / 2 - font:getWidth(text) / 2, height / 2 - size)
  end
  --porn
  --if love.mouse.isDown("l") then
  --love.graphics.setColor(255, 255, 255, 255)
  --love.graphics.draw(love.graphics.newImage("img/porn.png"), love.mouse.getX(), love.mouse.getY(), 0, 0.5 ,0.5)
  --end
  if (t - t0) > (logoRange1*2 + logoRange2 + textRange1*2 + textRange2) then
     gameStage = 1
  end
end
