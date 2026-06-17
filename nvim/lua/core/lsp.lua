--[[------------
	Core LSP
--------------]]
-- This is the part of the LSP config that is native to Neovim. No plugin config here
-- [[ Keymaps ]]
-- TODO: Add keymaps
vim.keymap.set("n", "gD", vim.lsp.buf.definition, { desc = "LSP: Go to definition" })

-- [[ Diagnostics ]]
local severity = vim.diagnostic.severity

vim.diagnostic.config {
	severity_sort = true,
	float = { border = 'rounded', source = 'if_many' },
	underline = { severity = severity.ERROR },
	signs = {
		text = {
			[severity.ERROR] = '󰅚 ',
			[severity.WARN] = '󰀪 ',
			[severity.INFO] = '󰋽 ',
			[severity.HINT] = '󰌶 ',
		},
	},
	virtual_text = {
		source = 'if_many',
		spacing = 2,
		format = function(diagnostic) return diagnostic.message end,
	},
}

-- [[ Highlights ]]
local function lsp_highlight(event)
	local client = vim.lsp.get_client_by_id(event.data.client_id)
	local method = vim.lsp.protocol.Methods.textDocument_documentHighlight

	-- Only attach highlights if the server supports it
	if not (client and client.supports_method and client:supports_method(method)) then
		return
	end

	local group = vim.api.nvim_create_augroup('lsp_highlight', { clear = false })

	vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
		buffer = event.buf,
		group = group,
		callback = vim.lsp.buf.document_highlight,
	})

	vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
		buffer = event.buf,
		group = group,
		callback = vim.lsp.buf.clear_references,
	})

	vim.api.nvim_create_autocmd('LspDetach', {
		buffer = event.buf,
		group = vim.api.nvim_create_augroup('lsp_highlight_detach', { clear = true }),
		callback = function(ev)
			vim.lsp.buf.clear_references()
			vim.api.nvim_clear_autocmds({ group = 'lsp_highlight', buffer = ev.buf })
		end,
	})
end

vim.api.nvim_create_autocmd('LspAttach', {
	callback = function(event) lsp_highlight(event) end
})

-- [[ Inlay hints ]]
