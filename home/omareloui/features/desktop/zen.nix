{inputs, ...}: {
  imports = [
    inputs.zen-browser.homeModules.beta
  ];

  programs.zen-browser = {
    enable = true;
    suppressXdgMigrationWarning = true;
  };

  xdg.mimeApps = let
    # got from  ~/.nix-profile/share/applications/
    zen = "zen-beta.desktop";
    mimeTypes = {
      "text/html" = zen;
      "x-scheme-handler/http" = zen;
      "x-scheme-handler/https" = zen;
      "x-scheme-handler/about" = zen;
      "x-scheme-handler/unknown" = zen;
    };
  in {
    associations.added = mimeTypes;
    defaultApplications = mimeTypes;
  };
}
