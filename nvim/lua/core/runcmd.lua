-- Keymaps
-- keymap : Just run
vim.keymap.set("n", "<leader>jr", function()
	RunBuildCmd()
end, { silent = true })

-- keymap : set build command (just set)
vim.keymap.set("n", "<leader>js", function()
	SetBuildCmd()
end, { silent = true })

-- keymap : Just build
vim.keymap.set("n", "<leader>jb", function()
	vim.cmd("belowright terminal sh -c just build")
end, { silent = true })

-- Functions
function SetBuildCmd()
	local cmd = vim.fn.input("Set build cmd: ")

	if cmd == "" then
		return
	end

	vim.g.build_cmd = cmd
	vim.fn.setreg("b", cmd)
end

function RunBuildCmd()
	if not vim.g.build_cmd or vim.g.build_cmd == "" then
		vim.cmd("belowright terminal sh -c just run")
	else
		vim.cmd("belowright terminal sh -c " .. vim.fn.escape(vim.g.build_cmd, " \\"))
	end
end

-- -- Load at startup
-- local function LoadBuildCmd()
-- 	local reg = vim.fn.getreg("b")
-- 	if reg ~= "" then
-- 		vim.g.build_cmd = reg
-- 	end
-- end

-- -- Autocommand
-- vim.api.nvim_create_autocmd("VimEnter", {
-- 	callback = LoadBuildCmd,
-- })
