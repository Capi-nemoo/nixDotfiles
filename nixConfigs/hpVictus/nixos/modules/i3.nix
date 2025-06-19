{ config, lib, pkgs, ... }:

{
  services.xserver = {
    enable = true;
    
    displayManager = {
      lightdm.enable = true;  # Basic display manager
      defaultSession = "none+i3";
    };
    
    windowManager.i3 = {
      enable = true;
      package = pkgs.i3;
      extraPackages = with pkgs; [
        i3status      # status bar
        i3lock        # screen locker
        dmenu         # application launcher
      ];
    };
  };

  environment.systemPackages = with pkgs; [
    xorg.xrandr     # for monitor configuration
    xorg.xmodmap    # for keyboard mapping
  ];
}
