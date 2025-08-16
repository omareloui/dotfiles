{lib, ...}: {
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
    };
  };
}
