{
  config,
  pkgs,
  ...
}: {
  programs.rofi = {
    enable = true;
    package = pkgs.rofi;

    font = "JetBrainsMono Nerd Font 10.6";

    extraConfig = {
      modi = "drun,run,filebrowser,window";
      show-icons = false;
      display-drun = " ";
      display-run = " ";
      display-filebrowser = " ";
      display-window = " ";
      drun-display-format = "{name}";
      window-format = "{w} · {c} · {t}";
    };

    theme = let
      inherit (config.lib.formats.rasi) mkLiteral;
    in {
      "*" = {
        background = mkLiteral "#15161EFF";
        foreground = mkLiteral "#C0CAF5FF";
        background-alt = mkLiteral "#1A1B26FF";
        selected = mkLiteral "#FB958BFF";
        active = mkLiteral "#414868FF";
        urgent = mkLiteral "#F7768EFF";

        border-colour = mkLiteral "var(selected)";
        handle-colour = mkLiteral "var(selected)";
        background-colour = mkLiteral "var(background)";
        foreground-colour = mkLiteral "var(foreground)";
        alternate-background = mkLiteral "var(background-alt)";
        normal-background = mkLiteral "var(background)";
        normal-foreground = mkLiteral "var(foreground)";
        urgent-background = mkLiteral "var(urgent)";
        urgent-foreground = mkLiteral "var(background)";
        active-background = mkLiteral "var(active)";
        active-foreground = mkLiteral "var(background)";
        selected-normal-background = mkLiteral "var(selected)";
        selected-normal-foreground = mkLiteral "var(background)";
        selected-urgent-background = mkLiteral "var(active)";
        selected-urgent-foreground = mkLiteral "var(background)";
        selected-active-background = mkLiteral "var(urgent)";
        selected-active-foreground = mkLiteral "var(background)";
        alternate-normal-background = mkLiteral "var(background)";
        alternate-normal-foreground = mkLiteral "var(foreground)";
        alternate-urgent-background = mkLiteral "var(urgent)";
        alternate-urgent-foreground = mkLiteral "var(background)";
        alternate-active-background = mkLiteral "var(active)";
        alternate-active-foreground = mkLiteral "var(background)";
      };

      "window" = {
        transparency = "real";
        location = mkLiteral "center";
        anchor = mkLiteral "center";
        fullscreen = false;
        width = mkLiteral "400px";
        x-offset = mkLiteral "0px";
        y-offset = mkLiteral "0px";

        enabled = true;
        margin = mkLiteral "0px";
        padding = mkLiteral "0px";
        border = mkLiteral "0px solid";
        border-radius = mkLiteral "10px";
        border-color = mkLiteral "@border-colour";
        cursor = "default";
        background-color = mkLiteral "@background-colour";
      };

      "mainbox" = {
        enabled = true;
        spacing = mkLiteral "10px";
        margin = mkLiteral "0px";
        padding = mkLiteral "30px";
        border = mkLiteral "0px solid";
        border-radius = mkLiteral "0px 0px 0px 0px";
        border-color = mkLiteral "@border-colour";
        background-color = mkLiteral "transparent";
        children = map mkLiteral ["inputbar" "message" "listview"];
      };

      "inputbar" = {
        enabled = true;
        spacing = mkLiteral "10px";
        margin = mkLiteral "0px";
        padding = mkLiteral "0px";
        border = mkLiteral "0px solid";
        border-radius = mkLiteral "0px";
        border-color = mkLiteral "@border-colour";
        background-color = mkLiteral "transparent";
        text-color = mkLiteral "@foreground-colour";
        children = map mkLiteral ["textbox-prompt-colon" "entry" "mode-switcher"];
      };

      "prompt" = {
        enabled = true;
        background-color = mkLiteral "inherit";
        text-color = mkLiteral "inherit";
      };

      "textbox-prompt-colon" = {
        enabled = true;
        padding = mkLiteral "5px 0px";
        expand = false;
        str = "";
        background-color = mkLiteral "inherit";
        text-color = mkLiteral "inherit";
      };

      "entry" = {
        enabled = true;
        padding = mkLiteral "5px 0px";
        background-color = mkLiteral "inherit";
        text-color = mkLiteral "inherit";
        cursor = mkLiteral "text";
        placeholder = "Search...";
        placeholder-color = mkLiteral "inherit";
      };

      "num-filtered-rows" = {
        enabled = true;
        expand = false;
        background-color = mkLiteral "inherit";
        text-color = mkLiteral "inherit";
      };

      "textbox-num-sep" = {
        enabled = true;
        expand = false;
        str = "/";
        background-color = mkLiteral "inherit";
        text-color = mkLiteral "inherit";
      };

      "num-rows" = {
        enabled = true;
        expand = false;
        background-color = mkLiteral "inherit";
        text-color = mkLiteral "inherit";
      };

      "case-indicator" = {
        enabled = true;
        background-color = mkLiteral "inherit";
        text-color = mkLiteral "inherit";
      };

      "listview" = {
        enabled = true;
        columns = 1;
        lines = 8;
        cycle = true;
        dynamic = true;
        scrollbar = true;
        layout = mkLiteral "vertical";
        reverse = false;
        fixed-height = true;
        fixed-columns = true;

        spacing = mkLiteral "5px";
        margin = mkLiteral "0px";
        padding = mkLiteral "0px";
        border = mkLiteral "0px solid";
        border-radius = mkLiteral "0px";
        border-color = mkLiteral "@border-colour";
        background-color = mkLiteral "transparent";
        text-color = mkLiteral "@foreground-colour";
        cursor = "default";
      };

      "scrollbar" = {
        handle-width = mkLiteral "3px";
        handle-color = mkLiteral "@handle-colour";
        border-radius = mkLiteral "10px";
        background-color = mkLiteral "@alternate-background";
      };

      "element" = {
        enabled = true;
        spacing = mkLiteral "10px";
        margin = mkLiteral "0px";
        padding = mkLiteral "5px 10px";
        border = mkLiteral "0px solid";
        border-radius = mkLiteral "10px";
        border-color = mkLiteral "@border-colour";
        background-color = mkLiteral "transparent";
        text-color = mkLiteral "@foreground-colour";
        cursor = mkLiteral "pointer";
      };

      "element normal.normal" = {
        background-color = mkLiteral "var(normal-background)";
        text-color = mkLiteral "var(normal-foreground)";
      };

      "element normal.urgent" = {
        background-color = mkLiteral "var(urgent-background)";
        text-color = mkLiteral "var(urgent-foreground)";
      };

      "element normal.active" = {
        background-color = mkLiteral "var(active-background)";
        text-color = mkLiteral "var(active-foreground)";
      };

      "element selected.normal" = {
        background-color = mkLiteral "var(selected-normal-background)";
        text-color = mkLiteral "var(selected-normal-foreground)";
      };

      "element selected.urgent" = {
        background-color = mkLiteral "var(selected-urgent-background)";
        text-color = mkLiteral "var(selected-urgent-foreground)";
      };

      "element selected.active" = {
        background-color = mkLiteral "var(selected-active-background)";
        text-color = mkLiteral "var(selected-active-foreground)";
      };

      "element alternate.normal" = {
        background-color = mkLiteral "var(alternate-normal-background)";
        text-color = mkLiteral "var(alternate-normal-foreground)";
      };

      "element alternate.urgent" = {
        background-color = mkLiteral "var(alternate-urgent-background)";
        text-color = mkLiteral "var(alternate-urgent-foreground)";
      };

      "element alternate.active" = {
        background-color = mkLiteral "var(alternate-active-background)";
        text-color = mkLiteral "var(alternate-active-foreground)";
      };

      "element-icon" = {
        background-color = mkLiteral "transparent";
        text-color = mkLiteral "inherit";
        size = mkLiteral "24px";
        cursor = mkLiteral "inherit";
      };

      "element-text" = {
        background-color = mkLiteral "transparent";
        text-color = mkLiteral "inherit";
        highlight = mkLiteral "inherit";
        cursor = mkLiteral "inherit";
        vertical-align = mkLiteral "0.5";
        horizontal-align = mkLiteral "0.0";
      };

      "mode-switcher" = {
        enabled = true;
        spacing = mkLiteral "10px";
        margin = mkLiteral "0px";
        padding = mkLiteral "0px";
        border = mkLiteral "0px solid";
        border-radius = mkLiteral "0px";
        border-color = mkLiteral "@border-colour";
        background-color = mkLiteral "transparent";
        text-color = mkLiteral "@foreground-colour";
      };

      "button" = {
        padding = mkLiteral "5px 10px";
        border = mkLiteral "0px solid";
        border-radius = mkLiteral "10px";
        border-color = mkLiteral "@border-colour";
        background-color = mkLiteral "@alternate-background";
        text-color = mkLiteral "inherit";
        cursor = mkLiteral "pointer";
      };

      "button selected" = {
        background-color = mkLiteral "var(selected-normal-background)";
        text-color = mkLiteral "var(selected-normal-foreground)";
      };

      "message" = {
        enabled = true;
        margin = mkLiteral "0px";
        padding = mkLiteral "0px";
        border = mkLiteral "0px solid";
        border-radius = mkLiteral "0px 0px 0px 0px";
        border-color = mkLiteral "@border-colour";
        background-color = mkLiteral "transparent";
        text-color = mkLiteral "@foreground-colour";
      };

      "textbox" = {
        padding = mkLiteral "8px 10px";
        border = mkLiteral "0px solid";
        border-radius = mkLiteral "10px";
        border-color = mkLiteral "@border-colour";
        background-color = mkLiteral "@alternate-background";
        text-color = mkLiteral "@foreground-colour";
        vertical-align = mkLiteral "0.5";
        horizontal-align = mkLiteral "0.0";
        highlight = mkLiteral "none";
        placeholder-color = mkLiteral "@foreground-colour";
        blink = true;
        markup = true;
      };

      "error-message" = {
        padding = mkLiteral "10px";
        border = mkLiteral "2px solid";
        border-radius = mkLiteral "10px";
        border-color = mkLiteral "@border-colour";
        background-color = mkLiteral "@background-colour";
        text-color = mkLiteral "@foreground-colour";
      };
    };
  };

  home.file.".config/rofi/border.rasi".text = ''* { border-width: 3px; }'';
  home.file.".config/rofi/font.rasi".text = ''* { font: "Fira Sans 11"; }'';
  home.file.".config/rofi/wallpaper.rasi".text = ''* { current-image: url("${config.home.homeDirectory}/.cache/wallpapers/current_blurred.png", height); }'';

  home.file.".config/rofi/common.rasi".text =
    /*
    conf
    */
    ''
      configuration {
          modi:                "drun,run";
          font:                "Fira Sans 11";
          show-icons:          false;
          icon-theme:          "kora";
          display-drun:        "APPS";
          display-run:         "RUN";
          display-filebrowser: "FILES";
          display-window:      "WINDOW";
          hover-select:        true;
          me-select-entry:     "";
          me-accept-entry:     "MousePrimary";
          drun-display-format: "{name}";
          window-format:       "{w} · {c} · {t}";
      }

      /* ---- Load font ---- */
      @import "~/.config/rofi/font.rasi"

      /* ---- Load pywal colors (custom wal template) ---- */
      @import "~/.config/rofi/palette.rasi"

      /* ---- Load border width ---- */
      @import "~/.config/rofi/border.rasi"

      /* ---- Load wallpaper ---- */
      @import "~/.config/rofi/wallpaper.rasi"

      /* ---- Window ---- */
      window {
          width:            400px;
          x-offset:         -14px;
          y-offset:         65px;
          spacing:          0px;
          padding:          0px;
          margin:           0px;
          color:            #FFFFFF;
          border:           @border-width;
          border-color:     #FFFFFF;
          cursor:           "default";
          transparency:     "real";
          location:         northeast;
          anchor:           northeast;
          fullscreen:       false;
          enabled:          true;
          border-radius:    10px;
          background-color: transparent;
      }

      /* ---- Mainbox ---- */
      mainbox {
          enabled:                      true;
          orientation:                  horizontal;
          spacing:                      0px;
          margin:                       0px;
          background-color:             @background;
          background-image:             @current-image;
          children:                     ["listbox"];
      }

      /* ---- Imagebox ---- */
      imagebox {
          padding:                      18px;
          background-color:             transparent;
          orientation:                  vertical;
          children:                     [ "inputbar", "dummy", "mode-switcher" ];
      }

      /* ---- Listbox ---- */
      listbox {
          spacing:                     20px;
          background-color:            transparent;
          orientation:                 vertical;
          children:                    [ "inputbar", "message", "listview" ];
      }

      /* ---- Dummy ---- */
      dummy {
          background-color:            transparent;
      }

      /* ---- Inputbar ---- */
      inputbar {
          enabled:                      true;
          text-color:                   @foreground;
          spacing:                      10px;
          padding:                      15px;
          border-radius:                0px;
          border-color:                 @foreground;
          background-color:             @background;
          children:                     [ "textbox-prompt-colon", "entry" ];
      }

      textbox-prompt-colon {
          enabled:                      true;
          expand:                       false;
          padding:                      0px 5px 0px 0px;
          str:                          "";
          background-color:             transparent;
          text-color:                   inherit;
      }

      entry {
          enabled:                      true;
          background-color:             transparent;
          text-color:                   inherit;
          cursor:                       text;
          placeholder:                  "Search";
          placeholder-color:            inherit;
      }

      /* ---- Mode Switcher ---- */
      mode-switcher{
          enabled:                      true;
          spacing:                      20px;
          background-color:             transparent;
          text-color:                   @foreground;
      }

      button {
          padding:                      10px;
          border-radius:                10px;
          background-color:             @background;
          text-color:                   inherit;
          cursor:                       pointer;
          border:                       0px;
      }

      button selected {
          background-color:             @color11;
          text-color:                   @foreground;
      }

      /* ---- Listview ---- */
      listview {
          enabled:                      true;
          columns:                      1;
          lines:                        8;
          cycle:                        true;
          dynamic:                      true;
          scrollbar:                    false;
          layout:                       vertical;
          reverse:                      false;
          fixed-height:                 true;
          fixed-columns:                true;
          spacing:                      0px;
          padding:                      10px;
          margin:                       0px;
          background-color:             @background;
          border:0px;
      }

      /* ---- Element ---- */
      element {
          enabled:                      true;
          padding:                      10px;
          margin:                       5px;
          cursor:                       pointer;
          background-color:             @background;
          border-radius:                10px;
          border:                       @border-width;
      }

      element normal.normal {
          background-color:            inherit;
          text-color:                  @foreground;
      }

      element normal.urgent {
          background-color:            inherit;
          text-color:                  @foreground;
      }

      element normal.active {
          background-color:            inherit;
          text-color:                  @foreground;
      }

      element selected.normal {
          background-color:            @color11;
          text-color:                  @foreground;
      }

      element selected.urgent {
          background-color:            inherit;
          text-color:                  @foreground;
      }

      element selected.active {
          background-color:            inherit;
          text-color:                  @foreground;
      }

      element alternate.normal {
          background-color:            inherit;
          text-color:                  @foreground;
      }

      element alternate.urgent {
          background-color:            inherit;
          text-color:                  @foreground;
      }

      element alternate.active {
          background-color:            inherit;
          text-color:                  @foreground;
      }

      element-icon {
          background-color:            transparent;
          text-color:                  inherit;
          size:                        32px;
          cursor:                      inherit;
      }

      element-text {
          background-color:            transparent;
          text-color:                  inherit;
          cursor:                      inherit;
          vertical-align:              0.5;
          horizontal-align:            0.0;
      }

      /*****----- Message -----*****/
      message {
          background-color:            transparent;
          border:0px;
          margin:20px 0px 0px 0px;
          padding:0px;
          spacing:0px;
          border-radius: 10px;
      }

      textbox {
          padding:                     15px;
          margin:                      0px;
          border-radius:               0px;
          background-color:            @background;
          text-color:                  @foreground;
          vertical-align:              0.5;
          horizontal-align:            0.0;
      }

      error-message {
          padding:                     15px;
          border-radius:               20px;
          background-color:            @background;
          text-color:                  @foreground;
      }
    '';

  home.file.".config/rofi/cliphist.rasi".text = ''@import "~/.config/rofi/common.rasi"'';
  home.file.".config/rofi/short.rasi".text = ''
    @import "~/.config/rofi/common.rasi"
    window { width: 200; }
    listbox { children: [ "listview" ]; }
    listview { lines: 2; }
  '';
}
