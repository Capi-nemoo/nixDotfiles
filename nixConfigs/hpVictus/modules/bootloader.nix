{ config, pkgs, ... }:

{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
    boot.extraModulePackages = with config.boot.kernelPackages; [
    v4l2loopback
  ];
  boot.extraModprobeConfig = ''
    options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1
  '';
  # lightweight GNOME agent that works everywhere
environment.systemPackages = with pkgs; [ polkit_gnome ];

# autostart it for every graphical session
systemd.user.services.polkit-gnome-auth = {
  description = "Polkit authentication agent";
  wantedBy    = [ "graphical-session.target" ];
  after       = [ "graphical-session.target" ];
  serviceConfig.ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
};

hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
services.blueman.enable = true;


}
