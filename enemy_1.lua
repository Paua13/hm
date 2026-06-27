local enemy = {}
enemy.list = {}

function enemy.spawn(x, y)
    local e = {
        x = x,
        y = y,
        baseSpeed = 200,
        currentSpeed = 200,
        angle = 0,
        state = "patrol",
        patrolRadius = 100,
        startX = x,
        sprite = love.graphics.newImage("assets/e1.png")
    }
    table.insert(enemy.list, e)
end

function enemy.load()
    enemy.spawn(400, 300)
    enemy.spawn(600, 400)
end

function enemy.update(dt, playerX, playerY)
    for _, e in ipairs(enemy.list) do
        local dx = playerX - e.x
        local dy = playerY - e.y
        local distance = math.sqrt(dx^2 + dy^2)

        if distance < 250 then
            e.state = "chase"
        elseif distance > 400 then
            e.state = "patrol"
        end

        if e.state == "chase" then
            e.angle = math.atan2(dy, dx)
            e.x = e.x + math.cos(e.angle) * e.baseSpeed * dt
            e.y = e.y + math.sin(e.angle) * e.baseSpeed * dt
        
        elseif e.state == "patrol" then
            if math.abs(e.x - e.startX) > e.patrolRadius then
                e.currentSpeed = -e.currentSpeed
            end
            e.x = e.x + e.currentSpeed * dt
            e.angle = e.currentSpeed > 0 and 0 or math.pi
        end
    end
end

function enemy.tryMeleeAttack(px, py, pAngle)
    local attackRange = 50
    local maxAttackAngle = 1.0

    for i = #enemy.list, 1, -1 do
        local e = enemy.list[i]
        local dx = e.x - px
        local dy = e.y - py
        local distance = math.sqrt(dx^2, dy^2)
        if distance <= attackRange then
            local angleToEnemy = math.atan2(dy, dx)
            local angleDiff = math.abs(pAngle - angleToEnemy)
            if angleDiff > math.pi then
                angleDiff = (math.pi * 2) - angleDiff
            end
            if angleDiff <= maxAttackAngle then
                table.remove(enemy.list, i)
                print("Melee Kill Registered!")
            end
        end
    end
end

function enemy.checkPlayerDamage(px, py)
    for _, e in ipairs(enemy.list) do
        local distance = math.sqrt((px - e.x)^2 + (py - e.y)^2)
        if distance < 18 then
            print("Player Dead")
        end
    end
end

function enemy.draw()
    for _, e in ipairs(enemy.list) do
        love.graphics.setColor(1, 0.3, 0.3)
        love.graphics.draw(e.sprite, e.x, e.y, e.angle, 1, 1, 16, 16)
    end
    love.graphics.setColor(1, 1, 1)
end 

return enemy