interface = {}

function interface_load()
  --set water and weapon img
  waterImg = "water.png"
  weaponImg = "weapon.png"
  --load img
  key = love.graphics.newImage("img/key.png") --32px
  water = love.graphics.newImage("img/"..waterImg) --32px
  weapon = love.graphics.newImage("img/"..weaponImg) --32px
  arrow = love.graphics.newImage("img/arrow.png") --32px
  --get width and height of windows
  width = love.graphics.getWidth()
  height = love.graphics.getHeight()
  --set days
  days = 1
  --set day(true) or night(false)
  dn = true
  --set wake
  wake = 99.9
  --set key number
  keyNum = 1
end

function interface_draw()
  love.graphics.setBackgroundColor(255, 255, 255)
  --draw wake
  love.graphics.setFont(love.graphics.newFont(36))
  love.graphics.setColor(255, 0, 0)
  love.graphics.print(wake, width * (1/20), height * (1/20))
  --draw key
  if keyNum == 1 then
    love.graphics.draw(key, width * (9/200), height * (1/8))
  elseif keyNum == 2 then
    love.graphics.draw(key, width * (9/200), height * (1/8))
    love.graphics.draw(key, width * (9/200) + 32, height * (1/8))
  elseif keyNum == 3 then
    love.graphics.draw(key, width * (9/200), height * (1/8))
    love.graphics.draw(key, width * (9/200) + 32, height * (1/8))
    love.graphics.draw(key, width * (9/200) + 64, height * (1/8))
  end
  --draw water
  love.graphics.setColor(0, 0, 0, 127)--set opacity50
  love.graphics.draw(water, width * (4/20), height * (1/20))
  --draw weapon
  love.graphics.setColor(0, 0, 0, 127)--set opacity50
  love.graphics.draw(weapon, width * (4/20), height * (1/8))
  --[[
  --draw conversation block
  love.graphics.setColor(255, 183, 221, 127)
  love.graphics.rectangle("fill", width * (1/10), height * (2/3), width * (4/5), height * (1/4))
  love.graphics.setColor(0, 0, 0, 255)
  love.graphics.draw(arrow, width * (9/10) - 32, height * (11/12) - 32)
  --]]
  --draw days
  if dn == true then
    love.graphics.setColor(0, 128, 255)
  elseif dn == false then
    love.graphics.setColor(0, 0, 0)
  end
  love.graphics.circle("fill", width, 0, 70)
  love.graphics.setFont(love.graphics.newFont(36))
  love.graphics.setColor(255, 255, 255)
  love.graphics.print("D" .. keyNum, width - 54, 0)
end
