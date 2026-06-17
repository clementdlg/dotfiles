vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

------------------------------
-- CONFIG
------------------------------
require("nvim-tree").setup({
  view = {
    width = 30,
    side = "left",
  },
  renderer = {
    -- Compacts empty folders together
    group_empty = true, 
  },
})

------------------------------
-- KEYMAPS
------------------------------
vim.keymap.set('n', '<leader>e', '<Cmd>NvimTreeToggle<CR>', { desc = 'Toggle File Explorer' })
