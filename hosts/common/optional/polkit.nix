{
  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = let
      gs = "graphical-session.target";
    in {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = [gs];
      wants = [gs];
      after = [gs];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
      };
    };
  };
}
