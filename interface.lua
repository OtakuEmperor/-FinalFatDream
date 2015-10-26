interface = {}

function interface_load()
  --set water and weapon img
  interface.waterImg = "water.png"
  interface.weaponImg = "weapon.png"
  --load img
  interface.key = love.graphics.newImage("img/key.png") --32px
  interface.water = love.graphics.newImage("img/"..interface.waterImg) --32px
  interface.weapon = love.graphics.newImage("img/"..interface.weaponImg) --32px
  interface.arrow = love.graphics.newImage("img/arrow.png") --32px
  --get width and height of windows
  interface.width = love.graphics.getWidth()
  interface.height = love.graphics.getHeight()
  --set days
  interface.days = 1
  --set day(true) or night(false)
  interface.dn = true
  --set wake
  wake = 99.9
  --set key number
  interface.keyNum = 1
end

function interface_draw()
  love.graphics.setBackgroundColor(255, 255, 255)
  --draw wake
  love.graphics.setFont(love.graphics.newFont(36))
  love.graphics.setColor(255, 0, 0)
  love.graphics.print(wake, interface.width * (1/20), interface.height * (1/20))
  --draw key
  if interface.keyNum == 1 then
    love.graphics.draw(interface.key, interface.width * (9/200), interface.height * (1/8))
  elseif interface.keyNum == 2 then
    love.graphics.draw(interface.key, interface.width * (9/200), interface.height * (1/8))
    love.graphics.draw(interface.key, interface.width * (9/200) + 32, interface.height * (1/8))
  elseif interface.keyNum == 3 then
    love.graphics.draw(interface.key, interface.width * (9/200), interface.height * (1/8))
    love.graphics.draw(interface.key, interface.width * (9/200) + 32, interface.height * (1/8))
    love.graphics.draw(interface.key, interface.width * (9/200) + 64, interface.height * (1/8))
  end
  --draw water
  love.graphics.setColor(0, 0, 0, 127)--set opacity50
  love.graphics.draw(interface.water, interface.width * (4/20), interface.height * (1/20))
  --draw weapon
  love.graphics.setColor(0, 0, 0, 127)--set opacity50
  love.graphics.draw(interface.weapon, interface.width * (4/20), interface.height * (1/8))
  --[[
  --draw conversation block
  love.graphics.setColor(255, 183, 221, 127)
  love.graphics.rectangle("fill", interface.width * (1/10), interface.height * (2/3), interface.width * (4/5), height * (1/4))
  love.graphics.setColor(0, 0, 0, 255)
  love.graphics.draw(interface.arrow, interface.width * (9/10) - 32, interface.height * (11/12) - 32)
  --]]
  --draw days
  if interface.dn == true then
    love.graphics.setColor(0, 128, 255)
  elseif interface.dn == false then
    love.graphics.setColor(0, 0, 0)
  end
  love.graphics.circle("fill", interface.width, 0, 70)
  love.graphics.setFont(love.graphics.newFont(36))
  love.graphics.setColor(255, 255, 255)
  love.graphics.print("D" .. interface.days, interface.width - 54, 0)
end
