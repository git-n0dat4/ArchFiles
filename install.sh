#!/bin/bash

# Actualizar el sistema
echo "Actualizando el sistema..."
sudo pacman -Syu --noconfirm

# Instalar aplicaciones y herramientas
echo "Instalando aplicaciones generales..."
sudo pacman -S bspwm sxhkd kitty picom zsh feh thunar ranger mlocate imagemagick neofetch polybar plymouth unzip xorg-xrandr xorg-xsetroot --noconfirm
chsh -s $(which zsh)

#Oh my Zsh
echo "Instando Oh my Zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Powerlevel10k
echo "powerlevel10k"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k

# Agregando Yay
echo "Instalando yay"
git clone https://aur.archlinux.org/yay.git
#location=$(pwd)
#sudo chown -R test $location
cd yay
makepkg -si
#sudo chown -R root $location
cd ..

# Icons y Font
echo "Copiando Gohu"
sudo cp -r Gohu /usr/share/fonts/

echo "Extrayendo Iconos"
sudo cp -r Symbols/* /usr/share/fonts/

# Actualizar fuentes
echo "Actualizando la caché de fuentes..."
fc-cache -fv
echo "Fuentes instaladas correctamente."

# Crear carpetas y copiar archivos

#echo "Configurando bspwm y sxhkd..."
mkdir ~/.config/bspwm
cp ./bspwm/bspwmrc ~/.config/bspwm/
mkdir ~/.config/sxhkd
cp ./sxhkd/sxhkdrc ~/.config/sxhkd/

#echo "Configurando Polybar..."
mkdir ~/.config/polybar
cp ./polybar/* ~/.config/polybar/

#echo "Configurando Plymouth..."
sudo cp -r theme_arch /usr/share/plymouth/themes/
sudo plymouth-set-default-theme -R theme_arch

#echo "Configurando fondo..."
mkdir ~/Pictures/wallpaper
cp ./wallpaper/wallp.jpg ~/Pictures/wallpaper/

p10k configure

#echo "Reemplazando configuraciones..."
cp .xprofile ~/.xprofile
cp .zshrc ~/.zshrc

#echo "Configurando Neofetch..."
mkdir ~/Pictures/neofetch
mkdir ~/.config/neofetch
cp ./neofetch/neof.png ~/Pictures/neofetch/
cp ./neofetch/config.conf ~/.config/neofetch/

# echo "Configurando Kitty..."
mkdir ~/.config/kitty
cp ./kitty/* ~/.config/kitty/

echo "Script completado exitosamente."
