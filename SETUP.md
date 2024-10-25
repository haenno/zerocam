# Documentation for the setup of the Raspberry Pi Zero W

1. Install Raspbian to a case and add the camera module
2. Write the Raspbian image to the SD card with official Raspberry Pi Imager
3. Boot the Raspberry Pi Zero W with the SD card (be patient)
4. Connect to the Raspberry Pi Zero W with SSH
5. Update the Raspberry Pi Zero W
   1. `sudo apt update`
   2. `sudo apt upgrade`
   3. `sudo apt full-upgrade`
   4. `sudo apt autoremove`
   5. `sudo apt autoclean`
   6. `sudo rpi-update`
6. Reboot the Raspberry Pi Zero W
7. Go into Raspi-Config
   1. Disable Raspberry Pi Connect, VNC, Remote GPIO
   2. Set boot to console only
   3. Expand the file system
8. Reboot again
9. Remove resource hungry services and unwanted packages:
   1. `sudo apt remove colord pipewire wireplumber`
   2. `sudo apt purge xserver* lightdm* raspberrypi-ui-mods vlc* lxde* chromium* desktop* gnome* gstreamer* gtk* hicolor-icon-theme* lx* mesa* pulse*`
   3. `sudo systemctl disable cups-browsed.service cups.service ModemManager.service triggerhappy.service avahi-daemon.service bluetooth`
   4. `sudo apt autoremove`
10. Install Ligthttpd
    1. `sudo apt install lighttpd`
    2. `sudo systemctl enable lighttpd.service`
11. Setup git update script: WIP
    1. Create ssh key: `ssh-keygen -t ed25519 -C "your_email@example.com"`, `eval "$(ssh-agent -s)"` and `ssh-add ~/.ssh/id_ed25519`
    2. Add ssh key to GitHub
    3. CD into home, then: `git clone git@github.com:haenno/zerocam.git`
    4. Make update script executable: `chmod +x ~/zerocam/github_update.sh`
    5. Add script to crontab: `crontab -e` and add `*/5* ** * ~/zerocam/github-update.sh >> ~/zerocam/github-update.log 2>&1
12. Install picam `sudo apt install python3-picamera2 python3-full`
