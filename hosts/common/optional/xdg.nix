{pkgs, ...}: {
  xdg.portal = {
    enable = true;
    config = {
      common = {default = ["*"];};
      pantheon = {
        default = ["pantheon" "gtk"];
        "org.freedesktop.impl.portal.Secret" = ["gnome-keyring"];
      };
      x-cinnamon = {default = ["xapp" "gtk"];};
    };
    extraPortals = with pkgs; [
      xdg-desktop-portal-wlr
      xdg-desktop-portal-gtk
    ];
  };
}
