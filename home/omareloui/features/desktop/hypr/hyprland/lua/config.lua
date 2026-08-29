hl.config({
  general = {
    gaps_in = 5,
    gaps_out = 14,
    border_size = 2,
    col = {
      active_border = {
        colors = { "rgba(fab387ee)", "rgba(cba6f7ee)" },
        angle = 120,
      },
      inactive_border = "rgba(1e1e2eaa)",
    },
    layout = "dwindle",
    allow_tearing = false,
  },

  input = {
    kb_layout = "us,es,eg",
    kb_options = "grp:alt_shift_toggle",
    repeat_rate = 30,
    repeat_delay = 300,
    numlock_by_default = 1,
    follow_mouse = 1,
    sensitivity = 0,

    touchpad = {
      disable_while_typing = true,
      natural_scroll = true,
      clickfinger_behavior = false,
      tap_to_click = true,
      drag_lock = false,
    },
  },

  decoration = {
    rounding = 10,

    blur = {
      enabled = true,
      size = 10,
      passes = 3,
      new_optimizations = true,
      ignore_opacity = true,
      xray = false,
    },

    active_opacity = 1.0,
    -- inactive_opacity = 0.85,
    fullscreen_opacity = 1.0,

    shadow = {
      enabled = true,
      color = "0x66000000",
      range = 4,
      render_power = 3,
    },
  },

  animations = {
    enabled = true,
  },

  master = {
    new_status = "slave",
  },

  dwindle = {
    preserve_split = true,
    smart_resizing = true,
    force_split = 2,
  },

  misc = {
    enable_swallow = true,
    swallow_regex = "^(Alacritty|kitty|wezterm|footclient|scratchpad)$",
    disable_splash_rendering = true,
    disable_hyprland_logo = true,
  },
})

local function bezier(name, points)
  hl.curve(name, { type = "bezier", points = points })
end

bezier("myBezier", { { 0.05, 0.9 }, { 0.1, 1.05 } })
bezier("overshot1", { { 0.05, 0.9 }, { 0.1, 1.05 } })
bezier("smoothOut", { { 0.5, 0 }, { 0.99, 0.99 } })
bezier("smoothIn", { { 0.5, -0.5 }, { 0.68, 1.5 } })
bezier("linear", { { 0.0, 0.0 }, { 1.0, 1.0 } })
bezier("wind", { { 0.05, 0.9 }, { 0.1, 1.05 } })
bezier("winIn", { { 0.1, 1.1 }, { 0.1, 1.1 } })
bezier("winOut", { { 0.3, -0.3 }, { 0, 1 } })
bezier("slow", { { 0, 0.85 }, { 0.3, 1 } })
bezier("overshot2", { { 0.7, 0.6 }, { 0.1, 1.1 } })
bezier("bounce", { { 1.1, 1.6 }, { 0.1, 0.85 } })
bezier("sligshot", { { 1, -1 }, { 0.15, 1.25 } })

hl.animation({ leaf = "windowsIn", enabled = true, speed = 5, bezier = "winIn", style = "slide" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 5, bezier = "winOut", style = "slide" })
hl.animation({ leaf = "windowsMove", enabled = true, speed = 5, bezier = "wind", style = "slide" })
hl.animation({ leaf = "border", enabled = true, speed = 10, bezier = "linear" })
hl.animation({ leaf = "borderangle", enabled = true, speed = 80, bezier = "linear", style = "loop" })
hl.animation({ leaf = "fade", enabled = true, speed = 5, bezier = "overshot2" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 5, bezier = "wind" })
hl.animation({ leaf = "windows", enabled = true, speed = 5, bezier = "bounce", style = "slide" })

hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })
