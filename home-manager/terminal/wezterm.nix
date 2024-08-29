{config, ...}: {
  programs.wezterm = {
    enable = true;
    enableZshIntegration = true;

    colorSchemes = with config.colorScheme.palette; {
      custom = {
        ansi = [
          "#${base00}"
          "#${base08}"
          "#${base0B}"
          "#${base0A}"
          "#${base0D}"
          "#${base0E}"
          "#${base0C}"
          "#${base05}"
        ];
        background = "#${base00}";
        brights = [
          "#${base03}"
          "#${base08}"
          "#${base0B}"
          "#${base0A}"
          "#${base0D}"
          "#${base0E}"
          "#${base0C}"
          "#${base07}"
        ];
        cursor_bg = "#${base05}";
        cursor_border = "#${base05}";
        # cursor_fg = "#${base05}";
        foreground = "#${base05}";
        indexed = {};
        selection_bg = "#${base05}";
        selection_fg = "#${base00}";
      };
    };

    extraConfig =
      /*
      lua
      */
      ''
        local config = {}

        -- Provides clearer error messages
        if wezterm.config_builder then
          config = wezterm.config_builder()
        end

        -- This makes the terminal run on hyprland
        config.enable_wayland = false

        -- Fixes the blocks of color instead of text
        config.front_end = "WebGpu"

        -- Customization
        config.font = wezterm.font("FiraCode Nerd Font")
        config.font_size = 12.0
        config.color_scheme = "custom"
        config.window_background_opacity = 0.7

        -- Layout
        config.enable_tab_bar = false

        -- On startup
        config.default_prog = { "zsh", "--login", "-c", "zellij" }

        -- Bindings
        config.disable_default_key_bindings = true;
        config.keys = {
          { key = 'V', mods = 'CTRL|SHIFT', action = wezterm.action.PasteFrom 'Clipboard' },
        }

        -- Misc
        config.window_close_confirmation = "NeverPrompt"

        return config
      '';
  };
}
