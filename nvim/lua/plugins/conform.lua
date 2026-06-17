require("conform").setup({
	-- Map filetypes to formatters
	formatters_by_ft = {
		lua = { "stylua" },
		python = { "ruff_organize_imports", "ruff_format" },
		nix = { "alejandra", "nixfmt" },
	},

	-- Set up auto-formatting on save
	format_on_save = {
		-- These options are passed to conform.format()
		timeout_ms = 500,
		-- If true, uses fallback LSP formatting if stylua isn't found
		lsp_format = "fallback",
	},
})
