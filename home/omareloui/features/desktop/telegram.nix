{pkgs, ...}: {
  home.packages = with pkgs; [telegram-desktop];

  xdg.mimeApps = let
    mimeTypes = {
      "x-scheme-handler/tg" = ["org.telegram.desktop.desktop"];
    };
  in {
    associations.added = mimeTypes;
    defaultApplications = mimeTypes;
  };
}
