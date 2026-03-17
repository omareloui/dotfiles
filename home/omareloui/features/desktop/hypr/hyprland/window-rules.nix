{
  lib,
  config,
  ...
}: {
  wayland.windowManager.hyprland.settings = {
    windowrule = let
      shouldFloatClasses = "transmission-gtk|org\.gnome\.Loupe|pavucontrol|scratchpad|nm-connection-editor|org\.keepassxc\.KeePassXC";
      scratchpad = "match:class ^scratchpad-.*";
      bluetoothClientRe = "^\.blueman-manager-wrapped$";
      fileSelectorTitleRe = "^(Select file to open)$";
      fileSelectorClassRe = "^(xdg-desktop-portal-gtk)$";
      pipRe = "Picture[\- ]in[\- ][Pp]icture";
      ueberzugppRe = "match:class ^ueberzugpp_.*";
    in [
      "float on, ${ueberzugppRe}"
      "no_anim on, ${ueberzugppRe}"
      "no_focus on, ${ueberzugppRe}"
      "no_shadow on, ${ueberzugppRe}"
      "no_blur on, ${ueberzugppRe}"
      "border_size 0, ${ueberzugppRe}"
      "rounding 0, ${ueberzugppRe}"
      "size 800 800, ${ueberzugppRe}"

      "workspace special silent, ${scratchpad}"
      "stay_focused on, ${scratchpad}"

      "float on, match:class ^(${shouldFloatClasses})$"
      "center on, match:class ^(${shouldFloatClasses})$"

      "float on, match:class ${bluetoothClientRe}"
      "center on, match:class ${bluetoothClientRe}"
      "size 750 445, match:class ${bluetoothClientRe}"

      "float on, match:title ${fileSelectorTitleRe}"
      "center on, match:title ${fileSelectorTitleRe}"
      "size 1160 680, match:title ${fileSelectorTitleRe}"

      "float on, match:class ${fileSelectorClassRe}"
      "center on, match:class ${fileSelectorClassRe}"
      "size 1160 680, match:class ${fileSelectorClassRe}"

      "float on, match:class ^thunar$, match:title ^(File Operation Progress)$"
      "float on, match:class ^org.inkscape.Inkscape$, match:title ^(|Measure Path|PDF Import Settings|Calender|Frame|Offset Paths)$"

      "size 960 520, match:class ^transmission-gtk$, match:title ^Transmission$"
      "size 482 567, match:class ^transmission-gtk$, match:title ^Torrent Options$"

      "opacity 0.95 0.95, match:class ^(microsoft-edge|zen-beta)$"
      "opacity 0.95 0.8, match:class ^(kitty|org\.wezfurlong\.wezterm)$"
      "opacity 0.85 0.8, match:class ^(org.gnome.Nautilus)$"

      "opacity 1 1, match:title ^(${pipRe})$"
      "pin on, match:title ^(${pipRe})$"
      "float on, match:title ^(${pipRe})$"
      "size 656 386, match:title ^(${pipRe})$"
      "move 1137 733, match:title ^(${pipRe})$"
    ];

    layerrule = [
      "blur on, match:namespace rofi"
      "ignore_alpha 0, match:namespace rofi"

      "blur on, match:namespace waybar"

      (lib.mkIf config.programs.anyrun.enable "blur on, match:namespace anyrun")
      (lib.mkIf config.programs.anyrun.enable "ignore_alpha 0, match:namespace anyrun")

      (lib.mkIf config.services.swaync .enable "blur on, match:namespace swayosd")
      (lib.mkIf config.services.swaync .enable "ignore_alpha 0, match:namespace swayosd")

      "blur on, match:namespace wlogout"

      "blur on, match:namespace swaync-control-center"
      "ignore_alpha 0, match:namespace swaync-control-center"
      "blur on, match:namespace swaync-notification-window"
      "ignore_alpha 0, match:namespace swaync-notification-window"
    ];
  };
}
