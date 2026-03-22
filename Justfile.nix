@default:
    just --list

# full developper setup based on Neovim
nix:
	if [ ! -f /nix/receipt.json ]; then \
		curl -fsSL https://install.determinate.systems/nix \
		| sh -s -- install --no-confirm; \
	fi

	source /etc/profile.d/nix.sh &&\
	nix run "nixpkgs#home-manager" -- switch

# add bashrc
bashrc:
	command -v diff
	if ! [ diff "$XDG_CONFIG_HOME/bash/bashrc" "$HOME/.bashrc" >/dev/null ]; then \
		mv -v "$HOME/.bashrc" "$HOME/.bashrc.old" &&\
		ln -s "$XDG_CONFIG_HOME/bash/bashrc" "$HOME/.bashrc" \
	fi

# remove nix setup
clean_nix:
	curl -fsSL https://install.determinate.systems/nix \
		| sh -s -- uninstall \
		--no-confirm \
		--explain


# remove bashrc
clean_bashrc:
	if [ -f "$HOME/.bashrc.old" ]; then \
		rm "$HOME/.bashrc" &&\
		mv -v "$HOME/.bashrc.old" "$HOME/.bashrc" \
	fi

# install all
install: bashrc nix

# reset
clean: clean_nix clean_bashrc

# reset then install all
re: clean install
