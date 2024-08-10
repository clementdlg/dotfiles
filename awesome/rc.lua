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
tag_icons[1] = "󰈹"
tag_icons[2] = ""
tag_icons[3] = "󱞁"
tag_icons[4] = "󰭻"
tag_icons[5] = "󰝰"
tag_icons[6] = ""
tag_icons[8] = "󰝚"
tag_icons[7] = ""

-- Modkey
modkey = "Mod1"

-- Windows gaps
beautiful.useless_gap = 8

--[[---------------
|			      |
|	MY LAYOUTS    |
|			      |
-----------------]]

awful.layout.layouts = require("main.layouts")

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- date & time widget
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
awful.tag(tag_icons, s, awful.layout.layouts[1])
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
    from = { 1, 16 },
    to = { 1, 28 },
    stops = { { 1, "#94b6ff" }, { 0, "#11121a" } },
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
        font = "DejaVuSansM Nerd Font Propo 16",
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
            left = 13,
            right = 13,
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

-- {{{ Key bindings
globalkeys = require("main.globalkeys")

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
		c.minimized = true
	end, { description = "minimize", group = "client" }),

	awful.key({ modkey }, "m", function(c)
		c.maximized = not c.maximized
		c:raise()
	end, { description = "(un)maximize", group = "client" })
)

--[[--------------
|			     |
|	WORKSPACES   |
|			     |
----------------]]

local max_workspace = 9
local tag_keys = { "&", "é", '"', "'", "(", "-", "è", "_", "ç" }
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
				"Galculator",
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
	{ rule = { class = "settings" }, properties = { screen = 1, tag = tag_icons[7], floating = false } },
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
