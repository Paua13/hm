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

	local mouseX, mouseY = love.mouse.getPosition()

	player.angle = math.atan2(mouseY - player.y, mouseX - player.x)
end

function player.draw()
	love.graphics.draw(player.sprite, player.x, player.y, player.angle, 1, 1, 16, 16)
end

return player
