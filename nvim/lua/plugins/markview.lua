require("markview").setup({
	preview = {
		icon_provider = "devicons",
		-- Rendering active in all common modes...
		modes = { "n", "no", "c", "i", "v", "V", "\22" },
		-- ...but in insert mode, the paragraph under the cursor stays raw
		hybrid_modes = { "i" },
		filetypes = { "markdown" },
	},
	html = {
		enable = true,
	},
})

-- Workaround (upstream bug): markview sometimes fails to re-render tables
-- when leaving insert mode. Force a full re-attach on insert → normal in
-- markdown buffers; remove once fixed upstream.
local workaround = vim.api.nvim_create_augroup("markview_re-render", { clear = true })
vim.api.nvim_create_autocmd("ModeChanged", {
	group = workaround,
	pattern = "i*:n",
	callback = function()
		if vim.bo.filetype ~= "markdown" then
			return
		end
		pcall(vim.cmd, "Markview disable")
		pcall(vim.cmd, "Markview enable")
	end,
})
