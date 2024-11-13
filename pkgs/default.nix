{pkgs ? import <nixpkgs> {}}: {
  vol = pkgs.callPackage ./vol {};
  brightness = pkgs.callPackage ./brightness {};
  wallpaper = pkgs.callPackage ./wallpaper {};
  cloud_backup = pkgs.callPackage ./cloud_backup {};
  screenshot = pkgs.callPackage ./screenshot {};
  cliphist_wrapper = pkgs.callPackage ./cliphist_wrapper {};
  shade = pkgs.callPackage ./shade {};
  sortpics = pkgs.callPackage ./sortpics {};
  gengif = pkgs.callPackage ./gengif {};

  init_bar = pkgs.callPackage ./init_bar {};
  bar_themeswitcher = pkgs.callPackage ./bar_themeswitcher {};

  batplug = pkgs.callPackage ./battery/batplug.nix {};
  batsuspend = pkgs.callPackage ./battery/batsuspend.nix {};
  batwarning = pkgs.callPackage ./battery/batwarning.nix {};

  zj_sessions = pkgs.callPackage ./zj_sessions {};
}
