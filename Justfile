@default:
    just --list

# Symlink bashrc
bashrc:
	#!/bin/sh
	if [ -f "$HOME/.bashrc" ]; then
		mv -v "$HOME/.bashrc" "$HOME/.bashrc.old$(date +%s)"
		ln -s "$HOME/.config/bash/bashrc" "$HOME/.bashrc"
	fi

# install Nix (without a daemon)
nix:
	#!/bin/sh
	if [ ! -f /nix/receipt.json ]; then
		curl -fsSL https://install.determinate.systems/nix \
		| sh -s -- install linux --no-confirm --init none
	fi

# Initialize the home.nix
home-manager:
	#!/bin/sh
	source /etc/profile.d/nix.sh
	nix run "nixpkgs#home-manager" -- switch
	nix store gc

# preload Neovim config
nvim:
	nvim -l "$XDG_CONFIG_HOME/nvim/init.lua"
