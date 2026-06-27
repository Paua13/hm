local map = {}

function map.load()
	map.grid = {
		{ 1, 1, 1, 1, 1 },
		{ 1, 0, 0, 0, 1 },
		{ 1, 0, 1, 0, 1 },
		{ 1, 1, 1, 1, 1 },
	}
	map.tileSize = 16
end

function map.draw()
	for rowIndex, row in ipairs(map.grid) do
		for colIndex, tile in ipairs(row) do
			if tile == 1 then
				love.graphics.setColor(0.2, 0.2, 0.4)
				love.graphics.rectangle(
					"fill",
					(colIndex - 1) * map.tileSize,
					(rowIndex - 1) * map.tileSize,
					map.tileSize,
					map.tileSize
				)
			end
		end
	end
	love.graphics.setColor(1, 1, 1)
end

return map
