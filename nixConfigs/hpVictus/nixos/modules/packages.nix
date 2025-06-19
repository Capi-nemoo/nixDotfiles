{pkgs, ...}:

{
environment.systemPackages = with pkgs; [

# === Core Utilities ===
git
htop
btop
unzip
wget
zsh

# === Editors & Terminals ===
alacritty
ghostty
lunarvim
windsurf
neovim
vim

# === GUI Components ===
rofi
sway
swaylock
swayidle
waybar
wofi
xwayland
wl-clipboard
grim
slurp

# === Applications ===
arandr
blueman
discord-ptb
firefox
chromium
logseq
pavucontrol
obsidian

# === Gaming ===
steam
lutris
wine
winetricks
heroic
bottles

# === Development Tools ===
gh
nodejs_20
openssl
pnpm
watchexec

# === Font Configuration ===
fontconfig

# === Nvidia Packages ===
  ];

programs.steam = {
  enable = true;
  remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
  dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
};

}
