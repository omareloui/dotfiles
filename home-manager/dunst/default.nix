{...}: {
  # TODO: readd the comments from main dunst file after moving to another file
  services.dunst = {
    enable = true;
    settings = {
      global = {
        # TODO: check the font
        font = "Product Sans";
        allow_markup = true;
        format = ''
          <b>%s</b>
          %b'';
        sort = true;
        indicate_hidden = true;
        alignment = "left";
        bounce_freq = 0;
        ellipsize = "middle";
        show_age_threshold = -1;
        word_wrap = true;
        ignore_newline = false;
        width = "(300, 600)";
        height = 500;
        origin = "top-right";
        offset = "20x20";
        progress_bar = true;
        progress_bar_height = 14;
        progress_bar_frame_width = 1;
        progress_bar_min_width = 150;
        progress_bar_max_width = 300;
        frame_width = 3;
        frame_color = "#1E1E2E";
        transparency = 0;
        idle_threshold = 0;
        monitor = 0;
        follow = "none";
        show_indicators = false;
        sticky_history = true;
        line_height = 8;
        separator_height = 3;
        padding = 16;
        horizontal_padding = 12;
        text_icon_padding = 16;
        separator_color = "auto";
        startup_notification = false;
        icon_position = "left";
        min_icon_size = 32;
        max_icon_size = 128;
        corner_radius = 10;
        always_run_script = true;
        mouse_left_click = "do_action, close_current";
        mouse_middle_click = "close_all";
        mouse_right_click = "close_current";
      };

      urgency_low = {
        timeout = 6;
        background = "#1E1E2E";
        foreground = "#CDD6F4";
        frame_color = "#191d24";
        highlight = "#89B4FA";
      };

      urgency_normal = {
        timeout = 6;
        background = "#1E1E2E";
        foreground = "#CDD6F4";
        frame_color = "#0d0f16";
        highlight = "#89B4FA";
      };

      urgency_critical = {
        # TODO: add the script
        # script = "~/.config/dunst/scripts/playNotificationSound.sh";
        timeout = 0;
        background = "#1E1E2E";
        foreground = "#CDD6F4";
        frame_color = "#0d0f16";
        highlight = "#F38BA8";
      };
    };
  };
}
