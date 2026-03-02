{
  config,
  lib,
  ...
}: {
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    enableNushellIntegration = true;
    settings = {
      add_newline = false;
      line_break.disabled = true;
      format = lib.concatStrings [
        "$directory"
        "$git_branch"
        "$cmd_duration"
        "$line_break"
        "$jobs"
        "$battery"
        "$python"
        (
          if config.programs.yazi.enable
          then "\${custom.yazi}"
          else ""
        )
        "$character"
      ];
      python = {format = "[(($virtualenv) )]($style)";};
      character = {
        success_symbol = "[❱](bold green)";
        error_symbol = "[❱](bold red)";
        vimcmd_symbol = "[❰](bold green)";
        vimcmd_replace_one_symbol = "[❰](bold purple)";
        vimcmd_replace_symbol = "[❰](bold purple)";
        vimcmd_visual_symbol = "[❰](bold yellow)";
      };
      custom.yazi = lib.mkIf config.programs.yazi.enable {
        description = "Indicate when the shell was launched by `yazi`";
        symbol = "🦆";
        when = ''test -n "$YAZI_LEVEL" '';
      };
    };
  };
}
