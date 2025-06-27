{pkgs, ...}:

{
environment.systemPackages = with pkgs; [

# === Core Utilities ===
tree
tmux
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

  (pkgs.wrapOBS {
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-backgroundremoval
      obs-pipewire-audio-capture
    ];
  })

# === Font Configuration ===
fontconfig

  ];

programs.steam = {
  enable = true;
  remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
  dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
};

programs.neovim = { 
  enable = true; 
  defaultEditor = true;
  viAlias = true;
  vimAlias = true;
};

}
