{pkgs, ...}: {
  home.packages = with pkgs; [zathura];

  xdg.mimeApps = let
    mimeTypes = {
      "application/pdf" = ["org.pwmt.zathura-pdf-mupdf.desktop"];
    };
  in {
    associations.added = mimeTypes;
    defaultApplications = mimeTypes;
  };
}
