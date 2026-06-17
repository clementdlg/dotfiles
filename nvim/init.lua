-- [[ core config ]]
require("core.options")
require("core.keymaps")
require("core.lsp")
require("core.runcmd")

-- [[ Plugin config ]]
require("plugins.spec")

-- cosmetic
require("plugins.colorscheme")

-- UI
require("plugins.statusline")
require("plugins.gitsigns")

-- Navigation
require("plugins.telescope")
require("plugins.nvim-tree")

-- Code tools
require("plugins.blink")
require("plugins.treesitter")
require("plugins.conform")
require("plugins.difftool")

-- Language specific
require("plugins.markview")
