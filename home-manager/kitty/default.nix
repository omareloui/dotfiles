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
      # name = "Iosevka Nerd Font Mono";
      package = pkgs.nerdfonts.override {
        fonts = [
          "FiraCode"
          "Iosevka"
          "NerdFontsSymbolsOnly"
        ];
      };
      size = 12;
    };
    shellIntegration.enableZshIntegration = true;

    settings = with config.colorScheme.palette; {
      enable_audio_bell = false;
      remember_window_size = false;
      initial_window_width = "95c";
      initial_window_height = "35c";
      window_padding_width = 0;
      confirm_os_window_close = 0;
      wayland_titlebar_color = "background";
      macos_titlebar_color = "background";
      hide_window_decorations = true;
      background_opacity = "0.6";

      foreground = "#${base05}";
      background = "#${base00}";

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

      cursor = "#${base05}";
      cursor_text_color = "#${base00}";

      selection_foreground = "#${base00}"; # "none"
      selection_background = "#${base05}";

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

    extraConfig = let
      symbolsFont = "Symbols Nerd Font Mono";
      fira = "FiraCode Nerd Font";
    in ''
      # For ligatures and other preferred characters in FiraCode font
      # U+001F _ underscore
      # U+0021 ! exclamation mark
      # U+002A * asterisk
      # U+002B + plus sign
      # U+002C , comma
      # U+002D - hyphen-minus
      # U+003C > less-than sign
      # U+003D = equal sign
      # U+003E < greater-than sign
      # U+007E ~ tilde
      # U+2013 – en dash
      # U+2014 — em dash
      # U+21B2 ↲ downwards arrow with tip leftwards
      # symbol_map U+1F,U+21,U+2A-U+2D,U+3C-U+3E,U+7E,U+2013-U+2014 ${fira}

      # U+E6B4  prettier icon
      # U+E6B3  astro icon
      # symbol_map U+23FB-23FE,U+2665,U+26a1,U+2b58,U+E000-E00A,U+E0A0-E0A1,U+E0A1-E0A2,U+E0A2-E0A3,U+e0a3,U+E0B0-E0C8,U+e0ca,U+E0CC-E0D2,U+e0d4,U+E0D6-E0D7,U+E200-E2A9,U+E300-E3C9,U+e3ce,U+E3D5-E3E3,U+E5FA-E5FB,U+E5FB-E602,U+E602-E60B,U+E60B-E616,U+E616-E617,U+E617-E61B,U+E61B-E621,U+e621,U+E621-E62C,U+E62C-E62D,U+E62D-E62F,U+E62F-E630,U+E630-E631,U+E631-E634,U+E634-E641,U+E641-E64E,U+E64E-E65D,U+e65d,U+E65D-E6B5,U+E700-E7BC,U+E7C4-E7C5,U+EA60-EA88,U+EA8A-EA8C,U+EA8F-EAC7,U+eac9,U+EACC-EAFA,U+EAFC-EB09,U+EB0B-EB4E,U+EB50-EC0A,U+EC0C-EC1E,U+ED00-ED4C,U+ed4e,U+ED50-EDFF,U+EE0C-EFCE,U+f000,U+F000-F002,U+F002-F009,U+F009-F00A,U+F00A-F00B,U+F00B-F00D,U+f00d,U+f00d,U+F00D-F00E,U+F00E-F010,U+F010-F013,U+F013-F014,U+F014-F015,U+F015-F017,U+F017-F01A,U+F01A-F01B,U+F01B-F01E,U+F01E-F021,U+F021-F022,U+F022-F027,U+F027-F028,U+F028-F03B,U+F03B-F03D,U+F03D-F03E,U+f03e,U+F03E-F041,U+F041-F042,U+F042-F043,U+F043-F044,U+f044,U+F044-F047,U+F047-F048,U+F048-F049,U+F049-F050,U+F050-F051,U+F051-F055,U+F055-F056,U+F056-F057,U+F057-F058,U+F058-F059,U+F059-F05A,U+F05A-F05C,U+F05C-F05D,U+F05D-F064,U+F064-F06A,U+F06A-F071,U+f071,U+F071-F073,U+F073-F074,U+F074-F07A,U+F07A-F07D,U+F07D-F07E,U+F07E-F080,U+f080,U+F080-F081,U+F081-F082,U+F082-F085,U+F085-F08A,U+F08A-F08B,U+F08B-F08D,U+F08D-F08E,U+F08E-F090,U+F090-F092,U+F092-F094,U+F094-F098,U+F098-F09E,U+F09E-F0A0,U+F0A0-F0A4,U+F0A4-F0A5,U+F0A5-F0A6,U+F0A6-F0A7,U+F0A7-F0A8,U+F0A8-F0A9,U+F0A9-F0AA,U+F0AA-F0AB,U+F0AB-F0AE,U+F0AE-F0B2,U+F0B2-F0C0,U+F0C0-F0C1,U+F0C1-F0C4,U+F0C4-F0C5,U+F0C5-F0C7,U+f0c7,U+F0C7-F0C9,U+f0c9,U+F0C9-F0D0,U+F0D0-F0D3,U+F0D3-F0D4,U+F0D4-F0D6,U+F0D6-F0DB,U+F0DB-F0DC,U+F0DC-F0DD,U+F0DD-F0DE,U+F0DE-F0E1,U+F0E1-F0E2,U+F0E2-F0E3,U+F0E3-F0E4,U+f0e4,U+F0E4-F0E7,U+F0E7-F0EA,U+F0EA-F0EB,U+F0EB-F0EC,U+F0EC-F0ED,U+F0ED-F0EE,U+F0EE-F0F0,U+F0F0-F0F4,U+F0F4-F0F5,U+F0F5-F0F8,U+F0F8-F0F9,U+F0F9-F0FA,U+F0FA-F0FB,U+F0FB-F0FC,U+F0FC-F0FD,U+F0FD-F0FE,U+F0FE-F100,U+F100-F101,U+F101-F102,U+F102-F103,U+F103-F10B,U+F10B-F112,U+F112-F118,U+F118-F119,U+F119-F11A,U+F11A-F11C,U+F11C-F122,U+F122-F123,U+f123,U+F123-F126,U+F126-F127,U+f127,U+F127-F137,U+F137-F138,U+F138-F139,U+F139-F13A,U+F13A-F13E,U+F13E-F141,U+F141-F142,U+F142-F143,U+F143-F144,U+F144-F146,U+F146-F148,U+F148-F149,U+F149-F14A,U+F14A-F14B,U+F14B-F14C,U+F14C-F14D,U+F14D-F150,U+f150,U+F150-F151,U+f151,U+F151-F152,U+f152,U+F152-F153,U+f153,U+F153-F154,U+F154-F155,U+f155,U+F155-F156,U+f156,U+F156-F157,U+f157,U+f157,U+f157,U+F157-F158,U+f158,U+f158,U+F158-F159,U+f159,U+F159-F15C,U+F15C-F15D,U+F15D-F15E,U+F15E-F160,U+F160-F161,U+F161-F162,U+F162-F163,U+F163-F166,U+F166-F169,U+F169-F16A,U+F16A-F172,U+F172-F174,U+F174-F175,U+F175-F176,U+F176-F177,U+F177-F178,U+F178-F182,U+F182-F183,U+F183-F184,U+F184-F185,U+F185-F186,U+F186-F187,U+F187-F18E,U+F18E-F190,U+F190-F191,U+f191,U+F191-F192,U+F192-F194,U+F194-F195,U+f195,U+F195-F197,U+F197-F199,U+F199-F19C,U+f19c,U+f19c,U+F19C-F19D,U+F19D-F1A2,U+F1A2-F1B5,U+F1B5-F1B7,U+F1B7-F1B9,U+F1B9-F1BA,U+F1BA-F1C1,U+F1C1-F1C2,U+F1C2-F1C3,U+F1C3-F1C4,U+F1C4-F1C5,U+f1c5,U+f1c5,U+F1C5-F1C6,U+f1c6,U+F1C6-F1C7,U+f1c7,U+F1C7-F1C8,U+f1c8,U+F1C8-F1C9,U+F1C9-F1CD,U+f1cd,U+f1cd,U+f1cd,U+F1CD-F1CE,U+F1CE-F1D0,U+f1d0,U+F1D0-F1D1,U+F1D1-F1D2,U+F1D2-F1D4,U+f1d4,U+F1D4-F1D7,U+F1D7-F1D8,U+F1D8-F1D9,U+F1D9-F1DA,U+F1DA-F1DC,U+F1DC-F1E0,U+F1E0-F1E1,U+F1E1-F1E3,U+f1e3,U+F1E3-F1EA,U+F1EA-F1FB,U+F1FB-F1FC,U+F1FC-F1FD,U+F1FD-F1FE,U+F1FE-F200,U+F200-F201,U+F201-F203,U+F203-F20A,U+F20A-F20B,U+f20b,U+f20b,U+F20B-F20C,U+F20C-F21E,U+F21E-F224,U+F224-F22A,U+F22A-F22B,U+F22B-F230,U+F230-F235,U+F235-F236,U+F236-F239,U+F239-F23B,U+F23B-F240,U+f240,U+F240-F241,U+F241-F242,U+F242-F243,U+F243-F244,U+F244-F245,U+F245-F249,U+F249-F24E,U+F24E-F251,U+F251-F252,U+F252-F253,U+F253-F255,U+f255,U+F255-F256,U+f256,U+F256-F257,U+F257-F258,U+F258-F259,U+F259-F25A,U+F25A-F25B,U+F25B-F262,U+F262-F264,U+F264-F26C,U+F26C-F271,U+F271-F272,U+F272-F273,U+F273-F274,U+F274-F277,U+F277-F27A,U+F27A-F27B,U+F27B-F28B,U+F28B-F28D,U+F28D-F290,U+F290-F291,U+F291-F29B,U+F29B-F29D,U+F29D-F2A0,U+F2A0-F2A2,U+F2A2-F2A3,U+f2a3,U+F2A3-F2A4,U+f2a4,U+f2a4,U+F2A4-F2A7,U+f2a7,U+F2A7-F2A8,U+F2A8-F2AA,U+F2AA-F2AC,U+F2AC-F2AD,U+F2AD-F2B3,U+F2B3-F2B4,U+F2B4-F2B5,U+F2B5-F2BB,U+F2BB-F2BC,U+F2BC-F2BD,U+F2BD-F2C2,U+F2C2-F2C3,U+F2C3-F2C7,U+f2c7,U+f2c7,U+F2C7-F2C8,U+f2c8,U+F2C8-F2C9,U+f2c9,U+F2C9-F2CA,U+f2ca,U+F2CA-F2CB,U+f2cb,U+F2CB-F2CD,U+f2cd,U+F2CD-F2D3,U+f2d3,U+F2D3-F2D4,U+f2d4,U+F2D4-F2DA,U+F2DA-F2DC,U+F2DC-F375,U+F400-F533,U+F0001-F0387,U+F0389-F03BF,U+F03C1-F043C,U+F043E-F0508,U+F050A-F05FB,U+F05FD-F0764,U+F0767-F08CF,U+F08D1-F0B38,U+F0B3A-F0C9D,U+F0CA0-F0E75,U+f0e77,U+F0E79-F0EFF,U+F0F01-F1087,U+F1089-F108B,U+F108D-F1090,U+F1092-F13A5,U+F13A7-F149A,U+F149C-F149E,U+F14A2-F14A5,U+F14A7-F14A9,U+f14ab,U+f14ae,U+f14b2,U+f14b5,U+F14B9-F1592,U+F1597-F189F,U+F18A1-F18EF,U+F18F1-F1964,U+f1966,U+f1968,U+f196a,U+F196C-F1AF0 ${symbolsFont}
    '';
  };
}
