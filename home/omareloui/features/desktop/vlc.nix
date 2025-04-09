{pkgs, ...}: {
  home.packages = with pkgs; [vlc];

  xdg.mimeApps = let
    mimeTypes = {
      "video/mp4" = ["vlc.desktop"];
    };
  in {
    associations.added = mimeTypes;
    defaultApplications = mimeTypes;
  };
}
