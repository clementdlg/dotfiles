vim.api.nvim_create_user_command("DiffHead", function()
	-- Ensure the built-in difftool is loaded
	vim.cmd("packadd nvim.difftool")

	local current_file = vim.fn.expand("%:p")
	if current_file == "" then
		vim.notify("No file open to diff.", vim.log.levels.WARN)
		return
	end

	-- 1. Get the file's path relative to the Git repository root
	local git_root_cmd = { "git", "ls-files", "--full-name", current_file }
	local relative_path = vim.trim(vim.fn.system(git_root_cmd))

	if vim.v.shell_error ~= 0 or relative_path == "" then
		vim.notify("File is not tracked by Git.", vim.log.levels.ERROR)
		return
	end

	-- 2. Fetch the content of the file at HEAD
	local head_cmd = { "git", "show", "HEAD:" .. relative_path }
	local head_content = vim.fn.system(head_cmd)

	if vim.v.shell_error ~= 0 then
		vim.notify("Could not fetch HEAD version. Are there commits yet?", vim.log.levels.ERROR)
		return
	end

	-- 3. Write HEAD content to a system temporary file
	-- Appending the original filename helps preserve syntax highlighting in the diff
	local temp_file = vim.fn.tempname() .. "_" .. vim.fn.expand("%:t")
	local fd = io.open(temp_file, "w")
	if not fd then
		vim.notify("Failed to create temporary file for diff.", vim.log.levels.ERROR)
		return
	end
	fd:write(head_content)
	fd:close()

	-- 4. Launch the built-in difftool
	require("difftool").open(temp_file, current_file, { method = "auto" })

	vim.api.nvim_create_autocmd("VimLeavePre", {
		once = true,
		callback = function()
			vim.fn.delete(temp_file)
		end,
	})
end, { desc = "Show split diff of current file against Git HEAD" })

-- Optional: Map it to a convenient keybind
vim.keymap.set("n", "<leader>gd", ":DiffHead<CR>", { silent = true, desc = "Diff current file vs HEAD" })
