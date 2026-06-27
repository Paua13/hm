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

	player.sprite = love.graphics.newImage("assets/p1.png")
end

function player.update(dt)
	
	local screenMouseX, screenMouseY = love.mouse.getPosition()
	local worldMouseX, worldMouseY = Camera:worldCoords(screenMouseX, screenMouseY)
	local dx = worldMouseX - player.x
	local dy = worldMouseY - player.y
	player.angle = math.atan2(dy, dx)
	-- Dash mechanics
	if player.cooldownTimer > 0 then
		player.cooldownTimer = player.cooldownTimer - dt
	end

	if player.isDashing then
		player.dashTimer = player.dashTimer - dt
		if player.dashTimer <= 0 then
			player.isDashing = false
			player.speed = player.normalSpeed
		end
		player.x = player.x + player.dashVx * dt
		player.y = player.y + player.dashVy * dt
	end

	if love.keyboard.isDown("lshift") and not player.isDahing and player.cooldownTimer <= 0 then
		player.isDashing = true
		player.speed = player.dashspeed
		player.dashTimer = player.dashDuration
		player.cooldownTimer = player.dashCooldown

		player.dashVx = math.cos(player.angle) * player.dashspeed
		player.dashVy = math.sin(player.angle) * player.dashspeed
	end

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

function player.draw()
	love.graphics.draw(player.sprite, player.x, player.y, player.angle, 1, 1, 16, 16)
end

return player
