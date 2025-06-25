{
  config,
  pkgs,
  ...
}: {
  programs.kitty = {
    enable = true;
    # `kitty list-fonts` to choose a font
    # `kitty --debug-font-fallback` to know which font is applied
    font = {
      name = "FiraCode Nerd Font";
      package = pkgs.nerd-fonts.fira-code;
      size = 12;
    };
    shellIntegration = {
      enableZshIntegration = true;
      enableNushellIntegration = true;
    };

    settings = with config.colorScheme.palette; {
      enable_audio_bell = false;
      remember_window_size = false;
      initial_window_width = "95c";
      initial_window_height = "35c";
      window_padding_width = 0;
      confirm_os_window_close = 0;
      hide_window_decorations = true;

      wayland_titlebar_color = "background";
      macos_titlebar_color = "background";
      background_opacity = "0.6";

      foreground = "#${base05}";
      background = "#${base00}";

      cursor = "#${base05}";
      cursor_text_color = "#${base00}";

      cursor_trail = 5;
      cursor_trail_decay = "0.1 0.5";
      cursor_trail_start_threshold = 1;

      selection_foreground = "#${base05}";
      selection_background = "#${base00}";

      color0 = "#${base00}";
      color1 = "#${base08}";
      color2 = "#${base0B}";
      color3 = "#${base0A}";
      color4 = "#${base0D}";
      color5 = "#${base0E}";
      color6 = "#${base0C}";
      color7 = "#${base05}";
      color8 = "#${base03}";
      color9 = "#${base08}";
      color10 = "#${base0B}";
      color11 = "#${base0A}";
      color12 = "#${base0D}";
      color13 = "#${base0E}";
      color14 = "#${base0C}";
      color15 = "#${base07}";
      color16 = "#${base09}";
      color17 = "#${base0F}";
      color18 = "#${base01}";
      color19 = "#${base02}";
      color20 = "#${base04}";
      color21 = "#${base06}";

      url_color = "#${base04}";

      active_border_color = "#${base03}";
      inactive_border_color = "#${base01}";

      active_tab_background = "#${base00}";
      active_tab_foreground = "#${base05}";
      inactive_tab_background = "#${base01}";
      inactive_tab_foreground = "#${base04}";

      bell_border_color = "#${base0C}";
      tab_bar_background = "#${base01}";

      active_tab_font_style = "bold";
      inactive_tab_font_style = "bold";
      tab_bar_style = "fade";
      tab_fade = 1;
    };

    keybindings = {
      "kitty_mod+t" = "new_tab_with_cwd";
      "kitty_mod+enter" = "new_window_with_cwd";
      "kitty_mod+l" = "next_tab";
      "kitty_mod+h" = "previous_tab";
      "kitty_mod+right" = "no_op";
      "kitty_mod+left" = "no_op";
    };
  };
}
