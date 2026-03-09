-- [[ LSP config ]]
-- use lspconfig's config and override them with my own preferences
local servers = require('languages').servers
local capabilities = require('blink.cmp').get_lsp_capabilities()

for name, config in pairs(servers) do
	config.capabilities = capabilities
	vim.lsp.config[name] = config
	vim.lsp.enable(name)
end

-- [[ Completion ]]
require('blink.cmp').setup {
	sources = {
		default = { 'lsp', 'path' }
	},
	fuzzy = { implementation = 'lua' },
	signature = { enabled = true },
}
