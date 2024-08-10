local hotkeys_popup = require("awful.hotkeys_popup")
local awful = require("awful")
local gears = require("gears")

return gears.table.join(
	--[[--------------------
	|					   |
	|	WINDOW BINDINGS    |
	|					   |
	----------------------]]
	--show help
	awful.key(
		{ modkey }, -- Modifier
		"ù", -- Key
		hotkeys_popup.show_help, --Action
		{ description = "show help", group = "awesome" }
	),
	--view previous
	awful.key(
		{ modkey }, -- Modifier
		"Left", -- Key
		awful.tag.viewprev, --Action
		{ description = "view previous", group = "tag" }
	),
	--view next
	awful.key(
		{ modkey }, -- Modifier
		"Right", -- Key
		awful.tag.viewnext, --Action
		{ description = "view next", group = "tag" }
	),
	--go back
	awful.key(
		{ modkey }, -- Modifier
		"Escape", -- Key
		awful.tag.history.restore, --Action
		{ description = "go back", group = "tag" }
	),

	--focus next by index
	awful.key(
		{ modkey }, --Modifier
		"j", --Key
		function() --Action
			awful.client.focus.byidx(1)
		end,
		{ description = "focus next by index", group = "client" }
	),
	--focus previous by index
	awful.key(
		{ modkey }, --Modifier
		"k", --Key
		function() --Action
			awful.client.focus.byidx(-1)
		end,
		{ description = "focus previous by index", group = "client" }
	),
	--
	awful.key(
		{
			modkey, --Modiswap with next client by indexfier
			"Shift",
		}, --Key
		"j",
		function() --Action
			awful.client.swap.byidx(1)
		end,
		{ description = "swap with next client by index", group = "client" }
	),
	awful.key(
		{
			modkey, --Modifier
			"Shift",
		}, --Key
		"k",
		function() --Action
			awful.client.swap.byidx(-1)
		end,
		{ description = "swap with previous client by index", group = "client" }
	),

	awful.key(
		{
			modkey, --Modifier
			"Control",
		}, --Key
		"j",
		function() --Action
			awful.screen.focus_relative(1)
		end,
		{ description = "focus the next screen", group = "screen" }
	),
	awful.key(
		{
			modkey, --Modifier
			"Control",
		}, --Key
		"k",
		function() --Action
			awful.screen.focus_relative(-1)
		end,
		{ description = "focus the previous screen", group = "screen" }
	),
	--jump to urgent client
	awful.key(
		{ modkey }, -- Modifier
		"u", -- Key
		awful.client.urgent.jumpto, --Action
		{ description = "jump to urgent client", group = "client" }
	),
	awful.key({ modkey }, "Tab", function()
		awful.client.focus.history.previous()
		if client.focus then
			client.focus:raise()
		end
	end, { description = "go back", group = "client" }),

	--Restart Awesome
	awful.key(
		{
			modkey, -- Modifier
			"Control",
		}, -- Key
		"r", --Action
		awesome.restart,
		{ description = "reload awesome", group = "awesome" }
	),

	--Quit Awesome
	awful.key(
		{
			modkey, -- Modifier
			"Control",
		},
		"x", -- Key
		awesome.quit, --Action
		{ description = "quit awesome", group = "awesome" }
	),

	--Resize window
	awful.key(
		{ modkey }, --Modifier
		"l", --Key
		function() --Action
			awful.tag.incmwfact(0.035)
		end,
		{ description = "increase master width factor", group = "layout" }
	),
	awful.key(
		{ modkey }, --Modifier
		"h", --Key
		function() --Action
			awful.tag.incmwfact(-0.035)
		end,
		{ description = "decrease master width factor", group = "layout" }
	),

	--Change layout
	awful.key(
		{
			modkey, --Modifier
			"Shift",
		}, --Key
		"h",
		function() --Action
			awful.tag.incnmaster(1, nil, true)
		end,
		{ description = "increase the number of master clients", group = "layout" }
	),
	awful.key(
		{
			modkey, --Modifier
			"Shift",
		}, --Key
		"l",
		function() --Action
			awful.tag.incnmaster(-1, nil, true)
		end,
		{ description = "decrease the number of master clients", group = "layout" }
	),

	awful.key(
		{
			modkey, --Modifier
			"Control",
		}, --Key
		"h",
		function() --Action
			awful.tag.incncol(1, nil, true)
		end,
		{ description = "increase the number of columns", group = "layout" }
	),
	awful.key(
		{
			modkey, --Modifier
			"Control",
		}, --Key
		"l",
		function() --Action
			awful.tag.incncol(-1, nil, true)
		end,
		{ description = "decrease the number of columns", group = "layout" }
	),

	awful.key(
		{ modkey }, --Modifier
		"space", --Key
		function() --Action
			awful.layout.inc(1)
		end,
		{ description = "select next", group = "layout" }
	),
	awful.key(
		{
			modkey, --Modifier
			"Shift",
		}, --Key
		"space",
		function() --Action
			awful.layout.inc(-1)
		end,
		{ description = "select previous", group = "layout" }
	),

	awful.key({ modkey, "Control" }, "n", function()
		local c = awful.client.restore()
		-- Focus restored client
		if c then
			c:emit_signal("request::activate", "key.unminimize", { raise = true })
		end
	end, { description = "restore minimized", group = "client" }),
	--[[-----------------
	|					|
	|	APP BINDINGS	|
	|					|
	-------------------]]
	--Terminal
	awful.key(
		{ modkey }, --Modifier
		"Return", --Key
		function() --Action
			awful.spawn(terminal)
		end,
		{ description = "open a terminal", group = "launcher" }
	),

	--Rofi
	awful.key(
		{ modkey }, --Modifier
		"r", --Key
		function() --Action
			awful.spawn(launcher)
		end,
		{ description = "rofi", group = "launcher" }
	),

	--Obsidian
	awful.key(
		{ modkey }, --Modifier
		"o", --Key
		function() --Action
			awful.spawn(obsidian)
		end,
		{ description = "open Obsidian", group = "launcher" }
	),

	--Discord
	awful.key(
		{ modkey }, --Modifier
		"c", --Key
		function() --Action
			awful.spawn(discord)
		end,
		{ description = "open Discord", group = "launcher" }
	),

	--File explorer
	awful.key(
		{ modkey }, --Modifier
		"t", --Key
		function() --Action
			awful.spawn(files)
		end,
		{ description = "open file explorer", group = "launcher" }
	),

	--Browser
	awful.key(
		{ modkey }, --Modifier
		"b", --Key
		function() --Action
			awful.spawn(browser)
		end,
		{ description = "open browser", group = "launcher" }
	),

	--Vim
	awful.key(
		{ modkey }, --Modifier
		"v", --Key
		function() --Action
			awful.spawn(txteditor)
		end,
		{ description = "open txteditor", group = "launcher" }
	),

	--Settings
	awful.key(
		{ modkey }, --Modifier
		"p", --Key
		function() --Action
			awful.spawn(settings)
		end,
		{ description = "open a settings", group = "launcher" }
	),

	--Print screen
	awful.key(
		{}, --Modifier
		"Print", --Key
		function() --Action
			awful.spawn("flameshot gui")
		end,
		{ description = "Print screen", group = "Multimedia" }
	),

	--[[-----------------------
	|						  |
	|	MULTIMEDIA BINDINGS   |
	|						  |
	-------------------------]]
	--Volume Up
	awful.key(
		{}, --Modifier
		"XF86AudioRaiseVolume", --Key
		function() --Action
			awful.spawn("amixer set Master 5%+")
		end,
		{ description = "raise volume", group = "Multimedia" }
	),
	--Volume Down
	awful.key(
		{}, --Modifier
		"XF86AudioLowerVolume", --Key
		function() --Action
			awful.spawn("amixer set Master 5%-")
		end,
		{ description = "lower volume", group = "Multimedia" }
	),
	--Mute/Unmute sound
	awful.key(
		{}, --Modifier
		"XF86AudioMute", --Key
		function() --Action
			awful.spawn("amixer set Master toggle")
		end,
		{ description = "mute/unmute output", group = "Multimedia" }
	),
	--Mute/Unmute microphone
	awful.key(
		{}, --Modifier
		"XF86AudioMicMute", --Key
		function() --Action
			awful.spawn("amixer set Capture toggle")
		end,
		{ description = "mute/unmute microphone", group = "Multimedia" }
	),
	--Play/pause
	awful.key(
		{}, --Modifier
		"XF86AudioPlay", --Key
		function() --Action
			awful.spawn("playerctl play-pause")
		end,
		{ description = "Play/pause", group = "Multimedia" }
	),
	--Play next song
	awful.key(
		{}, --Modifier
		"XF86AudioNext", --Key
		function() --Action
			awful.spawn("playerctl next")
		end,
		{ description = "Play next song", group = "Multimedia" }
	),
	--Play previous song
	awful.key(
		{}, --Modifier
		"XF86AudioPrev", --Key
		function() --Action
			awful.spawn("playerctl previous")
		end,
		{ description = "Play previous song", group = "Multimedia" }
	),
	--Brightness Down
	awful.key(
		{}, --Modifier
		"XF86MonBrightnessDown", --Key
		function() --Action
			awful.spawn("light -U 5")
		end,
		{ description = "brightness down", group = "Multimedia" }
	),
	--Brightness Up
	awful.key(
		{}, --Modifier
		"XF86MonBrightnessUp", --Key
		function() --Action
			awful.spawn("light -A 5")
		end,
		{ description = "brightness up", group = "Multimedia" }
	),
	--[[----------------------
	|					     |
	|	SUPER KEY BINDINGS   |
	|					     |
	------------------------]]
	--Display settings
	awful.key(
		{ "Mod4" }, --Modifier
		"p", --Key
		function() --Action
			awful.spawn("arandr")
		end,
		{ description = "display settings", group = "Multimedia" }
	),
	--lock screen
	awful.key(
		{ "Mod4" }, --Modifier
		"l", --Key
		function() --Action
			awful.spawn("i3lock")
		end,
		{ description = "lock screen", group = "Multimedia" }
	)
)
