# Neovim PDE — Personal Development Environment

A hand-rolled Neovim configuration (Lua, 100% — no distribution, no framework) that turns Neovim into a lightweight IDE: native LSP, Treesitter, completion, formatting, fuzzy finding, Git signs, and a project-aware build/run workflow.

## Requirements

- **Neovim 0.12+** (uses native `vim.pack`, `vim.lsp.config`, `vim.lsp.enable`, `vim.treesitter.start`, `winborder`)
- `git` (plugin management)
- `make` (optional — builds `telescope-fzf-native` if available)
- External tools, installed on demand per language:
  - **Formatters:** `stylua`, `ruff`, `alejandra` / `nixfmt`
  - **LSP servers:** `tofu-ls`, `clangd`, `bash-language-server`, `ruff`, `pyright`, `lua-language-server`, `ansible-language-server`, `docker-language-server`, `nixd`
  - **Justfile** (`just`) for the build/run keymaps

## Layout

```
.
├── init.lua                  # Entry point: loads core + plugin modules in order
├── nvim-pack-lock.json       # Lockfile for the native plugin manager (vim.pack)
├── ftdetect/
│   ├── ansible.lua           # Filetype rules for Ansible playbooks/roles
│   └── docker.lua            # Filetype rules for Dockerfiles & compose files
└── lua/
    ├── core/                 # Editor core, no plugin dependencies
    │   ├── options.lua       # Editor settings, indentation (4sp default, 2sp per filetype)
    │   ├── keymaps.lua       # General keymaps, yank highlight, :ToggleDiagnostics
    │   ├── lsp.lua           # Native LSP: diagnostics, signs, inlay hints, highlight on hold
    │   ├── languages.lua     # Single source of truth: servers, TS parsers, 2-space filetypes
    │   └── runcmd.lua        # Configurable build/run commands in a terminal split
    └── plugins/              # One file per plugin (or plugin group)
        ├── spec.lua          # Plugin list + vim.pack setup with build hooks
        ├── tokyonight.lua    # Colorscheme (moon style, transparent)
        ├── statusline.lua    # mini.statusline
        ├── gitsigns.lua      # Git gutter signs
        ├── telescope.lua     # Fuzzy finder + LSP pickers
        ├── nvim-tree.lua     # File explorer
        ├── blink.lua         # blink.cmp completion + LSP capabilities wiring
        ├── treesitter.lua    # Syntax highlighting + treesitter-context
        ├── conform.lua       # Formatting on save
        ├── difftool.lua      # :DiffHead — diff current file vs Git HEAD
        ├── markview.lua      # Markdown preview (hybrid mode)
        ├── snacks.lua        # Indent guides
        └── minideps.lua      # (unused) legacy mini.deps bootstrap — kept for reference
```

## Plugin management

Uses **Neovim's native package manager** (`vim.pack.add`) in `lua/plugins/spec.lua` — no plugin manager dependency. `nvim-pack-lock.json` pins every plugin to a commit.

Build hooks are handled via a `PackChanged` autocommand:
- `nvim-treesitter` → runs `TSUpdate`
- `telescope-fzf-native.nvim` → runs `make` (only added if `make` exists)

## Language support

All language configuration lives in **`lua/core/languages.lua`**:

| Area | Languages |
|---|---|
| Treesitter highlighting | lua, c, markdown, nix, html, json, yaml, bash, python, javascript, go, rust, css |
| LSP servers | tofu-ls, clangd, bashls, ruff + pyright (Ruff handles linting/imports), lua_ls, ansiblels, docker_language_server, nixd |
| 2-space indent | lua, javascript, json, html, yaml, yml |

Python is set up so **Ruff does linting/import organization** and **Pyright does type analysis** (Pyright's own analysis is disabled).

Treesitter highlighting is started via a `FileType` autocommand using `vim.treesitter.start()` (no legacy `highlight` module).

## Keymaps

Leader is `<Space>`.

### General
| Key | Action |
|---|---|
| `<Esc>` | Clear search highlighting |
| `<leader>y` / `<leader>p` | Yank / paste to system clipboard |
| `<C-d>` / `<C-u>` | Half-page down/up, cursor centered |
| `{` / `}` / `n` / `N` | Same motions, cursor centered |
| `<leader>bn` / `<leader>bp` | Next / previous buffer |
| `<leader>q` | Diagnostics into quickfix list |
| `<leader>t` | Terminal in a bottom split (`<Esc>` exits terminal mode) |
| `:ToggleDiagnostics` | Toggle diagnostics on/off |

### Fuzzy finding (Telescope)
| Key | Action |
|---|---|
| `<leader>o` | Find files in project |
| `<leader>l` | List buffers (dropdown) |
| `<leader>re` | Recent files (dropdown) |
| `<leader>fg` | Live grep |
| `<leader>fd` | Diagnostics |
| `<leader>fh` | Help tags |
| `<leader>fs` | Document symbols (on LSP attach) |
| `<leader>fS` | Workspace symbols (on LSP attach) |
| `<leader>lr` / `<leader>ld` | LSP references / definitions |

### LSP
| Key | Action |
|---|---|
| `gD` | Go to definition |
| *(cursor hold)* | Document highlight (if the server supports it) |

### Build / run (`just`-based, configurable)
| Key | Action |
|---|---|
| `<leader>jb` | Run build command (default `just build`) in terminal split |
| `<leader>db` | Prompt to change the build command (stored to register `b`) |
| `<leader>jr` | Run command (default `just run`) in terminal split |
| `<leader>dr` | Prompt to change the run command (stored to register `r`) |
| `<leader>jt` | Run test command (default `just test`) in terminal split |
| `<leader>dt` | Prompt to change the test command (stored to register `t`) |
| `<leader>ja` | Pick a Justfile recipe (shown with its doc comment) from a Telescope dropdown and run it |

Commands persist for the session in `vim.g` — per-project overrides work by setting them once per session.

### Pi agent (floating terminal, snacks.nvim)
| Key | Action |
|---|---|
| `<leader>ar` | Open (or focus) the pi agent in a rounded floating terminal (`pi --continue`) |
| `<leader>at` | Toggle (hide/show) the floating pi terminal — the job keeps running while hidden |

### Files & code
| Key | Action |
|---|---|
| `<leader>e` | Toggle nvim-tree explorer |
| `[c` / `<leader>u` | Jump to enclosing context (treesitter-context) |
| `<leader>gd` | Diff current file against Git HEAD |

## Editor behavior highlights

- **Indentation:** 4 spaces by default; 2 spaces for lua/js/json/html/yaml (`core/languages.lua`)
- **Formatting on save** via conform (lua → stylua, python → ruff, nix → alejandra/nixfmt), LSP fallback
- **Search:** smart-case (case-insensitive unless capitals used)
- **Persistent undo**, clipboard left empty (system-independent, yank via `<leader>y`)
- **UI:** rounded window borders, cursor line, `scrolloff 8`, visible whitespace, sign column always on
- **Diagnostics:** virtual text with Nerd Font glyphs, underline only for errors, floating windows with rounded borders
- **Markdown:** markview renders in all modes; in insert mode, the paragraph under the cursor stays raw for editing

## Installing / updating plugins

Plugins are installed automatically on first launch via `vim.pack.add`. To sync against the lockfile, just restart Neovim — `vim.pack` fetches pinned revisions recorded in `nvim-pack-lock.json`.
