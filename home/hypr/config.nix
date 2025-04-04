{
  pkgs ? import <nixpkgs> {},
  lib,
}: let
  terminalPkg = pkgs.kitty;
  # terminalPkg = pkgs.wezterm;
in {
  terminal = lib.getExe terminalPkg;
}
