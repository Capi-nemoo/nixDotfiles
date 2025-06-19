{ config, pkgs, lib, ... }:

let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-25.05.tar.gz";
in
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
        (import "${home-manager}/nixos")
    ];

#
#______     ______     ______   .___________. __        ______        ___       _______   _______ .______      
#   _  \   /  __  \   /  __  \  |           ||  |      /  __  \      /   \     |       \ |   ____||   _  \     
#  |_)  | |  |  |  | |  |  |  | `---|  |----`|  |     |  |  |  |    /  ^  \    |  .--.  ||  |__   |  |_)  |    
#   _  <  |  |  |  | |  |  |  |     |  |     |  |     |  |  |  |   /  /_\  \   |  |  |  ||   __|  |      /     
#  |_)  | |  `--'  | |  `--'  |     |  |     |  `----.|  `--'  |  /  _____  \  |  '--'  ||  |____ |  |\  \----.
#______/   \______/   \______/      |__|     |_______| \______/  /__/     \__\ |_______/ |_______|| _| `._____|
#                                                                                                              
#

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  nix.settings.experimental-features = [ "nix-command" "flakes" ]; 

  networking.networkmanager.enable = true;

  i18n.defaultLocale = "en_US.UTF-8";

  time.timeZone = "America/New_York";

services.xserver.videoDrivers = [ "nvidia" ];

hardware.graphics.enable = true;

hardware.nvidia = {
  modesetting.enable = true;
  open = false;
  nvidiaSettings = true;
    powerManagement.enable = true;
};

  environment.sessionVariables = {
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    GBM_BACKEND = "nvidia-drm";
    LIBVA_DRIVER_NAME = "nvidia";
    NIXOS_OZONE_WL = "1";
    WLR_NO_HARDWARE_CURSORS = "1";
    WLR_RENDERER_ALLOW_SOFTWARE = "1";
  };

  services.xserver.enable = true;
  services.gnome.gnome-keyring.enable = true;

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "sway";
        user = "capi";
      };
    };
  };

  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };
  
  systemd.user.services.kanshi = {
    description = "kanshi daemon";
    serviceConfig = {
      Type = "simple";
      ExecStart = ''${pkgs.kanshi}/bin/kanshi -c kanshi_config_file'';
    };
  };

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  services.printing.enable = true;

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
   };

services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.capi = {
    isNormalUser = true;
    description = "capi";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      kdePackages.kate
    ];
  };

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;


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
  nvitop
  cudatoolkit
  vulkan-loader
  vulkan-tools
  mesa-demos
  glxinfo

    (writeShellScriptBin "nvidia-offload" ''
      export __NV_PRIME_RENDER_OFFLOAD=1
      export __GLX_VENDOR_LIBRARY_NAME=nvidia
      export __VK_LAYER_NV_optimus=NVIDIA_only
      exec "$@"
    '')

  # === decoders? ===
    libva
    vaapiVdpau
    vdpauinfo
    libvdpau-va-gl
    ffmpeg
];

fonts.packages = with pkgs; [
  dejavu_fonts
  font-awesome
  nerd-fonts.fira-code
  nerd-fonts.hack
  nerd-fonts.jetbrains-mono
  noto-fonts
];



programs.zsh = {
  enable = true;
  autosuggestions.enable = true;
  syntaxHighlighting.enable = true;
      ohMyZsh = {
         enable = true;
         theme = "robbyrussell";
         plugins = [
           "git"
           "npm"
           "history"
           "node"
           "rust"
           "deno"
         ];
      };
};

 nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  users.defaultUserShell = pkgs.zsh;
  services.openssh.enable = true;
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;

    users.users.eve = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Allow sudo
    shell = pkgs.bashInteractive;
  };

  home-manager.users.capi = { pkgs, ... }: {
    home.packages = [ pkgs.atool pkgs.httpie ];
    programs.bash.enable = true;
    home.stateVersion =  "25.05";
};
  system.stateVersion = "25.05"; # Did you read the comment?
}


