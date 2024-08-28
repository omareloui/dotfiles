{config, ...}: {
  programs.zellij = {
    enable = true;
    enableZshIntegration = true;

    settings = {
      mirror_session = false;

      ui = {
        pane_frames = {
          rounded_corners = true;
        };
      };
      theme = "custom";
      themes.custom = with config.colorScheme.palette; {
        fg = "#${base05}";
        bg = "#${base00}";
        black = "#${base00}";
        red = "#${base08}";
        green = "#${base0B}";
        yellow = "#${base0A}";
        blue = "#${base0D}";
        magenta = "#${base0E}";
        cyan = "#${base0C}";
        white = "#${base05}";
        orange = "#${base09}";
      };
      };
    };
  };
}
