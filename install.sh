#!/bin/bash

# Verificar permisos
if [[ $EUID -ne 0 ]]; then
    echo "Por favor, ejecuta este script como administrador (sudo)." >&2
    exit 1
fi

# Actualizar el sistema
echo "Actualizando el sistema..."
sudo pacman -Syu --noconfirm

# Instalar aplicaciones y herramientas
echo "Instalando aplicaciones generales..."
sudo pacman -S bspwm sxhkd kitty picom zsh feh thunar ranger mlocate imagemagick powerlevel10k neofetch polybar plymouth unzip --noconfirm

# Icons y Font
echo "Extrayendo Gohu.zip"
unzip Gohu.zip -d ~/.fonts/
echo "Extrayendo Iconos"
unzip NerdFontsSymbolsOnly.zip -d ~/.fonts/

# Actualizar fuentes
echo "Actualizando la caché de fuentes..."
fc-cache -fv
echo "Fuentes instaladas correctamente."

# Crear carpetas y copiar archivos
echo "Configurando bspwm y sxhkd..."
mkdir -p ~/.config/bspwm ~/.config/sxhkd
cp ./bspwm/bspwmrc ~/.config/bspwm/
cp ./sxhkd/sxhkdrc ~/.config/sxhkd/

echo "Configurando Polybar..."
mkdir -p ~/.config/polybar
cp ./polybar/* ~/.config/polybar/

echo "Configurando Plymouth..."
sudo cp -r theme_arch /usr/share/plymouth/themes/
sudo plymouth-set-default-theme -R theme_arch

echo "Configurando fondo..."
mkdir -p ~/Pictures/wallpaper
cp ./wallpaper/wallp.jpg ~/Pictures/wallpaper/

echo "Reemplazando configuraciones..."
cp .xprofile ~/.xprofile
cp .zshrc ~/.zshrc

echo "Configurando Neofetch..."
mkdir -p ~/Pictures/neofetch
cp ./neofetch/neof.png ~/Pictures/neofetch/
cp ./neofetch/config.conf ~/.config/neofetch/

echo "Configurando Kitty..."
cp ./kitty/kitty.conf ~/.config/kitty/

# Instalación opcional
while true; do
    read -p "¿Deseas instalar lxappearance, lxsession y arc-gtk-theme? (s/n): " instalar_temas
    case $instalar_temas in
        [sS]*) 
            echo "Instalando herramientas de apariencia..."
            sudo pacman -S lxappearance lxsession arc-gtk-theme --noconfirm
            break
            ;;
        [nN]*) 
            echo "Saltando la instalación de herramientas de apariencia."
            break
            ;;
        *) 
            echo "Por favor, responde con 's' o 'n'."
            ;;
    esac
done

echo "Script completado exitosamente."


