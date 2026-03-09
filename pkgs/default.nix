{pkgs ? import <nixpkgs> {}}: {
  batwarning = pkgs.callPackage ./batwarning {};
  brightness = pkgs.callPackage ./brightness {};
  cliphist_wrapper = pkgs.callPackage ./cliphist_wrapper {};
  cloud_backup = pkgs.callPackage ./cloud_backup {};
  gengif = pkgs.callPackage ./gengif {};
  genpdf = pkgs.callPackage ./genpdf {};
  optimize = pkgs.callPackage ./optimize {};
  screenshot = pkgs.callPackage ./screenshot {};
  shade = pkgs.callPackage ./shade {};
  sortpics = pkgs.callPackage ./sortpics {};
  vol = pkgs.callPackage ./vol {};
  wallpaper = pkgs.callPackage ./wallpaper {};

  init_bar = pkgs.callPackage ./init_bar {};
  bar_themeswitcher = pkgs.callPackage ./bar_themeswitcher {};

  zj_sessions = pkgs.callPackage ./zj_sessions {};
}
