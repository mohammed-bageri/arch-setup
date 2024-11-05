#!/bin/bash

# Update the system
echo "Updating the system..."
sudo pacman -Syu --noconfirm

# Edit pacman configuration for color and parallel downloads
echo "Configuring pacman..."
sudo sed -i 's/^#Color/Color/' /etc/pacman.conf
sudo sed -i 's/^#ParallelDownloads = 5/ParallelDownloads = 5/' /etc/pacman.conf
sudo pacman -Sy

# Setup fastest mirrors
echo "Setting up the fastest mirrors..."
sudo pacman -S --noconfirm reflector
sudo cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak
sudo reflector --verbose --latest 10 --protocol https --sort rate --save /etc/pacman.d/mirrorlist
sudo pacman -Sy

# Install useful packages
echo "Installing useful packages..."
sudo pacman -S --noconfirm p7zip unrar tar rsync git neofetch htop exfat-utils fuse-exfat ntfs-3g flac jasper aria2

# Install yay AUR helper
echo "Installing yay..."
sudo pacman -S --needed --noconfirm git base-devel
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si --noconfirm
cd ..

# Install Zsh and configure as default shell
echo "Installing and configuring Zsh..."
sudo pacman -S --noconfirm zsh
chsh -s $(which zsh)
echo "Log out and log back in to start using Zsh."

# Install Oh-My-Zsh and configure plugins and theme
echo "Installing Oh-My-Zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
echo "Configuring Oh-My-Zsh plugins and theme..."
sed -i 's/ZSH_THEME=".*"/ZSH_THEME="jispwoso"/' ~/.zshrc
echo "Adding plugins to .zshrc"
cat <<EOT >> ~/.zshrc
plugins=(git rails ruby node npm zsh-autosuggestions zsh-syntax-highlighting fast-syntax-highlighting)
EOT

# Install Zsh plugins
echo "Installing Zsh plugins..."
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting

# Install additional applications
echo "Installing VSCode, Brave Browser, and Warp Terminal..."
yay -S --noconfirm visual-studio-code-bin brave-bin
sudo sh -c "echo -e '\n[warpdotdev]\nServer = https://releases.warp.dev/linux/pacman/\$repo/\$arch' >> /etc/pacman.conf"
sudo pacman-key -r "linux-maintainers@warp.dev"
sudo pacman-key --lsign-key "linux-maintainers@warp.dev"
sudo pacman -Sy warp-terminal

echo "Setup complete. Enjoy your Arch Linux system!"
