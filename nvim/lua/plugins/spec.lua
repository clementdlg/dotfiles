-- 1. Setup Build Hooks via Autocommands
vim.api.nvim_create_autocmd("PackChanged", {
	group = vim.api.nvim_create_augroup("PackBuildHooks", { clear = true }),
	callback = function(ev)
		local name = ev.data.spec.name

		-- Treesitter build hook
		if name == "nvim-treesitter" then
			vim.cmd("TSUpdate")
		end

		-- fzf-native build hook
		if name == "telescope-fzf-native.nvim" then
			vim.system({ "make" }, { cwd = ev.data.path }):wait()
		end
	end,
})

-- 2. Define the Plugins Array
local plugins = {
	-- Colorscheme
	"https://github.com/folke/tokyonight.nvim",

	-- Git signs
	"https://github.com/lewis6991/gitsigns.nvim",

	-- Telescope + Dependencies
	"https://github.com/nvim-lua/plenary.nvim",
	"https://github.com/nvim-tree/nvim-web-devicons",
	"https://github.com/nvim-telescope/telescope.nvim",

	-- LSP config
	"https://github.com/neovim/nvim-lspconfig",

	-- Bottom bar
	"https://github.com/echasnovski/mini.statusline",

	-- code completion
	{
		src = "https://github.com/saghen/blink.cmp",
		version = "v1",
	},

	-- file tree
	"https://github.com/nvim-tree/nvim-tree.lua",

	-- code formatting
	"https://github.com/stevearc/conform.nvim",

	-- syntax highlighting
	-- "https://github.com/nvim-treesitter/nvim-treesitter",

	-- dedicated markdown plugin
	"https://github.com/OXY2DEV/markview.nvim",

	-- show indent
	"https://github.com/folke/snacks.nvim",

	-- function signature
	{
		src = "https://github.com/nvim-treesitter/nvim-treesitter-context",
		version = "master",
	},
}

-- 3. Conditionally add fzf-native
if vim.fn.executable("make") == 1 then
	table.insert(plugins, "https://github.com/nvim-telescope/telescope-fzf-native.nvim")
end

-- 4. Execute Native Package Manager
vim.pack.add(plugins)
