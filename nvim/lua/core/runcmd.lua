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
	local cmd = vim.g[var_name]
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
	p = "pi --continue",
}

for reg, default in pairs(actions) do
	vim.keymap.set("n", "<leader>d" .. reg, function()
		set_cmd(reg .. "_cmd", default, reg)
	end, { desc = "Define command (" .. default .. ")", silent = true })

	vim.keymap.set("n", "<leader>j" .. reg, function()
		run_cmd(reg .. "_cmd", default)
	end, { desc = "Run: " .. default, silent = true })
end
