local Player = require("player")
local Map = require("map")
function love.load()
	love.graphics.setDefaultFilter("nearest", "nearest")
	Player.load()
	Map.load()
	Camera = require("libraries.camera")()
end

function love.update(dt)
	Player.update(dt)
	local playerX, playerY = Player.x, Player.y - 100
	Camera:lookAt(playerX, playerY)
end

function love.draw()
	Camera:attach()
		Map.draw()
		Player.draw()
	Camera:detach()
end
