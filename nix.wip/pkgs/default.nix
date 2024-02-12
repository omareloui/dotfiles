pkgs: {
  distro = pkgs.callPackage ./default {inherit pkgs;};
}
