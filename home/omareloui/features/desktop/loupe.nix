{pkgs, ...}: {
  home.packages = with pkgs; [loupe];

  xdg.mimeApps = let
    mimeTypes = {
      "image/png" = ["org.gnome.Loupe.desktop"];
      "image/jpeg" = ["org.gnome.Loupe.desktop"];
    };
  in {
    associations.added = mimeTypes;
    defaultApplications = mimeTypes;
  };
}
