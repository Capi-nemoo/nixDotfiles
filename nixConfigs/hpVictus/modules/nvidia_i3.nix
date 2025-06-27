{ config, lib, pkgs, ... }:
{

  # Enable OpenGL
  hardware.graphics = {
    enable = true;
  };

  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = true;

    # Use the NVidia open source kernel module (not to be confused with the
    # independent third-party "nouveau" open source driver).
    # Support is limited to the Turing and later architectures. Full list of 
    # supported GPUs is at: 
    # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus 
    # Only available from driver 515.43.04+
    open = false;

    # Enable the Nvidia settings menu,
	# accessible via `nvidia-settings`.
    nvidiaSettings = true;

    prime = {
# Make sure to use the correct Bus ID values for your system!
      offload.enable = true;
      sync.enable = false;
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
  };

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  environment.systemPackages = with pkgs; [
      glxinfo
      vulkan-tools
      nvitop
      cudatoolkit
      vulkan-loader
      mesa-demos
      (writeShellScriptBin "nvidia-offload" ''
       export __NV_PRIME_RENDER_OFFLOAD=1
       export __GLX_VENDOR_LIBRARY_NAME=nvidia
       export __VK_LAYER_NV_optimus=NVIDIA_only
       exec "$@"
       '')
  ];
}
