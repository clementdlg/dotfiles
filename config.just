DNF_PACKAGES := SERVER + " " + CLI + " " + NETWORK + " " + DESKTOP + " " + FIRMWARE
SERVER := '''
	@virtualization
	podman
	podman-compose
	podman-docker
	podman-tui
	setroubleshoot-server
	nvtop
	terminus-fonts-console
    rsync
	timeshift
'''

FIRMWARE := '''
	intel-audio-firmware
	intel-gpu-firmware 
	linux-firmware
	realtek-firmware
'''

CLI := '''
	vim
	htop
	man-db
	man-pages
	openssh
	curl
	bash-completion
	dejavu-sans-mono-fonts
'''

DESKTOP := '''
    cosmic-edit
	cosmic-files
	cosmic-session
	alacritty
    flatpak
	xdg-desktop-portal
	pipewire
	wireplumber
	pipewire-pulse
'''

NETWORK := '''
    iproute
	NetworkManager-wifi
	wpa_supplicant
	wireguard-tools
'''

FLATPAKS := '''
    com.discordapp.Discord
	com.github.wwmm.easyeffects
	md.obsidian.Obsidian
    org.signal.Signal
	org.qbittorrent.qBittorrent
	org.remmina.Remmina
    org.filezillaproject.Filezilla
	org.onlyoffice.desktopeditors
	org.prismlauncher.PrismLauncher
'''
