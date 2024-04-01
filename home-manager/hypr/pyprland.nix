{
  lib,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    pyprland
  ];

  home.file.".config/hypr/pyprland.toml".text = let
    class = "scratchpad";
    cmdEmulator = "${lib.getExe pkgs.kitty} --class \\\"${class}\\\"";
    xsize = 80;
    ysize = 85;
    pos = p: (100 - p) / 2;
    xpos = pos xsize;
    ypos = pos ysize;
  in
    /*
    toml
    */
    ''
      [pyprland]
      plugins = ["scratchpads"]

      [scratchpads.term]
      command = "${cmdEmulator}"
      class = "${class}"
      position = "${builtins.toString xpos}% ${builtins.toString ypos}%"
      size = "${builtins.toString xsize}% ${builtins.toString ysize}%"
      animation = "fromTop"

      [scratchpads.yazi]
      command = "${cmdEmulator} ${lib.getExe pkgs.yazi}"
      class = "${class}"
      unfocus = "hide"
      position = "${builtins.toString xpos}% ${builtins.toString ypos}%"
      size = "${builtins.toString xsize}% ${builtins.toString ysize}%"
      animation = "fromTop"

      [scratchpads.btm]
      command = "${cmdEmulator} ${lib.getExe pkgs.bottom}"
      class = "${class}"
      unfocus = "hide"
      position = "${builtins.toString xpos}% ${builtins.toString ypos}%"
      size = "${builtins.toString xsize}% ${builtins.toString ysize}%"
      animation = "fromTop"
    '';
}
