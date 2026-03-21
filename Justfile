set shell := ["bash", "-euo", "pipefail", "-c"]

USER := "krem"

# config lists
import "config.just"

[private]
_check_root:
    @if [ "$EUID" -ne 0 ]; then echo "ERROR: Run this script as root" >&2; exit 1; fi

@default:
    just --list

# full developper setup based on Neovim
nix: _check_root
	if [ ! -f /nix/receipt.json ]; then \
		curl -fsSL https://install.determinate.systems/nix \
		| sh -s -- install --no-confirm; \
	fi

	su {{USER}} -c "source /etc/profile.d/nix.sh && \
	nix run nixpkgs#home-manager -- switch"

# graphical apps for Linux desktop
flatpak: _check_root
	dnf install -y \
		--setopt=install_weak_deps=False \
			flatpak

	flatpak remote-add \
		--if-not-exists \
		flathub https://dl.flathub.org/repo/flathub.flatpakrepo

	flatpak install flathub -y \
		--noninteractive \
		{{FLATPAK_LIST}}

# fedora only packages
dnf_packages: _check_root
	dnf install -y \
		--setopt=install_weak_deps=False \
		{{DNF_PACKAGES}}

# remove fedora packages
clean_dnf_packages: _check_root
	dnf remove -y {{DNF_PACKAGES}}


# remove graphical apps for Linux
clean_flatpaks: _check_root
	flatpak remove -y \
		--delete-data \
		--noninteractive \
		{{FLATPAKS}}

# remove developer setup
clean_nix:
	curl -fsSL https://install.determinate.systems/nix \
		| sh -s -- uninstall \
		--no-confirm \
		--explain


# install all
install: dnf_packages flatpak nix

# reset
clean: clean_dnf_packages clean_flatpaks clean_nix

# reset then install all
re: clean install
