{pkgs, ...}: {
  home.packages = with pkgs; [kdePackages.ark];

  xdg.mimeApps = let
    mimeTypes = {
      "application/x-tar" = ["org.kde.ark.desktop"];
      "application/x-rar" = ["org.kde.ark.desktop"];
      "application/zip" = ["org.kde.ark.desktop"];
    };
  in {
    associations.added = mimeTypes;
    defaultApplications = mimeTypes;
  };
}
