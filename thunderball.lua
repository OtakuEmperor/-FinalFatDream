thunderball = {}

-- this function is for OOP
function newObject(o, class)
    class.__index = class
    return setmetatable(o, class)
end

function thunderball.new (x, y)
    local obj = {
        thunderball_x = x,
        thunderball_y = y,
        thunderball_img = love.graphics.newImage("img/thunderBall.png"),
        thunderball_quads = {},
        thunderball_index = 1,
        thunderball_timer = 0,
        thunder_ball_cool_down = 1,
        thunderball_dmg_taken = false,
        thunderball_end = false,
        isThunderBallAttack = false,
        thunderball_dmg = 5
    }

    for i=1, 10 do
        obj.thunderball_quads[i] = love.graphics.newQuad(0, 0, 100, 100, 500, 100)
    end
    for i=11, 14 do
        obj.thunderball_quads[i] = love.graphics.newQuad(100*(i-10), 0, 100, 100, 500, 100)
    end

    obj = newObject(obj, thunderball)
    return obj
end

function thunderball:update(dt, charX, charY)
    self.thunder_ball_cool_down = self.thunder_ball_cool_down + dt
    self.thunderball_timer = self.thunderball_timer + dt
    if self.isThunderBallAttack then
    if self.thunderball_timer > 0.05 then
        self.thunderball_timer = 0
        self.thunderball_index = self.thunderball_index + 1
        if self.thunderball_index >= 11 and not self.thunderballdmg_taken then
            if charX == self.thunderball_x and charY == self.thunderball_y and not self.thunderball_dmg_taken then
                hpDecline(self.thunderball_dmg)
                self.thunderball_dmg_taken = true
            end
        end
    end
    if self.thunderball_index > 14 then
        self.isThunderBallAttack = false
        self.thunderball_dmg_taken = false
        self.thunderball_index = 1
    end
    end
end

function thunderball:draw()
    thunderballBGM:setVolume(getVol())
    thunderballBGM:play()
    love.graphics.draw(self.thunderball_img, self.thunderball_quads[self.thunderball_index], self.thunderball_x-world.x, self.thunderball_y-world.y)
end