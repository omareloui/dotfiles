{
  lib,
  pkgs,
  ...
}: let
  # exts = lib.filter (pkg: lib.isDerivation pkg && !pkg.meta.broken or false) (lib.attrValues ./extensions.nix);
  # pkgg = import ./tmpext/default.nix;
  # called = pkgs.callPackage pkgg;
in {
  home.packages = with pkgs; [
    inkscape-with-extensions
    # inkscape-with-extensions.override
    # {inkscapeExtensions = [called];}
  ];

  # home.file.".config/inkscape/extensions" = {
  #   source = ./extensions;
  #   recursive = true;
  # };
}
