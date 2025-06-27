{ config, pkgs, ... }:

{
  imports = [
    ../hardware-configuration.nix
    ../modules/audio.nix
    ../modules/dev-tools.nix
    ../modules/bootloader.nix
    ../modules/fonts.nix
    ../modules/i3.nix
    ../modules/locale.nix
    ../modules/networking.nix
    ../modules/nix-config.nix
    ../modules/packages.nix
    ../modules/services.nix
    ../modules/users.nix
    ../modules/nvidia_i3.nix
  ];

  # Host-specific configurations can go here
  networking.hostName = "capi"; # Set your hostname
}
