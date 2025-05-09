# ArchLinux Files

## Proceso de instalacion

### Update System
```
sudo pacman -Syu
```

### Instalar paquetes
```
sudo pacman -S bspwm sxhkd kitty picom zsh feh thunar ranger mlocate imagemagick neofetch polybar unzip xorg-xrandr xorg-xsetroot
```

### Configure yay
```
git clone https://aur.archlinux.org/yay.git
> cd yay
> makepkg -si
```

### Oh my Zsh
```
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
chsh -s $(which zsh)
```

### Powerlevel10k
```
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k
```

### Icons y Font
```
sudo cp -r Gohu /usr/share/fonts/
sudo cp -r Hack /usr/share/fonts/
sudo cp -r Symbols/* /usr/share/fonts/
```

> #### Update Fonts
> ```
>  fc-cache -fv
>  ```

### Config bspwm & sxhkd
```
mkdir ~/.config/bspwm
cp ./bspwm/bspwmrc ~/.config/bspwm/
mkdir ~/.config/sxhkd
cp ./sxhkd/sxhkdrc ~/.config/sxhkd/
```

### Config Polybar
```
mkdir ~/.config/polybar
cp ./polybar/* ~/.config/polybar/
```

### Install & Confg plymout
```
 yay -S plymouth
```
> #### Add plymouth to /etc/mkinitcpio.conf
```
HOOKS=(base udev autodetect modconf block plymouth filesystems keyboard fsck)
```
> #### Update initramfs
```
sudo mkinitcpio -P
```
> Config Grub
```
sudo nano /etc/default/grub
GRUB_CMDLINE_LINUX_DEFAULT="loglevel=3 quiet splash "
```
> Update Grub
```
sudo grub-mkconfig -o /boot/grub/grub.cfg
```
> Select theme
```
sudo cp -r theme_arch /usr/share/plymouth/themes
sudo plymouth-set-default-theme -R theme_arch
```

### Login de keyitdev sddm-astronaut-theme
```
sh -c "$(curl -fsSL https://raw.githubusercontent.com/keyitdev/sddm-astronaut-theme/master/setup.sh)"
```

### Config Wallpaper
```
mkdir ~/Pictures/wallpaper
cp ./wallpaper/yomuyakadashi.png ~/Pictures/wallpaper/
```

### Config Neofetch
```
mkdir ~/Pictures/neofetch
mkdir ~/.config/neofetch
cp ./neofetch/neof2.png ~/Pictures/neofetch/
cp ./neofetch/config.conf ~/.config/neofetch/
```

### File customs
```
cp .xprofile ~/.xprofile
cp .zshrc ~/.zshrc
```

### Reboot
```
reboot
```

#### Notes
