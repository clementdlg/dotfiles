local languages = require("core.languages").highlight_syntax

-- install() is async and idempotent: already-installed parsers are skipped.
-- require('nvim-treesitter').install(languages)

-- treesitter config (main branch)
vim.api.nvim_create_autocmd("FileType", {
	pattern = languages,
	callback = function()
		vim.treesitter.start()
	end,
})

-- treesitter context (function signature)
-- require("config.treesitter-context")
require("treesitter-context").setup({
	enable = true,

	-- Hard cap on the number of pinned lines. Set to 0 for "no limit".
	-- Use 1 if you literally only want the innermost signature.
	max_lines = 3,

	-- Do not steal screen real estate in a small split.
	min_window_height = 20,

	-- 'inner' drops the outermost contexts when max_lines is exceeded,
	-- 'outer' drops the innermost ones. 'inner' keeps the class/module.
	trim_scope = "outer",

	-- 'cursor'  -> context of the node under the cursor
	-- 'topline' -> context of the first visible line (usually what people want)
	mode = "cursor",

	-- Collapse a signature spanning more than N lines into a single line.
	multiline_threshold = 1,

	-- Show the context in every window, not just the current one.
	multiwindow = false,
	line_numbers = true,
	zindex = 20,
})

-- Jump back to the top of the current context
vim.keymap.set("n", "[c", function()
	require("treesitter-context").go_to_context(vim.v.count1)
end, { silent = true, desc = "Jump to enclosing context" })

vim.keymap.set("n", " <leader>u", function()
	require("treesitter-context").go_to_context(vim.v.count1)
end, { silent = true, desc = "Jump to enclosing context" })
