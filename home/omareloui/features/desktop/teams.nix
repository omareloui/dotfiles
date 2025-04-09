{pkgs, ...}: {
  home.packages = with pkgs; [teams-for-linux];

  xdg.mimeApps = let
    mimeTypes = {
      "x-scheme-handler/msteams" = ["teams-for-linux.desktop"];
    };
  in {
    associations.added = mimeTypes;
    defaultApplications = mimeTypes;
  };
}
