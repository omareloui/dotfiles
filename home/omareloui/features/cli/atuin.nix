{...}: {
  programs.atuin = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      style = "auto";
      inline_height = 0;
      enter_accept = true;
      keymap_mode = "vim-normal";
      keymap_cursor = {
        emacs = "blink-bar";
        vim_insert = "blink-bar";
        vim_normal = "blink-block";
      };
      stats = {
        common_prefix = ["sudo"];
        common_subcommands = ["cargo" "go" "git" "npm" "yarn" "pnpm" "docker" "kubectl"];
      };
    };
  };
}
