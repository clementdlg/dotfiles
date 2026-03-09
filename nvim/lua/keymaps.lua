-- [[ General Keymaps ]]
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- copy / paste
vim.keymap.set({'n', 'v' }, '<Leader>y', '"+y', { noremap = true })
vim.keymap.set({'n', 'v' }, '<Leader>p', '"+p', { noremap = true })

-- up n down center
vim.keymap.set('n', '<C-d>', '<C-d>zz', { noremap = true, silent = true })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { noremap = true, silent = true })
vim.keymap.set('n', '{', '{zz', { noremap = true, silent = true })
vim.keymap.set('n', '}', '}zz', { noremap = true, silent = true })
vim.keymap.set('n', 'n', 'nzz', { noremap = true, silent = true })
vim.keymap.set('n', 'N', 'Nzz', { noremap = true, silent = true })

-- center cursor
vim.keymap.set('n', '<Leader>e', ':30 Lexplore<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<Leader>bn', ':bn<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<Leader>bp', ':bp<CR>', { noremap = true, silent = true })

-- [[ Basic Autocommands ]]
-- highlight text on yank
vim.api.nvim_create_autocmd('TextYankPost', {
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- [[ Custom Commands ]]
-- toggle diagnositcs
vim.api.nvim_create_user_command('ToggleDiagnostics', function()
  vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, {})

-- show active linters
-- vim.api.nvim_create_user_command('LinterStatus', function()
--   local filetype = vim.bo.filetype
--   local linters = require('lint').linters_by_ft[filetype]
--   print(vim.inspect(linters))
-- end, {})
