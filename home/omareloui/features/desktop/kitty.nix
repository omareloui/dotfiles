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
    };

    settings = {
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

      cursor_trail = 5;
      cursor_trail_decay = "0.1 0.5";
      cursor_trail_start_threshold = 1;

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
