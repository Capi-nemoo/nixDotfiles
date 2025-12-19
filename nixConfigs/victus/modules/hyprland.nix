{ config, pkgs, ... }:

{
  # Hyprland (system-level)
  programs.hyprland.enable = true;

  # Wayland portals (needed for screenshots, screen sharing, file pickers, etc.)
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal-gtk
    ];
  };

  # Basic session tools commonly needed on Hyprland
  environment.systemPackages = with pkgs; [
    waybar
    hyprpaper
    hyprlock
    hypridle
    xdg-utils
    wl-clipboard
    grim
    slurp
    swappy
    wofi
    kitty
  ];


  # Login manager: greetd -> Hyprland
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --cmd Hyprland";
        user = "greeter";
      };
    };
  };

  # Make sure no X11 display manager conflicts (keep XWayland support if you want it)
  services.xserver.enable = false;
  services.dbus.enable = true;
  security.polkit.enable = true;
  programs.dconf.enable = true;
}
