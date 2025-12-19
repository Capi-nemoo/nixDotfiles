{ config, pkgs, ... }:

{
  imports = [ 
  ../hardware-configuration.nix

  ../modules/audio.nix
  ../modules/fonts.nix
  ../modules/users.nix
  ../modules/locale.nix
  ../modules/packages.nix
  ../modules/services.nix
  ../modules/dev-tools.nix
  ../modules/bootloader.nix
  ../modules/networking.nix
  ../modules/nix-config.nix
  ../modules/hyprland.nix
  ../modules/pokit-agent.nix
  ../modules/bluetooth.nix
  ../modules/nvidia.nix
  ];

  system.stateVersion = "25.11";

}

