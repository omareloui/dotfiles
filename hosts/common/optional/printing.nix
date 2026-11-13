{pkgs, ...}: {
  services.printing = {
    enable = true;
    drivers = [pkgs.cnijfilter2 pkgs.ghostscript];
  };
}
