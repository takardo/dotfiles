#!/bin/bash
clear
echo "🔥🔥🔥 nollem's install script v0.1.0 🔥🔥🔥"
sleep 1
echo "💚💚💚💚💚💚💚💚💚💚💚💚💚💚💚💚💚💚💚💚💚💚"
sleep 3
echo "Starting in"
sleep 1
echo "3"
sleep 1
echo "2"
sleep 1
echo "1"
sleep 1
echo "Start"
sleep 1
echo "Performing checks"
sleep 1
echo "Logged in as $USER"
sleep 1
bash memsp.sh
sleep 1
paplay /usr/share/sounds/freedesktop/stereo/message-new-instant.oga
./colortest.sh
sleep 2
paplay /usr/share/sounds/freedesktop/stereo/message-new-instant.oga
./count.sh
paplay /usr/share/sounds/freedesktop/stereo/message-new-instant.oga
bash pie.sh
paplay /usr/share/sounds/freedesktop/stereo/message-new-instant.oga
sleep 1
echo
echo "Tests completed successfully!"
sleep 1
echo "Package Install Script Starting..."
sleep 1
echo "Snapper Restore"
sleep 1
echo "Create Initial Restore Point"
sleep 1
echo "sudo snapper create -d "first""
echo "Uncomment in config to take snapshot"
#sudo snapper create -d "first"
echo "snapshot created!"
sleep 1
echo "Refresh zypper"
sleep 1
echo "sudo zypper ref"
sudo zypper ref
sleep 1
echo "System Update"
sleep 1
echo "sudo zypper --non-interactive dup"
sudo zypper --non-interactive dup
echo "Update finished!"
sleep 1
echo "Start Downloading Packages"
sleep 1
echo "Packages to install:"
sleep 1
echo "btop htop yakuake nvtop nvdock krita gimp kdenlive"
sleep 1
echo "fish tmux hyprland waybar wofi dunst thunar cbonsai"
sleep 1
echo "cava mpv mpd moc ranger lsd gzdoom bat figlet viu jp2a"
sleep 1
echo "neofetch fortune discord steam git kvantum-manager"
sleep 1
echo "qbittorrent python311-pygame hollywood neovim sl opi"
sleep 1
echo "w3m cowsay speedtest-cli calcurse sox virtualbox tint"
sleep 4
sudo zypper --non-interactive install btop htop yakuake nvtop nvdock fish tmux hyprland waybar wofi dunst thunar cbonsai cava mpv mpd moc ranger lsd gzdoom bat figlet viu neofetch fortune discord steam git kvantum-manager qbittorrent python311-pygame hollywood neovim w3m cowsay speedtest-cli calcurse sox virtualbox tint sl opi jp2a krita gimp kdenlive
sleep 1
echo "Add $USER to vboxusers group"
sleep 1
sudo usermod -a -G vboxusers $USER
sleep 1
echo "Main Packages finished installing!"
sleep 1
echo "Preparing Vibe"
sleep 2
echo "Optimist" | figlet
sleep 1
echo "Installing Optimist for lolcat"
sleep 1
echo "sudo gem install optimist -v 3.0.0"
sudo gem install optimist -v 3.0.0
sleep 1
echo "Optimist finished installing!" | lolcat
sleep 1
mocp -S; mocp -l ./THBD.mp3 -v 20
sleep 1
timeout 2 ./nol.sh
echo
sleep 2
timeout 4 ./wall.sh
echo
sleep 1
./budpic.sh
sleep 1
fortune | cowsay
sleep 1
./dogs.sh
sleep 1
viu ineedmoney.png
sleep 1
viu pika.png
sleep 1
viu cocanevult.png
sleep 1
viu dw.png
sleep 1
./me.sh
sleep 1
neofetch | lolcat -a -d 1
sleep 4
paplay /usr/share/sounds/freedesktop/stereo/message-new-instant.oga
echo "Vibes Have Been Installed!"
sleep 1
echo "Oh My Bash" | figlet -f slant
sleep 1
echo "Install Oh My Bash"
sleep 1
bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"
sleep 1
echo "Oh-My-Bash installed"
sleep 1
echo "DOOM" | figlet -f Doom
sleep 1
echo "Create soundfont folder for gzdoom"
sleep 1
echo "mkdir /home/tumbleweed/.config/gzdoom/soundfonts"
sleep 1
mkdir /home/tumbleweed/.config/gzdoom/soundfonts
echo "Directory created"
sleep 1
echo "Copy Arachno soundfont to gzdoom soundfont folder"
echo "sudo cp /home/tumbleweed/MIDI/soundfonts/ARACHNO.sf2 /home/tumbleweed/.config/gzdoom/soundfonts"
sudo cp /home/tumbleweed/MIDI/soundfonts/ARACHNO.sf2 /home/tumbleweed/.config/gzdoom/soundfonts
sleep 1
echo "Done with soundfont"
sleep 1
echo "Move Doom Wads to gzdoom folder"
sleep 1
echo "sudo cp /home/tumbleweed/DoomWADS/DOOM.WAD /home/tumbleweed/DoomWADS/DOOM2.WAD /home/tumbleweed/DoomWADS/brutalv21.pk3 /home/tumbleweed/.config/gzdoom"
sudo cp /home/tumbleweed/DoomWADS/DOOM.WAD /home/tumbleweed/DoomWADS/DOOM2.WAD /home/tumbleweed/DoomWADS/brutalv21.pk3 /home/tumbleweed/.config/gzdoom
sleep 1
echo "DOOM installed"
sleep 1
echo "Binaries" | figlet
sleep 1
echo "Copy binaries to /usr/bin/"
sleep 1
echo "sudo cp /home/tumbleweed/pfetch/pfetch /home/tumbleweed/tty-clock/tty-clock /home/tumbleweed/tiv /home/tumbleweed/cmatrix/cmatrix /usr/bin"
sudo cp /home/tumbleweed/pfetch/pfetch /home/tumbleweed/tty-clock/tty-clock /home/tumbleweed/TerminalImageViewer/tiv /home/tumbleweed/cmatrix/cmatrix /usr/bin
sleep 1
pfetch | lolcat -a -d 1
sleep 1
echo "Binaries installed"
sleep 1
echo "grub2" | figlet
sleep 1
echo "Copy grub2 theme"
sleep 1
echo "sudo cp -r /home/tumbleweed/grubThemes /boot/grub2/themes"
sudo cp -r /home/tumbleweed/grubThemes/Acheron_cn /home/tumbleweed/grubThemes/Hanya_cn /home/tumbleweed/grubThemes/Jingliu_cn /boot/grub2/themes
sleep 1
echo "Grub theme installed, you still need to apply the theme in Yast Bootloader" | lolcat -a -d 1
sleep 1
echo "nerd fonts" | figlet
sleep 1
echo "Copying nerd fonts to /usr/share/fonts/"
sleep 1
echo "sudo cp -r /home/tumbleweed/nerdFonts/3270 /home/tumbleweed/nerdFonts/Recursive /home/tumbleweed/nerdFonts/SourceCodePro /usr/share/fonts"
sudo cp -r /home/tumbleweed/nerdFonts/3270 /home/tumbleweed/nerdFonts/Recursive /home/tumbleweed/nerdFonts/SourceCodePro /usr/share/fonts
sleep 1
echo "Nerd fonts installed, they still need to be applied in konsole" | lolcat -a -d 1
sleep 1
echo "Figlet Fonts" | figlet
sleep 1
echo "Copy Figlet fonts to /usr/share/figlet"
sleep 1
echo "sudo cp -r /home/tumbleweed/figlet-fonts /usr/share/figlet"
sudo cp -r /home/tumbleweed/figlet-fonts /usr/share/figlet
sleep 1
echo "Figlet fonts installed"
sleep 1
echo "Flatpak" | figlet
sleep 1
echo "sudo flatpak update"
sudo flatpak update
sleep 1
echo "OBS-Studio" | figlet -t
sleep 1
echo "Install OBS-Studio"
sleep 1
echo "sudo flatpak install com.obsproject.Studio"
sudo flatpak install com.obsproject.Studio
sleep 1
echo "OBS-Studio installed"
sleep 1
echo "Lutris" | figlet
sleep 1
echo "Installing Lutris"
sleep 1
echo "sudo flatpak install net.lutris.Lutris"
sudo flatpak install net.lutris.Lutris
sleep 1
echo "Lutris installed"
sleep 1
echo "Space Cadet Pinball" | figlet -t
sleep 1
echo "Installing Space Cadet Pinball"
sleep 1
echo "sudo flatpak install com.github.k4zmu2a.spacecadetpinball"
sudo flatpak install com.github.k4zmu2a.spacecadetpinball
sleep 1
echo "Space Cadet Pinball installed"
sleep 1
echo "Fightcade" | figlet
sleep 1
echo "Install Fightcade"
sleep 1
echo "sudo flatpak install com.fightcade.Fightcade"
sudo flatpak install com.fightcade.Fightcade
sleep 1
echo "Fightcade installed"
sleep 1
echo "VLC" | figlet
sleep 1
echo "Install VLC"
sleep 1
echo "sudo flatpak install org.videolan.VLC"
sudo flatpak install org.videolan.VLC
sleep 1
echo "VLC installed"
sleep 1
echo "DOSBOX-X" | figlet -t
sleep 1
echo "Install Dosbox-X"
sleep 1
sudo flatpak install flathub com.dosbox_x.DOSBox-X
sleep 1
echo "Lil' DosBox-X installed 🤠"
sleep 1
echo "eDuke32" | figlet -t
sleep 1
echo "/home/tumbleweed/eduke32"
mkdir /home/tumbleweed/eduke32
sleep 1
echo "cp /home/tumbleweed/DUKE3D.GRP /home/tumbleweed/eduke32"
cp /home/tumbleweed/DUKE3D.GRP /home/tumbleweed/eduke32
sleep 1
echo "Download eDuke32"
sleep 1
echo "wget https://dukeworld.com/eduke32/eduke32_current.zip /home/tumbleweed/eDuke32 --directory-prefix=/home/tumbleweed/eduke32"
sleep 1
wget https://dukeworld.com/eduke32/eduke32_current.zip /home/tumbleweed/eDuke32 --directory-prefix=/home/tumbleweed/eduke32
sleep 1
echo "Move duke3d.grp to game directory"
sleep 1
echo "cp /home/tumbleweed/DUKE3D.GRP /home/tumbleweed/eduke32/eduke32_current"
cp /home/tumbleweed/DUKE3D.GRP /home/tumbleweed/eduke32/eduke32_current
sleep 1
echo "eDuke32 downloaded"
sleep 1
echo "hyprland" | figlet
sleep 1
echo "Copy hyprland config"
sleep 1
echo "sudo cp /home/tumbleweed/hyprland.conf /home/tumbleweed/.config/hypr"
sudo cp /home/tumbleweed/hyprlandConfig/hyprland.conf /home/tumbleweed/.config/hypr
sleep 1
echo "Done with hyprland config"
sleep 1
echo "Copy home config folder"
sleep 1
echo "sudo cp -r /home/tumbleweed/LinuxBackups/.config /home/tumbleweed"
sudo cp -r /home/tumbleweed/LinuxBackups/.config /home/tumbleweed
sleep 1
echo "Done with config folder"
sleep 1
echo "Copy .bashrc folder"
echo "sudo cp /home/tumbleweed/LinuxBackups/.bashrc /home/tumbleweed"
sudo cp /home/tumbleweed/LinuxBackups/.bashrc /home/tumbleweed
sleep 1
echo "Done copying .bashrc folder"
sleep 1
echo "Copy Cava config"
echo "sudo cp /home/tumbleweed/cava/config /home/tumbleweed/.config/cava"
sleep 1
sudo cp /home/tumbleweed/cava/config /home/tumbleweed/.config/cava
sleep 1
echo "Install Script Is Finished!" | figlet -f slant -t
sleep 1
paplay /usr/share/sounds/freedesktop/stereo/message-new-instant.oga
echo "Completed successfuly"
sleep 1
echo "Exiting..."
sleep 1
tiv tux.png
sleep 1
./budpic.sh
sleep 1
viu cats.jpg
sleep 2
viu dogs.jpg
sleep 2
echo "To install MullvadVPN, run sudo /sbin/yast2 sw_single  /home/tumbleweed/mullvad/MullvadVPN-2024.4_x86_64.rpm"
sleep 3
exit 0
