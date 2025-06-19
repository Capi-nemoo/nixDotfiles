{ config, pkgs, ... }:

{
  nix = {
    # Enable flakes and new commands
    settings.experimental-features = [ "nix-command" "flakes" ];
    
    # Auto optimize store to save space
    settings.auto-optimise-store = true;
    
    # Garbage collection configuration
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    
    # Trusted users who can run nix commands
    settings.trusted-users = [ "root" "capi" ];
    
    # Allow building unfree packages
    settings.allowed-users = [ "@wheel" ];
  };

  # Allow unfree packages system-wide
  nixpkgs.config = {
    allowUnfree = true;
    
    # Enable additional package repositories if needed
    # packageOverrides = pkgs: {
    #   nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
    #     inherit pkgs;
    #   };
    # };
  };

  # System-level state version
  # Do not change this after initial setup
  system.stateVersion = "25.05";
}
