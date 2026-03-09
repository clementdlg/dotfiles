vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3
vim.o.number = true
vim.o.relativenumber = true
vim.o.mouse = 'a'
vim.o.showmode = false
vim.o.clipboard = ''
vim.o.breakindent = true
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.signcolumn = 'yes'
vim.o.updatetime = 250
vim.o.timeoutlen = 600
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.list = true
vim.opt.listchars = { tab = '│ ', trail = '·', nbsp = '␣' }
vim.opt.autoindent = true
vim.o.inccommand = 'split'
vim.o.cursorline = true
vim.o.scrolloff = 10
vim.o.confirm = true
vim.opt.winborder = 'rounded'
vim.opt.path:append('**')

-- [[ Formating ]]
-- Set all to 4 spaces of indent by default
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

local indend_by_2 = require('languages').indend_by_2
local augroup = vim.api.nvim_create_augroup("options", {})

-- Override for specific types
vim.api.nvim_create_autocmd("FileType", {
	group = augroup,
	pattern = indend_by_2,
	callback = function()
		vim.opt_local.tabstop = 2
		vim.opt_local.shiftwidth = 2
	end,
})
