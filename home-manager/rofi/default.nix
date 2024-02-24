{
  config,
  pkgs,
  ...
}: {
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    theme = let
      inherit (config.lib.formats.rasi) mkLiteral;
    in {
      "*" = {
        background-color = mkLiteral "#000000";
        foreground-color = mkLiteral "rgba(250, 251, 252, 100%)";
        border-color = mkLiteral "#FFFFFF";
        width = 512;
      };
      "#inputbar" = {
        children = map mkLiteral ["prompt" "entry"];
      };
      "#textbox-prompt-colon" = {
        expand = false;
        str = ":";
        margin = mkLiteral "0px 0.3em 0em 0em";
        text-color = mkLiteral "@foreground-color";
      };
    };
  };
}
