{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [ polkit_gnome ];

  systemd.user.services.polkit-gnome-auth = {
    description = "Polkit authentication agent";
    wantedBy = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    serviceConfig.ExecStart =
      "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
  };
}
