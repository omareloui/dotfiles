{pkgs, ...}: {
  home.packages = with pkgs; [microsoft-edge];

  xdg.mimeApps = let
    mse = "microsoft-edge";
    mimeTypes = {
      "text/html" = mse;
      "x-scheme-handler/http" = mse;
      "x-scheme-handler/https" = mse;
      "x-scheme-handler/about" = mse;
      "x-scheme-handler/unknown" = mse;
    };
  in {
    associations.added = mimeTypes;
    defaultApplications = mimeTypes;
  };
}
