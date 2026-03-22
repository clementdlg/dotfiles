@default:
    just --list

# ansible setup
[working-directory: 'ansible']
ansible:
	command -v uv >/dev/null
	uv python install
	uv sync


# lsp installation
[working-directory: 'nodejs']
nodejs:
	command -v bun >/dev/null
	bun ci --production


golang:
	command -v go >/dev/null
	go install github.com/hashicorp/terraform-ls@latest
	go install github.com/docker/docker-language-server/cmd/docker-language-server@latest


# add bashrc
bashrc:
	#!/bin/sh
	command -v diff >/dev/null
	if ! diff "$HOME/.config/bash/bashrc" "$HOME/.bashrc" >/dev/null ; then
		mv -v "$HOME/.bashrc" "$HOME/.bashrc.old"
		ln -s "$HOME/.config/bash/bashrc" "$HOME/.bashrc"
	fi

# nix:
# 	if [ ! -f /nix/receipt.json ]; then \
# 		curl -fsSL https://install.determinate.systems/nix \
# 		| sh -s -- install --no-confirm; \
# 	fi
#
# 	source /etc/profile.d/nix.sh &&\
# 	nix run "nixpkgs#home-manager" -- switch

clean_nodejs:
	rm -rfv nodejs/node_modules

clean_ansible:
	rm -rfv ansible/.venv

# remove bashrc
clean_bashrc:
	#!/bin/sh
	if [ -f "$HOME/.bashrc.old" ]; then
		rm "$HOME/.bashrc"
		mv -v "$HOME/.bashrc.old" "$HOME/.bashrc"
	fi

# # remove nix setup
# clean_nix:
# 	curl -fsSL https://install.determinate.systems/nix \
# 		| sh -s -- uninstall \
# 		--no-confirm \
# 		--explain

# install all
install: bashrc ansible nodejs

# reset
clean: clean_bashrc clean_nodejs clean_ansible

# reset then install all
re: clean install
