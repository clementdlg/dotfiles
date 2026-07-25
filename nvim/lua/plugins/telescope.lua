-- [[ Imports ]]
local telescope = require("telescope")
local builtin = require("telescope.builtin")
local themes = require("telescope.themes")

require("telescope").setup({
	pcall(telescope.load_extension, "fzf"),
})

local dropdown = function(picker)
	return function()
		picker(themes.get_dropdown({ previewer = false }))
	end
end

-- [[ Keymaps ]]
vim.keymap.set("n", "<leader>bl", dropdown(builtin.buffers)) -- list buffers
vim.keymap.set("n", "<leader>o", builtin.find_files) -- find file in project
vim.keymap.set("n", "<leader>fd", builtin.diagnostics) -- diagnostics
vim.keymap.set("n", "<leader>fg", builtin.live_grep) -- grep projectwide
vim.keymap.set("n", "<leader>fh", builtin.help_tags) -- help pages
vim.keymap.set("n", "<leader>re", dropdown(builtin.oldfiles)) -- recent files

vim.keymap.set("n", "<leader>lr", builtin.lsp_references)
vim.keymap.set("n", "<leader>ld", builtin.lsp_definitions)

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if not client then
			return
		end

		local opts = { buffer = args.buf, silent = true }

		if client:supports_method("textDocument/documentSymbol") then
			vim.keymap.set(
				"n",
				"<leader>fs",
				require("telescope.builtin").lsp_document_symbols,
				vim.tbl_extend("force", opts, { desc = "Fuzzy find document symbols" })
			)
		end

		if client:supports_method("workspace/symbol") then
			vim.keymap.set(
				"n",
				"<leader>fS",
				require("telescope.builtin").lsp_dynamic_workspace_symbols,
				vim.tbl_extend("force", opts, { desc = "Fuzzy find workspace symbols" })
			)
		end
	end,
})
