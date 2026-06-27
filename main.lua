local Player = require("player")
local Map = require("map")
local Enemy1 = require("enemy_1")
function love.load()
	love.graphics.setDefaultFilter("nearest", "nearest")
	Player.load()
	Map.load()
	Enemy1.load()
	Camera = require("libraries.camera")()
end

function love.keypressed(key, scancode, isrepeat)
	if key == "space" then
		Enemy1.tryMeleeAttack(Player.x, Player.y, Player.angle)
		Player.swingVisualTimer = 0.1
	end
end


function love.update(dt)
	Player.update(dt)
	Enemy1.update(dt, Player.x, Player.y)
	playerX, playerY = Player.x, Player.y - 100
	Camera:lookAt(playerX, playerY)
end

function love.draw()
	Camera:attach()
		Map.draw()
		Player.draw()
		Enemy1.draw()
	Camera:detach()
end
