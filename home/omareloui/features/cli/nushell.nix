{config, ...}: {
  programs.nushell = {
    enable = true;
    settings = {
      buffer_editor = config.home.sessionVariables.EDITOR;
      show_banner = false;
      edit_mode = "vi";
      cursor_shape.vi_insert = "blink_line";
      cursor_shape.vi_normal = "blink_block";
      completions.algorithm = "fuzzy";
    };

    environmentVariables = {
      PROMPT_INDICATOR_VI_NORMAL = "";
      PROMPT_INDICATOR_VI_INSERT = "";
    };
    shellAliases =
      config.home.shellAliases
      // {
        docker_clean_images = "docker rmi (docker images -a --filter=dangling=true -q)";
        docker_clean_ps = "docker rm (docker ps --filter=status=exited --filter=status=created -q)";
      };
  };
}
