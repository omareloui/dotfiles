{
  config,
  pkgs,
  ...
}: {
  gtk.enable = true;
  gtk.gtk4.theme = config.gtk.theme;
  services.xsettingsd.enable = true;
  xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-gtk];
}
