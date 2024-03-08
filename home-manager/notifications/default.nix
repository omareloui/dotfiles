{pkgs, ...}: {
  home.packages = with pkgs; [
    swaynotificationcenter
    avizo
  ];

  home.file.".config/swaync/config.json".text = builtins.toJSON {
    "$schema" = "${pkgs.swaynotificationcenter}/configSchema.json";
    positionX = "right";
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

  home.file.".config/avizo/config.ini".text =
    /*
    ini
    */
    ''
      [default]
      # The time to show the notification for.
      ;time = 5.0

      # The base directory to resolve relative image-path against (default is $XDG_DATA_HOME/avizo).
      ;image-base-dir =

      # The image opacity; allowed values range from 0 (fully transparent) to 1.0 (fully opaque).
      ; image-opacity = 1.0

      # The width of the notification.
      ;width = 248

      # The height of the notification.
      ;height = 232

      # The inner padding of the notification.
      ;padding = 24

      # A relative offset of the notification to the top of the screen.
      # Allowed values range from 0 (top) to 1.0 (bottom).
      ;y-offset = 0.75

      # The border radius of the notification in px.
      ;border-radius = 16

      # Sets the border width of the notification in px.
      ;border-width = 1

      # The block height of the progress indicator.
      ;block-height = 10

      # The spacing between blocks in the progress indicator.
      ;block-spacing = 2

      # Sets the amount of blocks in the progress indicator.
      ;block-count = 20

      # Sets the fade in animation duration in seconds.
      ;fade-in = 0.2

      # Sets the fade out animation duration in seconds.
      ;fade-out = 0.5

      # The color of the notification background in format: rgba([0, 255], [0, 255], [0, 255], [0, 1]).
      ;background = rgba(160, 160, 160, 0.8)

      # Sets the color of the notification border in format rgba([0, 255], [0, 255], [0, 255], [0, 1]).
      ;border-color = rgba(90, 90, 90, 0.8)

      # The color of the filled bar blocks in format: rgba([0, 255], [0, 255], [0, 255], [0, 1]).
      ;bar-fg-color = rgba(0, 0, 0, 0.8)

      # The color of the unfilled bar blocks in format rgba([0, 255], [0, 255], [0, 255], [0, 1]).
      # Defaults to 'background' with 2/3 brightness.
      ;bar-bg-color =
    '';
}
