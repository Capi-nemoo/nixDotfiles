{ config, pkgs, ... }:

{
  imports = [ ../hardware-configuration.nix ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "sway-nouveau";
  networking.networkmanager.enable = true;

  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";

  users.users.eve = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    shell = pkgs.bash;
  };

  # ✅ Habilitamos GDM para iniciar sesión gráfica
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.displayManager.gdm.wayland = true;

  # ✅ Habilitamos Sway como entorno de escritorio
  programs.sway.enable = true;

  # ✅ Drivers gráficos open source
  services.xserver.videoDrivers = [ "nouveau" ];

  # ✅ Básicos para depurar
  environment.systemPackages = with pkgs; [
    vim git foot wayland-utils
  ];

  system.stateVersion = "25.05";
}

