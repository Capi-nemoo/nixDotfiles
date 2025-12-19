{ config, pkgs, ... }:

{
  # Enable fonts
  fonts = {
    # Font packages to install
    packages = with pkgs; [
      # Basic and commonly used fonts
      dejavu_fonts
      noto-fonts
      liberation_ttf
      
      # Programming fonts
      nerd-fonts.fira-code
      nerd-fonts.hack
      
      # Icon fonts for status bars and applications
      font-awesome
    ];
    
    # Font configuration
    fontconfig = {
      defaultFonts = {
        serif = [ "DejaVu Serif" "Noto Serif" ];
        sansSerif = [ "DejaVu Sans" "Noto Sans" ];
        monospace = [ "JetBrains Mono" "DejaVu Sans Mono" ];
        emoji = [ "Noto Color Emoji" ];
      };
      
      # Enable anti-aliasing and hinting
      antialias = true;
      hinting.enable = true;
      
      # Force certain fonts to use certain hinting
      hinting.autohint = false;
      
      # Use slight RGB hinting
      subpixel.rgba = "rgb";
    };
  };
}
