{...}: {
  xdg.mimeApps = let
    mimeTypes = {
      "x-scheme-handler/magnet" = ["userapp-transmission-gtk-9UFXL2.desktop"];
    };
  in {
    associations.added = mimeTypes;
    defaultApplications = mimeTypes;
  };
}
