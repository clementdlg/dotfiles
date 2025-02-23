# goal for this install
- btrfs partitionning
- snapshots in grub
- snapper as a snapshot utility

# commands
## basics
- verify internet connection
```
ping -c4 1.1.1.1
```

- system clock
```
timedatectl set-timezone Europe/Paris
```

- update mirrors
```
reflector -c France --sort rate --save /etc/pacman.d/mirrorlist
```

- update pacman cache
```
pacman -Syyy
```

- enable ntp
```
timedatectl set-ntp true
```

- upgrade keyring (it can cause problems later)
```
pacman -S archlinux-keyring
```
## partition and formatting
- find your disk
```
fdisk -l 
```
- enter fdisk
```
fdisk /dev/nvme0n1
```
- create GPT partition
- create partition 1:
	- 2GO
	- type : 1 (EFI)
- create partition 2:
	- 4GO
	- type : 19 (EFI)

- create FAT32 on partition 1
```
mkfs.fat -F 32 /dev/nvme0n1p1
```

- create swap partition
```
 mkswap /dev/nvme0n1p2
```
- enable the swap
```
swapon /dev/nvme0n1p2
```

- create the BTRFS partition
```
mkfs.btrfs /dev/nvme0n1p3
```

- CHECKHEALTH : 
```
Device            Start        End    Sectors   Size Type
/dev/nvme0n1p1     2048    4196351    4194304     2G EFI System
/dev/nvme0n1p2  4196352   12584959    8388608     4G Linux swap
/dev/nvme0n1p3 12584960 1953523711 1940938752 925.5G Linux filesystem
```
## btrfs and mounting
- mount the partition3 to `/mnt`
```
mount /dev/nvme0n1p3 /mnt
```

- create the subvolumes (root, home, var, snapshots)
```
btrfs subvolume create /mnt/@
btrfs subvolume create /mnt/@home
btrfs subvolume create /mnt/@var
btrfs subvolume create /mnt/@snapshots
```

- unmount the partition 3
```
umount /mnt
```

- mount the root subvolume to `/mnt`
```
mount -o noatime,compress=lzo,space_cache=v2,subvol=@ /dev/nvme0n1p3 /mnt
```

- create the directories corresponding to the subvolumes
```
mkdir /mnt/{boot,home,var,.snapshots}
```

- mount the remaining subvolumes
```
mount -o noatime,compress=lzo,space_cache=v2,subvol=@home /dev/nvme0n1p3 /mnt/home
mount -o noatime,compress=lzo,space_cache=v2,subvol=@var /dev/nvme0n1p3 /mnt/var
mount -o noatime,compress=lzo,space_cache=v2,subvol=@snapshots /dev/nvme0n1p3 /mnt/.snapshots
```
- don't forget to mount partition 1 on /boot
```
mount /dev/nvme0n1p1 /mnt/boot
```

- CHECKHEALTH : 
```
NAME        MAJ:MIN RM   SIZE RO TYPE MOUNTPOINTS
nvme0n1     259:0    0 931.5G  0 disk
├─nvme0n1p1 259:1    0     2G  0 part /mnt/boot
├─nvme0n1p2 259:2    0     4G  0 part [SWAP]
└─nvme0n1p3 259:3    0 925.5G  0 part /mnt/.snapshots
                                      /mnt/var
                                      /mnt/home
                                      /mnt

```

# Bootstrap the OS
- run the pacstrap command
```
pacstrap /mnt base base-devel linux linux-firmware intel-ucode
```

- generate Fstab
```
genfstab -U /mnt >> /mnt/etc/fstab
```

- change root directory
```
arch-chroot /mnt
```
## regional settings
- set the timezone
```
ln -sf /usr/share/zoneinfo/Europe/Paris /etc/localtime
```
- sync the hardware clock
```
hwclock --systohc
```

- set the locale by uncommenting en_US.utf-8
```
vim /etc/locale.gen
```
- generate the locale
```
locale-gen
```
- set the LANG variable
```
echo "LANG=en_US.UTF-8" > /etc/locale.conf
```

## host settings
- set the hostname
```
echo "archtop" > /etc/hostname
```
- set the /etc/hosts file
```
cat << EOF > /etc/hosts
127.0.0.1   localhost
::1         localhost
127.0.0.1   archtop.localdomain archtop
EOF
```

- set the /etc/vconsole.conf file
```
cat << EOF > /etc/vconsole.conf
KEYMAP="fr"
FONT="ter-228b"
EOF
```

- change the root password
	- **change the password to a secure one**
```
echo "root:mypassw" | chpasswd
```

- install more packages
```
pacman -S grub-btrfs grub efibootmgr networkmanager snapper reflector vim tmux man-db man-pages bash-completion inotify-tools snap-pac git rsync  terminus-font --noconfirm
# not installed at this step : os-prober, mtools, dosfstools
```

- enable NetworkManager
```
systemctl enable NetworkManager
```
## Bootloader
- add btrfs module to initramfs
```
vim /etc/mkinitcpio.conf
MODULES=(btrfs)
...
GRUB_DISABLE_OS_PROBER=true
```
- generate the initramfs
```
mkinitcpio -p linux
```

- install grub
```
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
```
- create grub config
```
grub-mkconfig -o /boot/grub/grub.cfg
```
- **NOTE** : on some hardware, you are required to have a `/boot/EFI/BOOT/bootx64.efi`, and you need to copy `/boot/EFI/GRUB/grubx64.efi` to this destination
## Create user
- create user
```
useradd -mG wheel krem
```
- add sudo privileges
```
visudo
# uncomment `%wheel ALL=(ALL:ALL) ALL`
```
- add a password
	- **change the password to a secure one**
```
echo "krem:krem" | chpasswd
```

- set the keyboard layout
```
localectl set-x11-keymap fr
```
## finish install
- detach using `ctrl-D`

- unmount all disks
```
umount -a
```
- reboot
```
reboot
```