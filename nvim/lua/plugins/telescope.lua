-- [[ Imports ]]
local telescope = require('telescope')
local builtin = require('telescope.builtin')
local themes = require('telescope.themes')

require('telescope').setup {
	pcall(telescope.load_extension, 'fzf')
}

local dropdown = function(picker)
  return function()
    picker(themes.get_dropdown({ previewer = false }))
  end
end

-- [[ Keymaps ]]
vim.keymap.set('n', '<leader>bl', dropdown(builtin.buffers)) -- list buffers
vim.keymap.set('n', '<leader>o', builtin.find_files) -- find file in project
vim.keymap.set('n', '<leader>fd', builtin.diagnostics) -- diagnostics
vim.keymap.set('n', '<leader>fg', builtin.live_grep) -- grep projectwide
vim.keymap.set('n', '<leader>fh', builtin.help_tags) -- help pages
vim.keymap.set('n', '<leader>re', dropdown(builtin.oldfiles)) -- recent files

vim.keymap.set('n', '<leader>lr', builtin.lsp_references)
vim.keymap.set('n', '<leader>ld', builtin.lsp_definitions)
