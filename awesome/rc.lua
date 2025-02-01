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
local funcs = require("main.screen")

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
-- apps
-- awful.spawn.with_shell("picom -b")
awful.spawn.with_shell("xfce4-panel &")
awful.spawn.with_shell("flatpak run md.obsidian.Obsidian")

--[[------------
|				|
|	MY APPS		|
|				|
---------------]]
launcher = "rofi -show drun"
terminal = "alacritty"
browser = "com.brave.Browser"
editor = os.getenv("EDITOR") or "vi"
editor_cmd = terminal .. " -e " .. editor
obsidian = "flatpak run md.obsidian.Obsidian"
discord = "flatpak run com.discordapp.Discord"
files = "thunar"
txteditor = terminal .. " -e nvim"
settings = "xfce4-settings-manager"

tag_icons = {}
tag_icons[1] = "󰖟"
tag_icons[2] = ""
tag_icons[3] = "󱓷"
tag_icons[4] = "󰍹"
-- tag_icons[5] = "󱓷"
tag_icons[5] = "󰝰"
tag_icons[6] = "󰭻"
tag_icons[7] = "󰝚"

-- Modkey
modkey = "Mod1"
gap_size = 7

-- Windows gaps
beautiful.useless_gap = gap_size

--[[---------------
|			      |
|	MY LAYOUTS    |
|			      |
-----------------]]

awful.layout.layouts = {
	awful.layout.suit.tile.right,
	awful.layout.suit.tile.bottom,
	awful.layout.suit.floating,
}

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", funcs.set_wallpaper)

-- awful.screen.connect_for_each_screen(function(s)
-- 	-- Wallpaper
-- 	funcs.set_wallpaper(s)
--
-- 	-- Each screen has its own tag table.
-- 	awful.tag(tag_icons, s, awful.layout.layouts[1])
-- end)

awful.screen.connect_for_each_screen(function(s)
	-- Wallpaper
	funcs.set_wallpaper(s)

	if s.index == 1 then
		-- First screen: Assign the full tag table
		awful.tag(tag_icons, s, awful.layout.layouts[1])
	else
		-- Other screens: Assign only one tag
		awful.tag({ "󰐮" }, s, awful.layout.suit.floating)
	end
end)

-- {{{ Key bindings
globalkeys = require("main.globalkeys")

clientkeys = gears.table.join(
	-- awful.key({ modkey }, "f", function(c)
	-- 	c.fullscreen = not c.fullscreen
	-- 	c:raise()
	-- end, { description = "toggle fullscreen", group = "client" }),
	awful.key({ modkey, "Shift" }, "q", function(c)
		c:kill()
	end, { description = "close", group = "client" }),
	awful.key(
		{ modkey, "Control" },
		"space",
		awful.client.floating.toggle,
		{ description = "toggle floating", group = "client" }
	),
	-- awful.key({ modkey, "Control" }, "Return", function(c)
	-- 	c:swap(awful.client.getmaster()
	-- end, { description = "move to master", group = "client" }),

	awful.key({ modkey, "Shift" }, "o", function()
		if client.focus then
			client.focus:move_to_screen()
		end
	end, { description = "move focused client to the next screen", group = "client" }),

	--awful.key({ modkey }, "t", function(c)
	--c.ontop = not c.ontop
	--end, { description = "toggle keep on top", group = "client" }),

	awful.key({ modkey }, "n", function(c)
		c.minimized = true
	end, { description = "minimize", group = "client" }),

	awful.key({ modkey }, "m", function(c)
		c.maximized = not c.maximized
		c:raise()
	end, { description = "(un)maximize", group = "client" })
)

local max_workspace = 7
local tag_keys = { "&", "é", '"', "'", "(", "-", "è", "_", "ç", "à" }
for i = 1, max_workspace do
	globalkeys = gears.table.join(
		globalkeys,
		--
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
			class = {
				"Gpick",
				"Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
				"Wpa_gui",
				"veromix",
				"xtightvncviewer",
				"zenity",
			},

			-- Note that the name property shown in xprop might be set slightly after creation of the client
			-- and the name shown there might not match defined rules here.
			name = {
				"Event Tester", -- xev.
			},
			role = {
				"AlarmWindow", -- Thunderbird's calendar.
				"ConfigManager", -- Thunderbird's about:config.
				-- "pop-up", -- e.g. Google Chrome's (detached) Developer Tools.
			},
			properties = {
				floating = true,
				placement = awful.placement.centered,
				ontop = true,
			},
		},
	},

	-- Add titlebars to normal clients and dialogs
	-- { rule_any = { type = { "normal", "dialog" } }, properties = { titlebars_enabled = false } },

	--#########################################################
	-- Window Rules
	{ rule = { class = "obsidian" }, properties = { screen = 1, tag = tag_icons[3] } },

	{ rule = { class = "Atril" }, properties = { screen = 1, tag = tag_icons[3] } },
	{ rule = { class = "com.github.johnfactotum.Foliate" }, properties = { screen = 1, tag = tag_icons[3] } },

	{ rule = { class = "Virt-manager" }, properties = { screen = 1, tag = tag_icons[4] } },

	{ rule = { class = "Thunar" }, properties = { screen = 1, tag = tag_icons[5] } },

	{ rule = { class = "discord" }, properties = { screen = 1, tag = tag_icons[6] } },
	{ rule = { class = "Signal" }, properties = { screen = 1, tag = tag_icons[6] } },

	{ rule = { class = "easyeffects" }, properties = { screen = 1, tag = tag_icons[7] } },
	{ rule = { class = "Bitwarden" }, properties = { screen = 1, tag = tag_icons[7] } },
	{ rule = { class = "org.mozilla.firefox" }, properties = { screen = 1, tag = tag_icons[7] } },

	{
		rule_any = {
			class = {
				"Galculator",
				"Wrapper-2.0",
			},
			name = {
				"Authentication required", -- polkit
				"Locate ISO media volume", -- virt-manager
				"New VM", -- virt-manager
				"Add a New Storage Pool", -- virt-manager
			},
		},
		properties = {
			floating = true,
			placement = awful.placement.centered,
			ontop = true,
		},
	},

	-- show bluetooth connection window under the tray
	{
		rule = { class = "Blueman-manager" },
		properties = {
			floating = true,
			screen = awful.screen.focused(),
			placement = awful.placement.top_right,
			border_width = 0,
			ontop = true,
		},
	},

	-- xfce panel no borders
	{ rule = { class = "Xfce4-panel" }, properties = { border_width = 0 } },
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

client.connect_signal("unfocus", function(c)
	if c.class == "Blueman-manager" then
		c:kill()
	end
end)

-- Set the background color to #1c1c2e
beautiful.notification_bg = "#1c1c2e"

-- Set the foreground (text) color to white
beautiful.notification_fg = "#FFFFFF"

-- Set font size to 20px for the text inside the notification
beautiful.notification_font = "Sans 16"

-- Optional: Add border if you want to define one
beautiful.notification_border_color = "#FFFFFF" -- White border

-- solve window border bug
client.connect_signal("property::size", function(c)
	if not c.maximized and not client.fullscreen and client.class ~= "Xfce4-panel" then
		c.border_width = beautiful.border_width
	end
end)

-- minimize all other windows when maximizing a window
client.connect_signal("property::size", function(c)
	local function toggle_minimize(action)
		for _, other_client in ipairs(c.screen.selected_tag:clients()) do
			if other_client ~= c and other_client.class ~= "Xfce4-panel" then
				other_client.minimized = action
				other_client.maximized = false
			end
		end
	end

	if c.maximized then
		-- Minimize all other clients
		toggle_minimize(true)
	else
		-- Restore all other clients
		toggle_minimize(false)
	end
end)
