{pkgs ? import <nixpkgs> {}}: {
  slock = pkgs.callPackage ./slock {};
  vol = pkgs.callPackage ./vol {};
  brightness = pkgs.callPackage ./brightness {};
  wallpaper = pkgs.callPackage ./wallpaper {};
}
