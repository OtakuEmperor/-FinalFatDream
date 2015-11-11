local moveableX=0
local moveableY=0
local moveableNx=0
local moveableNy=0
local moveablePx=0
local moveablePy=0
local moveableCount=false
function barrierMove_update(dt)
    if moveableCount==true then
        if moveableX<moveableNx and character.faceDir == "right" then
            barrierMove(character.Directions.Right, dt)
        elseif moveableX>moveableNx and character.faceDir == "left" then
            barrierMove(character.Directions.Left, dt)
        elseif moveableY<moveableNy and character.faceDir == "down" then
            barrierMove(character.Directions.Down, dt)
        elseif moveableY>moveableNy and character.faceDir == "up" then
            barrierMove(character.Directions.Up, dt)
        else
            moveableCount=false
        end
    end
end
function testdraw()
    love.graphics.print(moveableNx,300,300)
        love.graphics.print(moveableX,400,300)
    love.graphics.print(moveableNy,300,550)
        love.graphics.print(moveableY,400,500)
    love.graphics.print(moveablePx,500,300)
        love.graphics.print(moveablePy,500,400)
end
function moveableBarrier(barrierX,barrierY)
    if moveableCount == false then
        moveableX = barrierX
        moveableY = barrierY
            moveableNy =moveableY
            moveableNx = moveableX
            moveablePy =moveableY
            moveablePx = moveableX
    end
    if character.nx >barrierX-world.x-characterWidth and character.nx<barrierX-world.x+characterWidth and character.ny > barrierY-world.y-characterHeight and character.ny<barrierY-world.y+characterHeight and moveableCount==false then
        moveableCount=true
        if character.faceDir == "right" then
            moveablePx = moveableNx
            moveableNx=moveableX+100
        elseif character.faceDir == "left" then
            moveablePx = moveableNx
            moveableNx=moveableX-100
        elseif character.faceDir == "up" then
            moveablePy = moveableNy
            moveableNy=moveableY-100
        elseif character.faceDir == "down" then
            moveablePy = moveableNy
            moveableNy=moveableY+100
        end
        
    end
end

function barrierMove(direction, dt)
    if direction == character.animation.Directions.Down and question==false then
        if moveableY < moveableNy then
            moveableY = moveableY + character.speed*1.3 * dt
        end
        if moveableY + character.speed*1.3 * dt>moveableNy then
            moveableY = moveableNy
        end

    end

    if direction == character.animation.Directions.Left and question==false then
        if moveableX > moveableNx then
            moveableX = moveableX - character.speed *1.3* dt
        end
        if moveableX - character.speed*1.3 * dt<moveableNx then
            moveableX = moveableNx
        end


    end

    if direction == character.animation.Directions.Right  then
        if moveableX < moveableNx then
            moveableX = moveableX + character.speed*1.3 * dt
        end
        if moveableX + character.speed*1.3 * dt>moveableNx then
            moveableX = moveableNx
        end
    end

    if direction == character.animation.Directions.Up and question==false then
        if moveableY > moveableNy then
            moveableY = moveableY - character.speed*1.3 * dt
        end
        if moveableY - character.speed*1.3 * dt<moveableNy then
            moveableY = moveableNy
        end
    end

end

function getMoveableX()
    return moveableX
end
function getMoveableY()
    return moveableY
end
function getMoveablePx()
    return moveablePx
end
function getMoveablePy()
    return moveablePy
end
function getMoveableNx()
    return moveableNx
end
function getMoveableNy()
    return moveableNy
end

function changeMoveableN(a,b)
    moveableNx=a
    moveableNy=b
end
function changeMoveableCount(c)
    moveableCount=false
end
function changeMoveable(a,b)
    moveableX=a
    moveableY=b
end