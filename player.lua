local player = {}

function player.load()
	player.x = 200
	player.y = 200
	player.normalSpeed = 250
	player.speed = player.normalSpeed
	player.angle = 0
	player.isDashing = false
	player.dashspeed = 750
	player.dashDuration = 0.15
	player.dashTimer = 0
	player.dashCooldown = 2
	player.cooldownTimer = 0
	player.dashVx = 0
	player.dashVy = 0
	player.state = "normal"

	player.sprite = love.graphics.newImage("assets/p1.png")
end

function player.update(dt)
	
	local screenMouseX, screenMouseY = love.mouse.getPosition()
	local worldMouseX, worldMouseY = Camera:worldCoords(screenMouseX, screenMouseY)
	local dx = worldMouseX - player.x
	local dy = worldMouseY - player.y
	player.angle = math.atan2(dy, dx)

	if love.keyboard.isDown("space") then
		player.state = "attacking"
	else
		player.state = "normal"
	end

	-- Dash mechanics
	if player.cooldownTimer > 0 then
		player.cooldownTimer = player.cooldownTimer - dt
	end

	if player.isDashing then
		love.graphics.setColor(0.5, 0.5, 1)
		player.dashTimer = player.dashTimer - dt
		if player.dashTimer <= 0 then
			player.isDashing = false
			player.speed = player.normalSpeed
		end
		player.x = player.x + player.dashVx * dt
		player.y = player.y + player.dashVy * dt
	else
		if love.keyboard.isDown("w") then
			player.y = player.y - player.speed * dt
		end
		if love.keyboard.isDown("s") then
			player.y = player.y + player.speed * dt
		end
		if love.keyboard.isDown("a") then
			player.x = player.x - player.speed * dt
		end
		if love.keyboard.isDown("d") then
			player.x = player.x + player.speed * dt
		end
	end

	if love.keyboard.isDown("lshift") and not player.isDashing and player.cooldownTimer <= 0 then
		player.isDashing = true
		player.speed = player.dashspeed
		player.dashTimer = player.dashDuration
		player.cooldownTimer = player.dashCooldown

		player.dashVx = math.cos(player.angle) * player.dashspeed
		player.dashVy = math.sin(player.angle) * player.dashspeed
	end

end

function player.draw()
	if player.state == "attacking" then
		love.graphics.setColor(1, 1, 0.4, 0.7)
		love.graphics.setLineWidth(3)
		love.graphics.arc("line", "open", player.x, player.y, 40, player.angle - 0.78, player.angle + 0.78 )
		love.graphics.setColor(0.5, 1, 0.5)
	end
	love.graphics.draw(player.sprite, player.x, player.y, player.angle, 1, 1, 16, 16)

	love.graphics.setColor(1, 1, 1)
end

function player.keypressed(key)
	if key == "space" then
		player.state = "attacking"
		print("Player Event: Attack triggered")
	end
end
return player
