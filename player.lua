local player = {}

function player.load()
	player.x = 200
	player.y = 200
	player.speed = 250
	player.angle = 0

	player.sprite = love.graphics.newImage("assets/p1.png")
end

function player.update(dt)
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

	if love.keyreleased("lshift") then
		player.speed = 500
	else
		player.speed = 250
	end

	local screenMouseX, screenMouseY = love.mouse.getPosition()

	local worldMouseX, worldMouseY = Camera:worldCoords(screenMouseX, screenMouseY)

	local dx = worldMouseX - player.x
	local dy = worldMouseY - player.y

	player.angle = math.atan2(dy, dx)
end

function player.draw()
	love.graphics.draw(player.sprite, player.x, player.y, player.angle, 1, 1, 16, 16)
end

return player
