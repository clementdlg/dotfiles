local M = {}

-- [[ Treesitter ]]
M.highlight_syntax = {
	'bash',
	'python',
	'lua',
	'c',
	'html',
	'yaml',
	'json',
	'markdown',
	-- 'rust',
	-- 'go',
	-- 'terraform',
}

-- [[ LSP servers ]]
M.servers = {
	terraformls = {},
	bashls = {},
	ruff = {},
	pyright = {
		settings = {
			pyright = {
				-- Using Ruff's import organizer
				disableOrganizeImports = true,
			},
			python = {
				analysis = {
					-- Ignore all files for analysis to exclusively use Ruff for linting
					ignore = { '*' },
				},
			},
		},
	},

	lua_ls = {
		settings = {
			Lua = {
				workspace = {
					library = vim.api.nvim_get_runtime_file("", true),
				}
			},
		},
	},

	ansiblels = {},

	-- docker_language_server = {},
	docker_compose_language_service = {},
	nixd = {},
}

-- [[ 2 spaces indentation ]]
M.indend_by_2 = {
	"lua",
	"javascript",
	"json",
	"html",
	"yaml",
	"yml",
}

return M
