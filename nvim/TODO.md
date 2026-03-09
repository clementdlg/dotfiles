# project goals
- running my neovim environment in docker, with access to plugins, LSPs and TreeSitter syntax
- docker image build me be highly optimized in speed and weight
- run dockerized neovim config onto servers
- write the appropriate neovim config in respects for separation of concerns and minimalism


# design goals
## minimalist config
- each line of code is a maintainability burden 
- the total LOC count must be the smallest possible (includes dockerfile and lua and everything else)
- LOC count is made of each plugin's LOC count + my config's LOC count

## respect separation of concerns 
- do i install neovim plugin (which are essentially just a git repo) externally

## do not reinvent wheel all the time
- do not write 100 lines of smth to save 15 lines of Lua

## optimize docker
- using docker is not an excuse to get bloated
- docker build go fast
- docker image is lightweight


#  nvim docker repo layout
## general
- only one branch, docker-main
```
├── Dockerfile
├── init.lua
└── lua
    ├── build
    │   ├── install.lua
    │   └── spec.lua
    ├── keymaps.lua
    ├── lsp.lua
    ├── options.lua
    └── plugins.lua
```

## build/
### spec.lua
- the 'spec.lua' file is declarative file to represent what is to be installed, using arrays.
- arrays have 3 possible types :
    - lazy plugin spec
    - mason LSP 'ensure_installed'
    - treesitter 'ensure_installed'
- spec.lua **does not contains** plugin configs

### install.lua
- the 'install.lua' file reads the spec.lua and installs everything
- install.lua takes care of :
    - lazy install plugins (async)
    - treesitters compiles parsers (async)
    - mason install LSP with tool-installer (async)

## lua/*
- contains :
    - setup plugin runtimepath
    - plugin config : .setup() function
    - vim options, keymaps, autocmd, and custom commands
- does not contains :
    - lazy install spec
    - lazy itself
    - mason


# Dockerfile
## stages
### build
- install build tools for nvim and plugin dependencies
- compile neovim
- create user and homedir

- clone the Lazy.nvim repo from dockerfile directly
- run neovim headless and run the install.lua
- remove lazy and mason

### final stage
- copy neovim
- copy plugins dir
- copy LSPs
