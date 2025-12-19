{ config, pkgs, ... }:

{
  # Use the proprietary NVIDIA driver
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;   # required for Wayland
    nvidiaSettings = true;

    # Good default on laptops; if you hit suspend issues, we can adjust.
    powerManagement.enable = true;
    powerManagement.finegrained = true;

    prime = {
      offload.enable = true;
      offload.enableOffloadCmd = true;

      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };

  # OpenGL + 32-bit (helps Steam/Wine/etc; harmless otherwise)
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # Wayland/NVIDIA reliability
  boot.kernelParams = [
    "nvidia-drm.modeset=1"
  ];

  boot.initrd.kernelModules = [ "nvidia" ];
}

