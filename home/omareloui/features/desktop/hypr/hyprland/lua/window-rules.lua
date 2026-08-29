local shouldFloatClasses = "transmission-gtk|org.gnome.Loupe|pavucontrol|scratchpad|nm-connection-editor|org.keepassxc.KeePassXC"
local scratchpad = "^scratchpad-.*"
local bluetoothClientRe = "^blueman-manager$"
local fileSelectorTitleRe = "^(Select file to open)$"
local fileSelectorClassRe = "^(xdg-desktop-portal-gtk)$"
local pipRe = "Picture[- ]in[- ][Pp]icture"
local ueberzugppRe = "^ueberzugpp_.*"

hl.window_rule({
  match = { class = ueberzugppRe },
  float = true,
  no_anim = true,
  no_focus = true,
  no_shadow = true,
  no_blur = true,
  border_size = 0,
  rounding = 0,
  size = { 800, 800 },
})

hl.window_rule({
  match = { class = scratchpad },
  workspace = "special silent",
  stay_focused = true,
})

hl.window_rule({
  match = { class = "^gamescope$" },
  fullscreen = true,
})

hl.window_rule({
  match = { class = "^(" .. shouldFloatClasses .. ")$" },
  float = true,
  center = true,
})

hl.window_rule({
  match = { class = bluetoothClientRe },
  float = true,
  center = true,
  size = { 750, 445 },
})

hl.window_rule({
  match = { title = fileSelectorTitleRe },
  float = true,
  center = true,
  size = { 1160, 680 },
})

hl.window_rule({
  match = { class = fileSelectorClassRe },
  float = true,
  center = true,
  size = { 1160, 680 },
})

hl.window_rule({
  match = { class = "^thunar$", title = "^(File Operation Progress)$" },
  float = true,
})

hl.window_rule({
  match = { class = "^org.inkscape.Inkscape$", title = "^(|Measure Path|PDF Import Settings|Calender|Frame|Offset Paths)$" },
  float = true,
})

hl.window_rule({
  match = { class = "^transmission-gtk$", title = "^Transmission$" },
  size = { 960, 520 },
})

hl.window_rule({
  match = { class = "^transmission-gtk$", title = "^Torrent Options$" },
  size = { 482, 567 },
})

hl.window_rule({
  match = { class = "^(microsoft-edge|zen-beta)$" },
  opacity = "0.95 0.95",
})

hl.window_rule({
  match = { class = "^(kitty|org.wezfurlong.wezterm)$" },
  opacity = "0.95 0.8",
})

hl.window_rule({
  match = { class = "^(org.gnome.Nautilus)$" },
  opacity = "0.85 0.8",
})

hl.window_rule({
  match = { title = "^(" .. pipRe .. ")$" },
  opacity = "1 1",
  pin = true,
  float = true,
  size = { 656, 386 },
  move = { 1137, 733 },
})

hl.layer_rule({ match = { namespace = "rofi" }, blur = true, ignore_alpha = 0 })
hl.layer_rule({ match = { namespace = "waybar" }, blur = true })
@ANYRUN_LAYER_RULE@
@SWAYOSD_LAYER_RULE@
hl.layer_rule({ match = { namespace = "wlogout" }, blur = true })
hl.layer_rule({ match = { namespace = "swaync-control-center" }, blur = true, ignore_alpha = 0 })
hl.layer_rule({ match = { namespace = "swaync-notification-window" }, blur = true, ignore_alpha = 0 })
