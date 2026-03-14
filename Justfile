set shell := ["bash", "-euo", "pipefail", "-c"]

import "config.just"

[private]
_check_root:
    @if [ "$EUID" -ne 0 ]; then echo "ERROR: Run this script as root" >&2; exit 1; fi

## Base job definitions
@default:
    just --list

# installation
nix: _check_root
	curl -fsSL https://install.determinate.systems/nix \
		| sh -s -- install --no-confirm

flatpaks: _check_root
	dnf install -y \
		--setopt=install_weak_deps=False \
			flatpak

	flatpak remote-add \
		--if-not-exists \
		flathub https://dl.flathub.org/repo/flathub.flatpakrepo

	flatpak install flathub -y \
		--noninteractive \
		{{FLATPAKS}}

dnf_packages: _check_root
	dnf install -y \
		--setopt=install_weak_deps=False \
		{{DNF_PACKAGES}}

# uninstallation
clean_dnf_packages: _check_root
	dnf remove -y {{DNF_PACKAGES}}


clean_flatpaks: _check_root
	flatpak remove -y \
		--delete-data \
		--noninteractive \
		{{FLATPAKS}}

clean_nix:
	curl -fsSL https://install.determinate.systems/nix \
		| sh -s -- uninstall \
		--no-confirm \
		--explain


## meta jobs
all: dnf_packages flatpak nix
clean: clean_dnf_packages clean_flatpaks clean_nix
re: clean all
