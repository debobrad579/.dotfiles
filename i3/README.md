## Prerequisite Arch Configuration

### Configure Wifi

1. Install NetworkManager:
```bash
sudo pacman -S networkmanager
```

2. Enable NetworkManager:
```bash
sudo systemctl enable --now NetworkManager
```

3. Connect to wifi:
```bash
# List networks
nmcli device wifi list

# Connect device
nmcli device wifi connect <SSID> password <PASSWORD>
```

4. Generate mirrors (optional but recommended):
```bash
sudo pacman -S reflector

sudo cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak

sudo reflector \
    --country CA,US \
    --latest 20 \
    --protocol https \
    --sort rate \
    --age 12 \
    --save /etc/pacman.d/mirrorlist
```

### Install Pipewire (Audio)

```bash
sudo pacman -S --needed pipewire pipewire-alsa pipewire-pulse wireplumber

# Optional:
sudo pacman -S pipewire-jack
```

### Configure Bluetooth

1. Install necessary packages:
```bash
sudo pacman -S bluez bluez-utils
```

2. Enable bluetooth:
```bash
sudo systemctl enable --now bluetooth
```

3. Connect bluetooth devices:
```bash
bluetoothctl

scan on
pair <MAC>
connect <MAC>
trust <MAC>
```

### Install Graphics Drivers

```bash
# Intel
sudo pacman -S --needed mesa vulkan-intel intel-media-driver

# AMD
sudo pacman -S --needed mesa vulkan-radeon xf86-video-amdgpu

# Nvidia (Open Source)
sudo pacman -S --needed mesa vulkan-nouveau xf86-video-nouveau

# Nvidia (Proprietary)
sudo pacman -S --needed nvidia-open nvidia-utils
```

### Install Xorg Display Server

```bash
sudo pacman -S --needed xorg-server xorg-xinit xorg-xrandr
```

### Configure Docker

1. Install docker:
```bash
sudo pacman -S docker
```

2. Enable docker:
```bash
sudo systemctl enable --now docker
```

3. Add user to the `docker` group:
```bash
sudo usermod -aG docker $USER
newgrp docker # Or relog to apply changes
```

### Configure Printing (Optional)

1. Install necessary packages:
```bash
sudo pacman -S --needed cups cups-pk-helper system-config-printer
```

2. Enable CUPS:
```bash
sudo systemctl enable --now cups
```

3. Add user to the `lp` group:
```bash
sudo usermod -aG lp $USER
newgrp lp # Or relog to apply changes
```

## Installation

1. Install dependencies (required for i3 and i3blocks config):
```bash
sudo pacman -S --needed \
    i3-wm \
    i3blocks \
    i3lock \
    xss-lock \
    picom \
    rofi \
    playerctl \
    unclutter
```

2. Install fonts and icons:
```bash
sudo pacman -S --needed \
    noto-fonts \
    noto-fonts-cjk \
    noto-fonts-extra \
    ttf-jetbrains-mono-nerd \
    papirus-icon-theme
```

3. Install applications:
```bash
sudo pacman -S --needed alacritty thunar firefox spotify-launcher
```

4. Install other useful utilities (optional but recommended):
```bash
# Core utilities
sudo pacman -S --needed base-devel wget openssh unzip xdg-utils xclip

# System monitoring
sudo pacman -S --needed htop fastfetch
```

5. Symlink the config:
```bash
cd ~/.dotfiles
stow i3
```

6. Install a display manager (optional but recommended):

    - Option 1 - Lightdm:
    ```bash
    sudo pacman -S lightdm lightdm-gtk-greeter
    sudo systemctl enable lightdm
    ```

    - Option 2 - Ly:
    ```bash
    sudo pacman -S ly
    sudo systemctl enable ly@tty2
    ```

    - Option 3 - No display manager:
    ```bash
    echo "exec i3" > ~/.xinitrc # ~/.xinitrc should contain all startup commands
    startx
    ```

7. Reboot:
```bash
reboot
```
