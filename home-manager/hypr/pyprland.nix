{
  lib,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [pyprland];

  home.file.".config/hypr/pyprland.toml".text = let
    class = "scratchpad";
    terminalEmulator = "${lib.getExe pkgs.wezterm} start --class ${class} --always-new-process -- zsh --login -c 'zellij'";
    terminalEmulatorRun = "${lib.getExe pkgs.wezterm} start --class ${class} --always-new-process --";
    xsize = 80;
    ysize = 85;
    smxsize = 60;
    smysize = 70;

    pos = p: (100 - p) / 2;
    xpos = pos xsize;
    ypos = pos ysize;

    smxpos = pos smxsize;
    smypos = pos smysize;
  in
    /*
    toml
    */
    ''
      [pyprland]
      plugins = ["scratchpads"]

      [scratchpads.term]
      command = "${terminalEmulator}"
      class = "${class}"
      position = "${builtins.toString xpos}% ${builtins.toString ypos}%"
      size = "${builtins.toString xsize}% ${builtins.toString ysize}%"
      animation = "fromTop"

      [scratchpads.yazi]
      command = "${terminalEmulatorRun} ${lib.getExe pkgs.yazi}"
      class = "${class}"
      unfocus = "hide"
      position = "${builtins.toString xpos}% ${builtins.toString ypos}%"
      size = "${builtins.toString xsize}% ${builtins.toString ysize}%"
      animation = "fromTop"

      [scratchpads.btm]
      command = "${terminalEmulatorRun} ${lib.getExe pkgs.bottom}"
      class = "${class}"
      unfocus = "hide"
      position = "${builtins.toString smxpos}% ${builtins.toString smypos}%"
      size = "${builtins.toString smxsize}% ${builtins.toString smysize}%"
      animation = "fromTop"
    '';
}
