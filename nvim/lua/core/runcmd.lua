-- ============================================================================
-- Helper Functions
-- ============================================================================

--- Prompts for a new command and saves it to vim.g[var_name]
--- @param var_name string The key in vim.g to update (e.g., "run_cmd")
--- @param default_cmd string Default command to prefill in the prompt
--- @param reg? string Optional register to store the command in
local function set_cmd(var_name, default_cmd, reg)
	local current = vim.g[var_name] or default_cmd
	local cmd = vim.fn.input("Set command: ", current)

	if cmd == "" then
		return
	end

	vim.g[var_name] = cmd

	if reg then
		vim.fn.setreg(reg, cmd)
	end
end

--- Runs the specified command in a bottom split terminal
--- @param var_name string The key in vim.g to read from
--- @param fallback string Fallback recipe if the variable is unset
local function run_cmd(var_name, fallback)
	local cmd = var_name and vim.g[var_name] or nil
	if not cmd or cmd == "" then
		cmd = fallback
	end

	-- Opens a horizontal split at the bottom and launches the terminal buffer
	vim.cmd("belowright split | terminal " .. cmd)
	vim.cmd("startinsert")
end

-- ============================================================================
-- Keymaps
-- ============================================================================

-- register letter → default command
-- also drives the keymaps: <leader>d<letter> = define, <leader>j<letter> = run
local actions = {
	b = "just build",
	r = "just run",
	t = "just test",
}

for reg, default in pairs(actions) do
	vim.keymap.set("n", "<leader>d" .. reg, function()
		set_cmd(reg .. "_cmd", default, reg)
	end, { desc = "Define command (" .. default .. ")", silent = true })

	vim.keymap.set("n", "<leader>j" .. reg, function()
		run_cmd(reg .. "_cmd", default)
	end, { desc = "Run: " .. default, silent = true })
end

-- Picker: select a Justfile recipe and run it
local function pick_action()
	local pickers = require("telescope.pickers")
	local finders = require("telescope.finders")
	local conf = require("telescope.config").values
	local action_state = require("telescope.actions.state")
	local t_actions = require("telescope.actions")
	local themes = require("telescope.themes")

	-- List the recipes of the Justfile in Neovim's current working directory,
	-- with the comment above each job as its description (heading removed)
	local out = vim.fn.system({ "sh", "-c", "just --list --list-heading '' 2>/dev/null" })
	if vim.v.shell_error ~= 0 or out == "" then
		vim.notify("No Justfile recipes found in " .. vim.fn.getcwd(), vim.log.levels.WARN)
		return
	end

	-- Recipe lines are indented; documented ones carry a `# description` suffix.
	-- Parameterized recipes look like `build *ARGS # description`, so the name
	-- is the first token and the description is whatever follows the first `#`.
	local recipes = {}
	for line in out:gmatch("[^\r\n]+") do
		local recipe = line:match("^%s+(%S+)")
		if recipe and recipe:sub(1, 1) ~= "_" then
			local desc = line:match("#%s*(%S.-)%s*$") or ("just " .. recipe)
			table.insert(recipes, { name = recipe, desc = desc })
		end
	end
	table.sort(recipes, function(a, b)
		return a.name < b.name
	end)

	-- Width of the widest [TAG] so the ":" column lines up
	local tag_width = 0
	for _, recipe in ipairs(recipes) do
		tag_width = math.max(tag_width, #recipe.name:upper() + 2)
	end

	pickers
		.new(themes.get_dropdown({ previewer = false }), {
			prompt_title = "Just recipes",
			finder = finders.new_table({
				results = recipes,
				entry_maker = function(recipe)
					local tag = "[" .. recipe.name:upper() .. "]"
					return {
						value = recipe.name,
						display = string.format("%-" .. tag_width .. "s : %s", tag, recipe.desc),
						ordinal = recipe.name .. " " .. recipe.desc,
					}
				end,
			}),
			sorter = conf.generic_sorter({}),
			attach_mappings = function(prompt_bufnr, map)
				local run_selected = function()
					local entry = action_state.get_selected_entry()
					if not entry then
						return
					end
					t_actions.close(prompt_bufnr)
					run_cmd(nil, "just " .. entry.value)
				end
				map("i", "<CR>", run_selected)
				map("n", "<CR>", run_selected)
				return true
			end,
		})
		:find()
end

vim.keymap.set("n", "<leader>ja", pick_action, { desc = "Pick a Justfile recipe and run it", silent = true })
