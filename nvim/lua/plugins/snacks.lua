require("snacks").setup({
	indent = {
		indent = {
			enabled = true,
			char = "│",
		},
		animate = { enabled = false },
		scope = {
			hl = "SnacksIndent",
			char = "│",
		},
	},
	terminal = {},
})

-- [[ pi coding agent — floating terminal ]]
local agent_cmd = "pi --continue"
local agent_opts = {
	win = {
		relative = "editor",
		position = "float",
		width = 0.8,
		height = 0.8,
		border = "rounded",
		title = " Pi Agent ",
		title_pos = "center",
		-- disable snacks' buffer-local <esc><esc> (it hides the window and
		-- shadows the global t-mode <Esc> exit map in core/keymaps.lua)
		keys = { term_normal = false },
	},
}

-- -- agent run: open (or focus) the floating pi terminal
-- vim.keymap.set("n", "<leader>ar", function()
-- 	require("snacks").terminal(agent_cmd, agent_opts)
-- end, { desc = "Agent: run pi" })
--
-- agent toggle: hide/show the floating pi terminal (job keeps running while hidden)
vim.keymap.set("n", "<leader>a", function()
	require("snacks").terminal.toggle(agent_cmd, agent_opts)
end, { desc = "Agent: toggle pi terminal" })
