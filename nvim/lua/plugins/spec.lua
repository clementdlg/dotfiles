local plugins = {
  -- -- Treesitter
  -- {
  --   source = 'nvim-treesitter/nvim-treesitter',
  --   checkout = 'master',
  --   monitor  = 'main',
  --   hooks = {
  --     post_checkout = function()
  --       vim.cmd('TSUpdate')
  --     end,
  --   },
  -- },

  -- Colorscheme
  { source = 'folke/tokyonight.nvim' },

  -- Git signs
  { source = 'lewis6991/gitsigns.nvim' },

  -- Telescope + deps
  {
    source = 'nvim-telescope/telescope.nvim',
    depends = {
      'nvim-lua/plenary.nvim',
      { -- fzf 
        source = 'nvim-telescope/telescope-fzf-native.nvim',
        hooks = {
          post_checkout = function()
            vim.fn.system('make')
          end,
        },
        cond = function()
          return vim.fn.executable('make') == 1
        end,
      },
      'nvim-tree/nvim-web-devicons',
    },
  },

  -- LSP config
  { source = 'neovim/nvim-lspconfig' },

  -- blink.cmp
  { source = 'saghen/blink.cmp' },
}

for _, spec in ipairs(plugins) do
  MiniDeps.add(spec)
end
