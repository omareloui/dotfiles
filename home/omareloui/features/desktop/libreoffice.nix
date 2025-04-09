{pkgs, ...}: {
  home.packages = with pkgs; [libreoffice];

  xdg.mimeApps = let
    mimeTypes = {
      "application/vnd.openxmlformats-officedocument.wordprocessingml.document" = "writer.desktop";
    };
  in {
    associations.added = mimeTypes;
    defaultApplications = mimeTypes;
  };
}
