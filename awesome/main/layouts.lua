local awful = require("awful")
local gears = require("gears")

return gears.table.join({
	awful.layout.suit.tile,
	awful.layout.suit.tile.bottom,
	awful.layout.suit.spiral.dwindle,
	awful.layout.suit.floating,
})
