# Install DE  (opt)
- install the following packages 
```
pacman -S xf86-video-intel \
	desktop-env-packages 
```

- enable login manager
```
systemctl enable [gdm|sddm|cosmic-greeter]
```

# Configure snapper
## snapshot dir
- unmount the `.snapshots` subvolume
```
umount /.snapshots
```
- remove the `.snapshots` subvolume
```
btrfs subvolume delete /.snapshots/
```
- create snapper config 
```
snapper -c root create-config /
```
- remount the subvolume
```
mount -a
```

## config
- edit config 
```
vim /etc/snapper/configs/root
...
ALLOW_USERS="krem"
...
TIMELINE_MIN_AGE="3600"
TIMELINE_LIMIT_HOURLY="3"
TIMELINE_LIMIT_DAILY="7"
TIMELINE_LIMIT_WEEKLY="2"
TIMELINE_LIMIT_MONTHLY="6"
TIMELINE_LIMIT_QUARTERLY="0"
TIMELINE_LIMIT_YEARLY="0"
```

- give permissions to other users
```
chmod a+rx /.snapshots
```

- enable systemd unit files
```
systemctl enable --now snapper-timeline.timer
systemctl enable --now snapper-cleanup.timer
sudo systemctl enable --now grub-btrfsd.service
```
- check the status of grub-btrfsd 

# test grub-btrfs
- create a snapshot
```
snapper -c root create -c timeline --description "post install"
```
- list snapshots
```
snapper -c root list
```
- reboot and check that you can boot into the snapshot

# install the pacman-hook
## install AUR helper
- clone the paru repo
```
git clone https://aur.archlinux.org/paru.git
cd paru/
```
- install the package
```
makepkg -sic
```

## install AUR package
- install the package
```
paru -S snap-pac-grub
```

# add the /boot hook
- the /boot is not btrfs but FAT32 so we use a hook
- the hook triggers a rsync backup from /boot to /.bootbackup
- the hook are found [here](https://wiki.archlinux.org/title/System_backup#Snapshots_and_/boot_partition)
- create this folder
```
mkdir -p /etc/pacman.d/hooks
```
- edit these files
```
vim /etc/pacman.d/hooks/55-bootbackup_pre.hook
```
```
vim /etc/pacman.d/hooks/95-bootbackup_post.hook
```