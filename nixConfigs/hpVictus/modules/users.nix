{ config, pkgs, ... }:

{
  # Set default shell for all users
  users.defaultUserShell = pkgs.zsh;
  
  # Define user accounts
  users.users = {
    # Main user account
    capi = {
      isNormalUser = true;
      description = "capi";
      extraGroups = [ 
        "wheel"           # Enable sudo
        "networkmanager"  # Network management
        "video"           # For brightness control
        "audio"           # Audio control
      ];
      shell = pkgs.zsh;
      packages = with pkgs; [
        # User-specific packages
        kdePackages.kate
        # Add more user-specific packages here
      ];
    };

    # Optional additional user
    # You can uncomment this if needed or add more users
    # eve = {
    #   isNormalUser = true;
    #   extraGroups = [ "wheel" ];
    #   shell = pkgs.bashInteractive;
    # };
  };

  # Enable zsh for better shell experience
  programs.zsh = {
    enable = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    ohMyZsh = {
      enable = true;
      theme = "robbyrussell";
      plugins = [
        "git"
        "npm"
        "history"
        "node"
        "rust"
        "deno"
      ];
    };
  };

   home-manager.users.capi = { pkgs, ... }: {
     home.packages = [ pkgs.atool pkgs.httpie ];
     programs.bash.enable = true;
     home.stateVersion = "25.05";
   };
}
