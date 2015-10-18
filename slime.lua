slime = {}

-- this function is for OOP
function newObject(o, class)
    class.__index = class
    return setmetatable(o, class)
end

function slime.new (originPointX,originPointY)
    local down = 1
    local up = 2
    local left = 3
    local right = 4
    local slimeAnimaLength = 4 
    local obj = {
        slimeImgFile = love.graphics.newImage("img/slime.png"),
        slimeMoveSound = love.audio.newSource("audio/slime1.ogg", "static"),
        slimeQuads = {},
        moveIndex = 1,
        animationIndex = 1,
        moveMode = {left,left,left,left,up,up,up,up,right,right,right,right,down,down,down,down},
        nowX = originPointX,
        nowY = originPointY,
        healthPoint = 10,
        timeTick = 0
    }
    for i=1,slimeAnimaLength do
        obj.slimeQuads[i] = {}
        for j=1,slimeAnimaLength do
            obj.slimeQuads[i][j] = love.graphics.newQuad( (100*j)-100, (100*i)-100, 100, 100, 400, 400)
        end
    end
    obj = newObject(obj, slime)
    return obj
end

function slime:update(dt)
    self.timeTick = self.timeTick + dt
    if self.timeTick > 0.25 then
        print(self.moveIndex)
        self.timeTick = 0
        self.animationIndex = self.animationIndex + 1
        if self.animationIndex > 4  then
            if self.moveMode[self.moveIndex] == 1 then
                self.nowY = self.nowY + 100
            end
            if self.moveMode[self.moveIndex] == 2 then
                self.nowY = self.nowY - 100
            end
            if self.moveMode[self.moveIndex] == 3 then
                self.nowX = self.nowX - 100
            end
            if self.moveMode[self.moveIndex] == 4 then
                self.nowX = self.nowX + 100
            end
            self.moveIndex = self.moveIndex + 1
            if self.moveIndex > table.getn(self.moveMode) then
                self.moveIndex = 1
                print("logging")
            end
            self.slimeMoveSound:play()
            self.animationIndex = 1
        end
    end
end
