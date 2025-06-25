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

    extraConfig =
      /*
      nu
      */
      ''
          def _ngc [] {
            nix-collect-garbage -d
            sudo nix-collect-garbage -d
          }
          def _nu [] {
            cd ${config.home.sessionVariables.FLAKE};
            nix flake update
          }
          def _edot [] {
            cd ${config.home.sessionVariables.FLAKE};
        ${config.home.sessionVariables.EDITOR} .
          }
      ''
      + (
        if config.programs.zellij.enable
        then
          /*
          nu
          */
          ''
            def start_zellij [] {
              if 'ZELLIJ' not-in ($env | columns) {
                if 'ZELLIJ_AUTO_ATTACH' in ($env | columns) and $env.ZELLIJ_AUTO_ATTACH == 'true' {
                  zellij attach -c
                } else {
                  zellij
                }

                if 'ZELLIJ_AUTO_EXIT' in ($env | columns) and $env.ZELLIJ_AUTO_EXIT == 'true' {
                  exit
                }
              }
            }

            start_zellij
          ''
        else ""
      );

    shellAliases =
      config.home.shellAliases
      // {
        docker_clean_images = "docker rmi (docker images -a --filter=dangling=true -q)";
        docker_clean_ps = "docker rm (docker ps --filter=status=exited --filter=status=created -q)";
        edot = "_edot";
        pva = "ignore";
        ngc = "_ngc";
        nu = "_nu";
      };
  };
}
