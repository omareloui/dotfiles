{pkgs, ...}: {
  home.packages = with pkgs; [
    swaynotificationcenter
    avizo
  ];

  home.file.".config/swaync/config.json".text = builtins.toJSON {
    "$schema" = "${pkgs.swaynotificationcenter}/configSchema.json";
    positionX = "center";
    positionY = "top";
    control-center-positionX = "none";
    control-center-positionY = "none";
    control-center-margin-top = 8;
    control-center-margin-bottom = 8;
    control-center-margin-right = 8;
    control-center-margin-left = 8;
    control-center-width = 500;
    control-center-height = 600;
    fit-to-screen = false;

    layer = "overlay";
    control-center-layer = "overlay";
    cssPriority = "user";
    notification-icon-size = 64;
    notification-body-image-height = 100;
    notification-body-image-width = 200;
    notification-inline-replies = true;
    timeout = 10;
    timeout-low = 5;
    timeout-critical = 0;
    notification-window-width = 500;
    keyboard-shortcuts = true;
    image-visibility = "when-available";
    transition-time = 200;
    hide-on-clear = true;
    hide-on-action = true;
    script-fail-notify = true;

    widgets = ["inhibitors" "title" "dnd" "mpris" "notifications"];

    widget-config = {
      inhibitors = {
        text = "inhibitors";
        button-text = "clear all";
        clear-all-button = true;
      };
      title = {
        text = "notifications";
        clear-all-button = false;
        button-text = "clear all";
      };
      dnd = {
        text = "do not disturb";
      };
      label = {
        max-lines = 5;
        text = "label text";
      };
      mpris = {
        image-size = 96;
        image-radius = 12;
      };
    };
  };

  home.file.".config/swaync/style.css".text =
    /*
    css
    */
    ''
      @import "../waybar/palette.css";

      @define-color text            @foreground;
      @define-color background-alt  @color1;
      @define-color selected        @color3;
      @define-color hover           @color5;
      @define-color urgent          @color2;

      * {

        /*background-alt:        @color1;      Buttons background */
        /*selected:              @color2;      Button selected */
        /*hover:                 @color5;      Hover button */
        /*urgent:                @color6;      Urgency critical */
        /*text-selected:         @background; */

        color: @text;

        all: unset;
        font-size: 14px;
        font-family: "Fira Semibold";
        transition: 200ms;

      }

      .notification-row {
        outline: none;
        margin: 0;
        padding: 0px;
      }

      .floating-notifications.background .notification-row .notification-background {
        background: alpha(@background, .55);
        box-shadow: 0 2px 8px 0 @background;
        border: 1px solid @selected;
        border-radius: 12px;
        margin: 16px;
        padding: 0;
      }

      .floating-notifications.background .notification-row .notification-background .notification {
        padding: 6px;
        border-radius: 12px;
      }

      .floating-notifications.background .notification-row .notification-background .notification.critical {
        border: 2px solid @urgent;
      }

      .floating-notifications.background .notification-row .notification-background .notification .notification-content {
        margin: 14px;
      }

      .floating-notifications.background .notification-row .notification-background .notification > *:last-child > * {
        min-height: 3.4em;
      }

      .floating-notifications.background .notification-row .notification-background .notification > *:last-child > * .notification-action {
        border-radius: 8px;
        background-color: @background-alt ;
        margin: 6px;
        border: 1px solid transparent;
      }

      .floating-notifications.background .notification-row .notification-background .notification > *:last-child > * .notification-action:hover {
        background-color: @hover;
        border: 1px solid @selected;
      }

      .floating-notifications.background .notification-row .notification-background .notification > *:last-child > * .notification-action:active {
        background-color: @selected;
        color: @background;
      }

      .image {
        margin: 10px 20px 10px 0px;
      }

      .summary {
        font-weight: 800;
        font-size: 1rem;
      }

      .body {
        font-size: 0.8rem;
      }

      .floating-notifications.background .notification-row .notification-background .close-button {
        margin: 6px;
        padding: 2px;
        border-radius: 6px;
        background-color: transparent;
        border: 1px solid transparent;
      }

      .floating-notifications.background .notification-row .notification-background .close-button:hover {
        background-color: @selected;
      }

      .floating-notifications.background .notification-row .notification-background .close-button:active {
        background-color: @selected;
        color: @background;
      }

      .notification.critical progress {
        background-color: @selected;
      }

      .notification.low progress,
      .notification.normal progress {
        background-color: @selected;
      }

      /* ================================= Controle Center ================================= */
      /*     @define-color text            @foreground; */
      /*     @define-color background-alt  @color1; */
      /*     @define-color selected        @color3; */
      /*     @define-color hover           @color5; */
      /*     @define-color urgent          @color2; */

      /*     * { */
      /*       color:            @text; */

      /*       all: unset; */
      /*       font-size: 14px; */
      /*       font-family: "JetBrains Mono Nerd Font 10"; */
      /*       transition: 200ms; */

      /*     } */

      /*     /* Avoid 'annoying' backgroud */ */
      /*     .blank-window { */
      /*       background: transparent; */
      /*     } */

      /*     /* CONTROL CENTER ------------------------------------------------------------------------ */ */

      /*     .control-center { */
      /*       background: alpha(@background, .55); */
      /*       border-radius: 12px; */
      /*       border: 1px solid @selected; */
      /*       box-shadow: 0 2px 8px 0 @background; */
      /*       margin: 18px; */
      /*       padding: 12px; */
      /*     } */

      /*     /* Notifications  */ */
      /*     .control-center .notification-row .notification-background, */
      /*     .control-center .notification-row .notification-background .notification.critical { */
      /*       background-color: alpha(@background, .4); */
      /*       border-radius: 10px; */
      /*       margin: 4px 0px; */
      /*       padding: 4px; */
      /*     } */

      /*     .control-center .notification-row .notification-background .notification.critical { */
      /*       color: @urgent; */
      /*     } */

      /*     .control-center .notification-row .notification-background .notification .notification-content { */
      /*       margin: 4px; */
      /*       padding: 8px 6px 2px 2px; */
      /*     } */

      /*     .control-center .notification-row .notification-background .notification > *:last-child > * { */
      /*       min-height: 3.4em; */
      /*     } */

      /*     .control-center .notification-row .notification-background .notification > *:last-child > * .notification-action { */
      /*       background: @background-alt; */
      /*       color: @text; */
      /*       border-radius: 8px; */
      /*       margin: 6px; */
      /*       border: 2px solid transparent; */
      /*     } */

      /*     .control-center .notification-row .notification-background .notification > *:last-child > * .notification-action:hover { */
      /*       color: @background; */
      /*     } */

      /*     .control-center .notification-row .notification-background .notification > *:last-child > * .notification-action:active { */
      /*       background-color: @selected; */
      /*       color: @background; */
      /*     } */

      /*     /* Buttons */ */

      /*     .control-center .notification-row .notification-background .close-button { */
      /*       border: 1px solid transparent; */
      /*       background: transparent; */
      /*       border-radius: 6px; */
      /*       color: @selected; */
      /*       margin: 0px; */
      /*       padding: 4px; */
      /*     } */

      /*     .control-center .notification-row .notification-background .close-button:hover { */
      /*       background-color: @background; */
      /*       border: 1px solid @selected; */
      /*     } */

      /*     .control-center .notification-row .notification-background .close-button:active { */
      /*       background-color: @selected; */
      /*       color: @background; */
      /*     } */

      /*     progressbar, */
      /*     progress, */
      /*     trough { */
      /*       border-radius: 12px; */
      /*     } */

      /*     progressbar { */
      /*       background-color: rgba(255,255,255,.1); */
      /*     } */

      /*     /* Notifications expanded-group */ */

      /*     .notification-group { */
      /*       margin: 2px 8px 2px 8px; */

      /*     } */
      /*     .notification-group-headers { */
      /*       font-weight: bold; */
      /*       font-size: 1.25rem; */
      /*       color: @text; */
      /*       letter-spacing: 2px; */
      /*       margin-bottom: 16px; */
      /*     } */

      /*     .notification-group-icon { */
      /*       color: @text; */
      /*     } */

      /*     .notification-group-collapse-button, */
      /*     .notification-group-close-all-button { */
      /*       background: transparent; */
      /*       margin: 4px; */
      /*       border: 2px solid transparent; */
      /*       border-radius: 8px; */
      /*       padding: 4px; */
      /*     } */

      /*     .notification-group-collapse-button:hover, */
      /*     .notification-group-close-all-button:hover { */
      /*       background: alpha(@text, .2); */
      /*       border: 2px solid @text; */
      /*     } */

      /*     /* WIDGETS --------------------------------------------------------------------------- */ */

      /*       /* Notification clear button */ */
      /*     .widget-title { */
      /*       font-size: 1.2em; */
      /*       margin: 2px; */
      /*     } */

      /*     .widget-title button { */
      /*       border-radius: 10px; */
      /*       padding: 4px 16px; */
      /*       border: 2px solid @selected; */
      /*     } */

      /*     .widget-title button:hover { */
      /*       background-color: alpha(@text, .2); */
      /*       border: 2px solid @selected; */
      /*     } */

      /*     .widget-title button:active { */
      /*       background-color: @selected; */
      /*       color: @background; */
      /*     } */

      /*       /* Do not disturb */ */
      /*     .widget-dnd { */
      /*       margin: 8px 2px; */
      /*       font-size: 1.2rem; */
      /*     } */

      /*     .widget-dnd > switch { */
      /*       font-size: initial; */
      /*       border-radius: 8px; */
      /*       border: 2px solid @selected; */
      /*       box-shadow: none; */
      /*     } */

      /*     .widget-dnd > switch:hover { */
      /*       background: alpha(@text, .2); */
      /*     } */

      /*     .widget-dnd > switch:checked { */
      /*       background: @selected; */
      /*     } */

      /*     .widget-dnd > switch:checked:hover { */
      /*       background: alpha(@selected, .8); */
      /*     } */

      /*     .widget-dnd > switch slider { */
      /*       background: @text; */
      /*       border-radius: 6px; */
      /*     } */

      /*       /* Buttons menu */ */
      /*     .widget-buttons-grid { */
      /*       font-size: x-large; */
      /*       padding: 6px 2px; */
      /*       margin: 6px; */
      /*       border-radius: 12px; */
      /*       background: alpha(@selected, .2); */
      /*     } */

      /*     .widget-buttons-grid>flowbox>flowboxchild>button { */
      /*       margin: 4px 10px; */
      /*       padding: 6px 12px; */
      /*       background: transparent; */
      /*       border-radius: 8px; */
      /*       border: 2px solid transparent; */
      /*     } */

      /*     .widget-buttons-grid>flowbox>flowboxchild>button:hover { */
      /*       background: alpha(@background-alt, .6); */
      /*     } */

      /*       /* Music player */ */
      /*     .widget-mpris { */
      /*         background: alpha(@selected, .2); */
      /*         border-radius: 16px; */
      /*         color: @text; */
      /*         padding: 6px; */
      /*         margin:  20px 6px; */
      /*     } */

      /*     .widget-mpris button { */
      /*       color: alpha(@text, .6); */
      /*       border-radius: 6px; */
      /*     } */

      /*     .widget-mpris button:hover { */
      /*       color: @text; */
      /*     } */

      /*       /* NOTE: Background need *opacity 1* otherwise will turn into the album art blurred  */ */
      /*     .widget-mpris-player { */
      /*         background: @selected; */
      /*         padding: 6px 10px; */
      /*         margin: 10px; */
      /*         border-radius: 14px; */
      /*     } */

      /*     .widget-mpris-album-art { */
      /*       border-radius: 16px; */
      /*     } */

      /*     .widget-mpris-title { */
      /*         font-weight: 700; */
      /*         font-size: 1rem; */
      /*     } */

      /*     .widget-mpris-subtitle { */
      /*         font-weight: 500; */
      /*         font-size: 0.8rem; */
      /*     } */

      /*     /* Volume */ */
      /*     .widget-volume { */
      /*       background: @background-alt; */
      /*       color: @background; */
      /*       padding: 4px; */
      /*       margin: 6px; */
      /*       border-radius: 6px; */
      /*     } */
    '';

  home.file.".configavizoconfig.ini".text =
    /*
    ini
    */
    ''
      [default]
      # The time to show the notification for.
      ;time = 5.0

      # The base directory to resolve relative image-path against (default is $XDG_DATA_HOMEavizo).
      ;image-base-dir =

      # The image opacity; allowed values range from 0 (fully transparent) to 1.0 (fully opaque).
      ;image-opacity = 1.0

      # The width of the notification.
      ;width = 248
      width = 297

      # The height of the notification.
      ;height = 232
      height = 185

      # The inner padding of the notification.
      ;padding = 24

      # A relative offset of the notification to the top of the screen.
      # Allowed values range from 0 (top) to 1.0 (bottom).
      y-offset = 0.75

      # The border radius of the notification in px.
      border-radius = 20

      # Sets the border width of the notification in px.
      ;border-width = 1

      # The block height of the progress indicator.
      ;block-height = 10

      # The spacing between blocks in the progress indicator.
      ;block-spacing = 2

      # Sets the amount of blocks in the progress indicator.
      block-count = 20

      # Sets the fade in animation duration in seconds.
      fade-in = 0.2

      # Sets the fade out animation duration in seconds.
      fade-out = 0.5

      # The color of the notification background in format: rgba([0, 255], [0, 255], [0, 255], [0, 1]).
      background = rgba(160, 160, 160, 0.9)

      # Sets the color of the notification border in format rgba([0, 255], [0, 255], [0, 255], [0, 1]).
      ;border-color = rgba(90, 90, 90, 0.8)

      # The color of the filled bar blocks in format: rgba([0, 255], [0, 255], [0, 255], [0, 1]).
      ;bar-fg-color = rgba(0, 0, 0, 0.8)

      # The color of the unfilled bar blocks in format rgba([0, 255], [0, 255], [0, 255], [0, 1]).
      # Defaults to 'background' with 23 brightness.
      ;bar-bg-color =
    '';
}
