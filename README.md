# Arch Linux Installation Guide

## Arch Setup

This guide will walk you through installing Arch Linux using `archinstall` and configuring your system post-installation.

---

### Step 1: Boot into the Arch Linux Live ISO

1. **Boot** from the Arch Linux ISO on your computer.
2. **Verify Internet Connection**:
   ```bash
   ping -c 3 archlinux.org
   ```
   If you have a connection, proceed with `archinstall`.

### Step 2: Start the Installation with `archinstall`

Run the guided installer:
```bash
archinstall
```
The installer will guide you through the following setup options:

---

## Configurations in `archinstall`

### 1. Language and Keyboard Layout
   - **Language**: Set your preferred language (default: `English`).
   - **Keyboard Layout**: Choose a keyboard layout (`us` is default).

### 2. Mirror Region
   - Choose a mirror region for faster downloads (recommended: select the closest country).

### 3. Drives and Partitioning
   - **Drive Selection**: Select the drive (e.g., `/dev/sda`, `/dev/nvme0n1`).
   - **Partitioning Method**:
     - **Erase Disk**: Automatically erase and partition the drive (option for separate `/home` partition).
     - **Manual Partitioning**: Customize partitions (e.g., separate `/home` and `/var`).
   - **File System**: Choose a filesystem (recommended: `ext4`).

### 4. Encryption (Optional)
   - Enable or disable LUKS disk encryption.
   - If enabled, set an encryption passphrase (optional for enhanced security).

### 5. Bootloader
   - Select a bootloader (`grub`, `systemd-boot`, or none).

### 6. Hostname
   - Set a hostname for your system.

### 7. Root Password
   - Set a root password (leave empty to disable root).

### 8. Create User
   - **Username**: Create a new user account.
   - **Password**: Set a password for the user.
   - **Superuser Privileges**: Grant sudo privileges if needed.

### 9. Profile Selection
   - **Desktop Environment**: Select a DE (`gnome`, `kde`, `xfce`, or none).
   - **Additional Packages**: Install packages like `vim`, `git`, or others.
   - **Network Setup**: Choose a network manager (`NetworkManager`, `iwd`, etc.).
   - **Audio**: Select audio drivers (e.g., `pipewire`).

### 10. Network Configuration
   - **Network Interface**: Select your interface (e.g., `eth0`, `wlan0`).
   - **Wi-Fi Setup**: For Wi-Fi, select SSID and enter the password.

### 11. Timezone and Locale
   - **Timezone**: Set your timezone (e.g., `America/New_York`, `Asia/Riyadh`).
   - **Locale**: Configure locale settings (e.g., `en_US.UTF-8`).

### 12. Advanced Options
   - **Custom Kernel**: Install an alternative kernel (`linux-lts`, `linux-zen`).
   - **Disk Cache**: Enable disk caching like `fstrim.timer` for SSDs.

### 13. Install Arch Linux
   - Confirm your settings and begin the installation.
   - `archinstall` will format, partition, install, and configure Arch Linux based on your choices.

### 14. Post-Installation
   - Reboot into your Arch Linux system.
   - Remove the installation medium (ISO or USB).
   - Congratulations! Your Arch Linux installation is complete.

---

## After Installation Setup

1. **Update the System**
   ```bash
   sudo pacman -Syu
   ```

2. **Configure `pacman.conf`**
   - Edit the pacman config file:
     ```bash
     sudo nano /etc/pacman.conf
     ```
   - Uncomment `Color` and set `ParallelDownloads = 5`, then save.
   - Update packages:
     ```bash
     sudo pacman -Sy
     ```

3. **Optimize Mirrors for Faster Downloads**
   ```bash
   sudo pacman -S reflector
   sudo cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak
   sudo reflector --verbose --latest 10 --protocol https --sort rate --save /etc/pacman.d/mirrorlist
   sudo pacman -Sy
   ```

4. **Install Useful Packages**
   ```bash
   sudo pacman -S p7zip unrar tar rsync git neofetch htop exfat-utils fuse-exfat ntfs-3g flac jasper aria2
   ```

5. **Install `yay` AUR Helper**
   ```bash
   sudo pacman -S --needed git base-devel
   git clone https://aur.archlinux.org/yay.git
   cd yay
   makepkg -si
   ```

6. **Install and Configure Zsh**
   ```bash
   sudo pacman -S zsh
   chsh -s $(which zsh)
   ```
   - Log out and log back in to use Zsh.
   - **Install Oh-My-Zsh**:
     ```bash
     sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
     ```
   - Edit `~/.zshrc` to customize:
     ```bash
     nano ~/.zshrc
     ```
     - Change theme:
       ```bash
       ZSH_THEME="jispwoso"
       ```
     - Add plugins:
       ```bash
       plugins=(git rails ruby node npm zsh-autosuggestions zsh-syntax-highlighting fast-syntax-highlighting)
       ```

7. **Install VSCode**
   ```bash
   yay -S visual-studio-code-bin
   ```

8. **Install Brave Browser**
   ```bash
   yay -S brave-bin
   ```

9. **Install Warp Terminal**
   ```bash
   sudo sh -c "echo -e '\n[warpdotdev]\nServer = https://releases.warp.dev/linux/pacman/\$repo/\$arch' >> /etc/pacman.conf"
   sudo pacman-key -r "linux-maintainers@warp.dev"
   sudo pacman-key --lsign-key "linux-maintainers@warp.dev"
   sudo pacman -Sy warp-terminal
   ```

---

Enjoy your customized Arch Linux setup!
