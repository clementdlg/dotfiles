-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
	naughty.notify({
		preset = naughty.config.presets.critical,
		title = "Oops, there were errors during startup!",
		text = awesome.startup_errors,
	})
end

-- Handle runtime errors after startup
do
	local in_error = false
	awesome.connect_signal("debug::error", function(err)
		-- Make sure we don't go into an endless error loop
		if in_error then
			return
		end
		in_error = true

		naughty.notify({
			preset = naughty.config.presets.critical,
			title = "Oops, an error happened!",
			text = tostring(err),
		})
		in_error = false
	end)
end
-- }}}

-- Themes define colours, icons, font and wallpapers.
beautiful.init("~/.config/awesome/theme/theme.lua")

-- Launch at startup
os.execute("picom -b")

--[[------------
|				|
|	MY APPS		|
|				|
---------------]]
launcher = "rofi -show drun"
terminal = "alacritty"
browser = "firefox"
editor = os.getenv("EDITOR") or "vi"
editor_cmd = terminal .. " -e " .. editor
obsidian = "flatpak run md.obsidian.Obsidian"
discord = "flatpak run com.discordapp.Discord"
files = "thunar"
browser = "firefox"
txteditor = terminal .. " -e nvim"
settings = "xfce4-settings-manager"

tag_icons = {}
tag_icons[1] = "󰈹 "
tag_icons[2] = " "
tag_icons[3] = " "
tag_icons[4] = "󰭻 "
tag_icons[5] = "󰝰 "
tag_icons[6] = "󰝚 "

-- Modkey
modkey = "Mod1"

-- Windows gaps
beautiful.useless_gap = 6

--[[---------------
|			      |
|	MY LAYOUTS    |
|			      |
-----------------]]

awful.layout.layouts = {
	awful.layout.suit.tile,
	awful.layout.suit.tile.bottom,
	awful.layout.suit.spiral.dwindle,
	awful.layout.suit.floating,
}

-- {{{ Menu
-- Create a launcher widget and a main menu
myawesomemenu = {
	{
		"hotkeys",
		function()
			hotkeys_popup.show_help(nil, awful.screen.focused())
		end,
	},
	{ "manual", terminal .. " -e man awesome" },
	{ "edit config", editor_cmd .. " " .. awesome.conffile },
	{ "restart", awesome.restart },
	{
		"quit",
		function()
			awesome.quit()
		end,
	},
}

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}
-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()
-- {{{ Wibar
-- Create a textclock widget
mytextclock = wibox.widget.textclock()

-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
	awful.button({}, 1, function(t)
		t:view_only()
	end),
	awful.button({ modkey }, 1, function(t)
		if client.focus then
			client.focus:move_to_tag(t)
		end
	end),
	awful.button({}, 3, awful.tag.viewtoggle),
	awful.button({ modkey }, 3, function(t)
		if client.focus then
			client.focus:toggle_tag(t)
		end
	end),
	awful.button({}, 4, function(t)
		awful.tag.viewnext(t.screen)
	end),
	awful.button({}, 5, function(t)
		awful.tag.viewprev(t.screen)
	end)
)

local tasklist_buttons = gears.table.join(
	awful.button({}, 1, function(c)
		if c == client.focus then
			c.minimized = true
		else
			c:emit_signal("request::activate", "tasklist", { raise = true })
		end
	end),
	awful.button({}, 3, function()
		awful.menu.client_list({ theme = { width = 250 } })
	end),
	awful.button({}, 4, function()
		awful.client.focus.byidx(1)
	end),
	awful.button({}, 5, function()
		awful.client.focus.byidx(-1)
	end)
)

local function set_wallpaper(s)
	-- Wallpaper
	if beautiful.wallpaper then
		local wallpaper = beautiful.wallpaper
		-- If wallpaper is a function, call it with the screen
		if type(wallpaper) == "function" then
			wallpaper = wallpaper(s)
		end
		gears.wallpaper.maximized(wallpaper, s, false)
	end
end

-- beautiful.taglist_font = "DejaVuSansM Nerd Font Propo 14"
-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
	-- Wallpaper
	set_wallpaper(s)

	-- Each screen has its own tag table.
	awful.tag(
		{ tag_icons[1], tag_icons[2], tag_icons[3], tag_icons[4], tag_icons[5], tag_icons[6] },
		s,
		awful.layout.layouts[1]
	)
	-- Create a promptbox for each screen
	s.mypromptbox = awful.widget.prompt()
	-- Create an imagebox widget which will contain an icon indicating which layout we're using.
	-- We need one layoutbox per screen.
	s.mylayoutbox = awful.widget.layoutbox(s)
	s.mylayoutbox:buttons(gears.table.join(
		awful.button({}, 1, function()
			awful.layout.inc(1)
		end),
		awful.button({}, 3, function()
			awful.layout.inc(-1)
		end),
		awful.button({}, 4, function()
			awful.layout.inc(1)
		end),
		awful.button({}, 5, function()
			awful.layout.inc(-1)
		end)
	))
	local gradient_bg = gears.color.create_pattern({
		type = "linear",
		from = { 50, -50 },
		to = { 50, 50 },
		stops = { { 0, "#343d5e" }, { 1, "#161924" } },
	})

	local gradient_focus = gears.color.create_pattern({
		type = "linear",
		from = { 1, 15 },
		to = { 1, 28 },
		stops = { { 1, "#94b6ff" }, { 0, "#000000" } },
	})

	local gradient_urgent = gears.color.create_pattern({
		type = "linear",
		from = { 1, 15 },
		to = { 1, 28 },
		stops = { { 1, "#b294f2" }, { 0, "#22283c" } },
	})

	local function rounded(radius)
		return function(cr, width, height)
			gears.shape.rounded_rect(cr, width, height, radius)
		end
	end

	s.mytaglist = awful.widget.taglist({
		screen = s,
		filter = awful.widget.taglist.filter.all,
		buttons = taglist_buttons,
		style = {
			fg_focus = "#FFFFFF",
			bg_focus = gradient_focus,

			fg_occupied = "#FFFFFF",
			fg_empty = "#FFFFFF",
			bg_occupied = gradient_bg,
			bg_empty = gradient_bg,

			bg_urgent = gradient_urgent,
			shape = rounded(50),
		},
		layout = {
			layout = wibox.layout.fixed.horizontal,
		},
		widget_template = {
			{
				{
					{
						id = "text_role",
						widget = wibox.widget.textbox,
					},
					layout = wibox.layout.fixed.horizontal,
				},
				left = 16,
				right = 8,
				widget = wibox.container.margin,
			},
			id = "background_role",
			widget = wibox.container.background,

			create_callback = function(self, t)
				self:connect_signal("mouse::enter", function()
					self.backup = self.bg
					if not t.selected then
						self.bg = "#3f4263"
					end
				end)
				self:connect_signal("mouse::leave", function()
					-- if self.backup then
					if t.selected then
						self.bg = gradient_focus
					else
						self.bg = self.backup
					end
					-- end
				end)
			end,
		},
	})

	-- Create a tasklist widget
	s.mytasklist = awful.widget.tasklist({
		screen = s,
		filter = awful.widget.tasklist.filter.currenttags,
		buttons = tasklist_buttons,
		style = {
			bg_focus = gradient_focus,
			fg_focus = "#FFFFFF",

			bg_normal = gradient_bg,
			fg_normal = "#FFFFFF",
			bg_urgent = gradient_urgent,
			shape = rounded(4),
		},
		widget_template = {
			{
				{
					{
						{
							id = "icon_role",
							widget = wibox.widget.imagebox,
						},
						widget = wibox.container.margin,
					},
					{
						id = "text_role",
						widget = wibox.widget.textbox,
					},
					layout = wibox.layout.fixed.horizontal,
					spacing = 10,
				},
				left = 10,
				right = 10,
				widget = wibox.container.margin,
			},
			id = "background_role",
			widget = wibox.container.background,
			forced_width = 200,
		},
	})

	--[[---------
	|			|
	|	WIBOX	|
	|			|
	-----------]]
	-- Create the wibox
	s.mywibox = awful.wibar({
		position = "top",
		screen = s,
		visible = true,
		height = 28,
	})

	-- wibox background color
	s.mywibox.bg = gradient_bg
	-- Add widgets to the wibox
	s.mywibox:setup({
		layout = wibox.layout.align.horizontal,
		{ -- Left widgets
			layout = wibox.layout.fixed.horizontal,
			wibox.container.margin(s.mytaglist, 6, 6, 0, 0),
			wibox.container.constraint(s.mytasklist, "max", (s.geometry.width - 650)),
		},
		nil, --removed the center section
		{ -- Right widgets
			layout = wibox.layout.fixed.horizontal,
			wibox.widget.systray(),
			mytextclock,
			s.mylayoutbox,
		},
	})
end)
-- }}}

-- {{{ Mouse bindings
--root.buttons(gears.table.join(
--	--awful.button({}, 3, function()
--	--end),
--	awful.button({}, 4, awful.tag.viewnext),
--	awful.button({}, 5, awful.tag.viewprev)
--))
-- }}}

-- {{{ Key bindings
globalkeys = gears.table.join(
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

	--Terminal
	awful.key(
		{ modkey }, --Modifier
		"t", --Key
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
		"è", --Key
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

	-- -- Prompt
	-- awful.key({ modkey }, "r", function()
	-- 	awful.screen.focused().mypromptbox:run()
	-- end, { description = "run prompt", group = "launcher" }),

	--}),
	--awful.key({ modkey }, "x", function()
	--	awful.prompt.run({
	--		prompt = "Run Lua code: ",
	--		textbox = awful.screen.focused().mypromptbox.widget,
	--		exe_callback = awful.util.eval,
	--		history_path = awful.util.get_cache_dir() .. "/history_eval",
	--	})
	--end, { description = "lua execute prompt", group = "awesome" }),
	-- Menubar
	--awful.key({ modkey }, "p", function()
	--	menubar.show()
	--end, { description = "show the menubar", group = "launcher" })

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

clientkeys = gears.table.join(
	awful.key({ modkey }, "f", function(c)
		c.fullscreen = not c.fullscreen
		c:raise()
	end, { description = "toggle fullscreen", group = "client" }),
	awful.key({ modkey, "Shift" }, "c", function(c)
		c:kill()
	end, { description = "close", group = "client" }),
	awful.key(
		{ modkey, "Control" },
		"space",
		awful.client.floating.toggle,
		{ description = "toggle floating", group = "client" }
	),
	awful.key({ modkey, "Control" }, "Return", function(c)
		c:swap(awful.client.getmaster())
	end, { description = "move to master", group = "client" }),
	--awful.key({ modkey }, "o", function(c)
	--c:move_to_screen()
	--end, { description = "move to screen", group = "client" }),
	--awful.key({ modkey }, "t", function(c)
	--c.ontop = not c.ontop
	--end, { description = "toggle keep on top", group = "client" }),
	awful.key({ modkey }, "n", function(c)
		-- The client currently has the input focus, so it cannot be
		-- minimized, since minimized clients can't have the focus.
		c.minimized = true
	end, { description = "minimize", group = "client" }),
	awful.key({ modkey }, "m", function(c)
		c.maximized = not c.maximized
		c:raise()
	end, { description = "(un)maximize", group = "client" })
	--awful.key({ modkey, "Control" }, "m", function(c)
	--	c.maximized_vertical = not c.maximized_vertical
	--	c:raise()
	--end, { description = "(un)maximize vertically", group = "client" }),
	--awful.key({ modkey, "Shift" }, "m", function(c)
	--	c.maximized_horizontal = not c.maximized_horizontal
	--	c:raise()
	--end, { description = "(un)maximize horizontally", group = "client" })
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
local max_workspace = 6
local tag_keys = { "a", "z", "e", "q", "s", "d" }
for i = 1, max_workspace do
	globalkeys = gears.table.join(
		globalkeys,
		-- View tag only.
		awful.key({ modkey }, tag_keys[i], function()
			local screen = awful.screen.focused()
			local tag = screen.tags[i]
			if tag then
				tag:view_only()
			end
		end, { description = "view tag #" .. i, group = "tag" }),
		-- Toggle tag display.
		awful.key({ modkey, "Control" }, tag_keys[i], function()
			local screen = awful.screen.focused()
			local tag = screen.tags[i]
			if tag then
				awful.tag.viewtoggle(tag)
			end
		end, { description = "toggle tag #" .. i, group = "tag" }),
		-- Move client to tag.
		awful.key({ modkey, "Shift" }, tag_keys[i], function()
			if client.focus then
				local tag = client.focus.screen.tags[i]
				if tag then
					client.focus:move_to_tag(tag)
				end
			end
		end, { description = "move focused client to tag #" .. i, group = "tag" }),
		-- Toggle tag on focused client.
		awful.key({ modkey, "Control", "Shift" }, tag_keys[i], function()
			if client.focus then
				local tag = client.focus.screen.tags[i]
				if tag then
					client.focus:toggle_tag(tag)
				end
			end
		end, { description = "toggle focused client on tag #" .. i, group = "tag" })
	)
end

clientbuttons = gears.table.join(
	awful.button({}, 1, function(c)
		c:emit_signal("request::activate", "mouse_click", { raise = true })
	end),
	awful.button({ modkey }, 1, function(c)
		c:emit_signal("request::activate", "mouse_click", { raise = true })
		awful.mouse.client.move(c)
	end),
	awful.button({ modkey }, 3, function(c)
		c:emit_signal("request::activate", "mouse_click", { raise = true })
		awful.mouse.client.resize(c)
	end)
)

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
	-- All clients will match this rule.
	{
		rule = {},
		properties = {
			border_width = beautiful.border_width,
			border_color = beautiful.border_normal,
			focus = awful.client.focus.filter,
			raise = true,
			keys = clientkeys,
			buttons = clientbuttons,
			screen = awful.screen.preferred,
			placement = awful.placement.no_overlap + awful.placement.no_offscreen,
		},
	},

	-- Floating clients.
	{
		rule_any = {
			instance = {
				"DTA", -- Firefox addon DownThemAll.
				"copyq", -- Includes session name in class.
				"pinentry",
			},
			class = {
				"Arandr",
				"Blueman-manager",
				"Gpick",
				"Kruler",
				"MessageWin", -- kalarm.
				"Sxiv",
				"Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
				"Wpa_gui",
				"veromix",
				"xtightvncviewer",
			},

			-- Note that the name property shown in xprop might be set slightly after creation of the client
			-- and the name shown there might not match defined rules here.
			name = {
				"Event Tester", -- xev.
			},
			role = {
				"AlarmWindow", -- Thunderbird's calendar.
				"ConfigManager", -- Thunderbird's about:config.
				"pop-up", -- e.g. Google Chrome's (detached) Developer Tools.
			},
		},
		properties = { floating = true },
	},

	-- Add titlebars to normal clients and dialogs
	{ rule_any = { type = { "normal", "dialog" } }, properties = { titlebars_enabled = false } },

	--#########################################################
	-- Window Rules
	{ rule = { class = "obsidian" }, properties = { screen = 1, tag = tag_icons[3] } },
	{ rule = { class = "discord" }, properties = { screen = 1, tag = tag_icons[4] } },
	{ rule = { class = "Thunar" }, properties = { screen = 1, tag = tag_icons[5] } },
	{ rule = { class = "settings" }, properties = { screen = 1, tag = tag_icons[6], floating = false } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function(c)
	-- Set the windows at the slave,
	-- i.e. put it at the end of others instead of setting it master.
	-- if not awesome.startup then awful.client.setslave(c) end

	if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then
		-- Prevent clients from being unreachable after screen count changes.
		awful.placement.no_offscreen(c)
	end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
	-- buttons for the titlebar
	local buttons = gears.table.join(
		awful.button({}, 1, function()
			c:emit_signal("request::activate", "titlebar", { raise = true })
			awful.mouse.client.move(c)
		end),
		awful.button({}, 3, function()
			c:emit_signal("request::activate", "titlebar", { raise = true })
			awful.mouse.client.resize(c)
		end)
	)

	awful.titlebar(c):setup({
		{ -- Left
			awful.titlebar.widget.iconwidget(c),
			buttons = buttons,
			layout = wibox.layout.fixed.horizontal,
		},
		{ -- Middle
			{ -- Title
				align = "center",
				widget = awful.titlebar.widget.titlewidget(c),
			},
			buttons = buttons,
			layout = wibox.layout.flex.horizontal,
		},
		{ -- Right
			awful.titlebar.widget.floatingbutton(c),
			awful.titlebar.widget.maximizedbutton(c),
			awful.titlebar.widget.stickybutton(c),
			awful.titlebar.widget.ontopbutton(c),
			awful.titlebar.widget.closebutton(c),
			layout = wibox.layout.fixed.horizontal(),
		},
		layout = wibox.layout.align.horizontal,
	})
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
	c:emit_signal("request::activate", "mouse_enter", { raise = false })
end)

client.connect_signal("focus", function(c)
	c.border_color = beautiful.border_focus
end)
client.connect_signal("unfocus", function(c)
	c.border_color = beautiful.border_normal
end)
