{
  pkgs,
  config,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    swaynotificationcenter
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
        text = "Inhibitors";
        button-text = "Clear All";
        clear-all-button = true;
      };
      title = {
        text = "Notifications";
        clear-all-button = false;
        button-text = "Clear All";
      };
      dnd = {
        text = "Do Not Disturb";
      };
      label = {
        max-lines = 5;
        text = "Label text";
      };
      mpris = {
        image-size = 96;
        image-radius = 12;
      };
    };
  };

  services.swayosd = {
    enable = true;
  };

  wayland.windowManager.hyprland.settings = lib.mkIf config.services.swayosd.enable {
    bind = [
      ",XF86MonBrightnessUp, exec, swayosd-client --brightness raise"
      ",XF86MonBrightnessDown, exec, swayosd-client --brightness lower"

      ",XF86AudioRaiseVolume, exec, swayosd-client --output-volume raise"
      ",XF86AudioLowerVolume, exec, swayosd-client --output-volume lower"
      ",XF86AudioMute, exec, swayosd-client --output-volume mute-toggle"
    ];

    exec-once = ["swayosd-server"];
  };

  home.file.".config/swayosd/style.css".text =
    lib.mkIf config.services.swayosd.enable
    /*
    css
    */
    '''';
}
