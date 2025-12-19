{ config, pkgs, ... }:

{
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;
  
  users.users = {
    capi = {
      initialPassword = "1";
      isNormalUser = true;
      description = "capi";
      extraGroups = [ 
        "wheel"           # Enable sudo
        "networkmanager"  # Network management
        "video"           # For brightness control
        "audio"           # Audio control
      ];
    };
  };
}
