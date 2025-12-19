{ config, pkgs, ... }:

{

  # Audio stack (usually already in your audio.nix, but harmless if duplicated)
  # Prefer keeping PipeWire in audio.nix; remove here if you already do it there.
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    jack.enable = true;
  };

  environment.systemPackages = with pkgs; [
    pavucontrol
  ];
}

