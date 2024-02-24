{pkgs ? import <nixpkgs> {}}: {
  slock = pkgs.callPackage ./slock {};
  vol = pkgs.callPackage ./vol {};
  brightness = pkgs.callPackage ./brightness {};
  wallpaper = pkgs.callPackage ./wallpaper {};
  cloud_backup = pkgs.callPackage ./cloud_backup {};

  batplug = pkgs.callPackage ./battery/batplug.nix {};
  batsuspend = pkgs.callPackage ./battery/batsuspend.nix {};
  batwarning = pkgs.callPackage ./battery/batwarning.nix {};
}
