{pkgs, ...}: {
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

  security.polkit = {
    enable = true;
    extraConfig = ''
      polkit.addRule(function(action, subject) {
        if (
          subject.isInGroup("users")
            && (
              action.id == "org.freedesktop.login1.reboot" ||
              action.id == "org.freedesktop.login1.reboot-multiple-sessions" ||
              action.id == "org.freedesktop.login1.power-off" ||
              action.id == "org.freedesktop.login1.power-off-multiple-sessions"
            )
          ) {
          return polkit.Result.YES;
        }
      })
    '';
  };
}
