#!/usr/bin/env bash

########################## GENERAL ##########################
######### FONTS #########
export monospace_font="Iosevka Nerd Font"
export san_serif_font="Product Sans"

######### COLORS #########
export foreground="#d4be98"
export background="#1d2021"

export black="#665c54"
export b_black="#928374"

export red="#ea6962"
export b_red="#ea6962"

export green="#a9b665"
export b_green="#a9b665"

export yellow="#e78a4e"
export b_yellow="#d8a657"

export blue="#7daea3"
export b_blue="#7daea3"

export magenta="#d3869b"
export b_magenta="#d3869b"

export cyan="#89b482"
export b_cyan="#89b482"

export white="#d4be98"
export b_white="#d4be98"

########################## KITTY ##########################
export kitty_opacity=0.6

export kitty_selection_foreground="#1d2021"
export kitty_selection_background="#d4be98"
export kitty_url_color="#d8a657"
export kitty_active_border_color="#d3869b"
export kitty_inactive_border_color="#141617"
export kitty_bell_border_color="#e78a4e"
export kitty_active_tab_forground="#d4be98"
export kitty_active_tab_background="#1d2021"
export kitty_inactive_tab_background="#1d2021"
export kitty_mark3_background="#a89984"

########################## HYPRLAND ##########################
export hyprland_gaps_in=10
export hyprland_gaps_out=15
export hyprland_border_size=2
export hyprland_active_border="rgba(32361aaa)"
export hyprland_inactive_border="rgba(141617ee)"

export hyprland_border_radius=5
export hyprland_has_blur="yes"
export hyprland_blur_size=3
export hyprland_blur_passes=3

export hyrpland_has_shadow="no"
export hyrpland_shadow_range=4
export hyrpland_render_power=3
export hyrpland_shadow_color="rgba(282828ee)"

########################## CAVA ##########################
export cava_file="[color]\nbackground = default\nforeground = default"

########################## WLOGOUT ##########################
export wlogout_color="#333e34"
export wlogout_background="rgba(29, 32, 33, 0.2)"
export wlogout_button_background="rgba(29, 32, 33, 0)"
export wlogout_button_background_hover="rgba(234, 105, 98, 0.1)"
export wlogout_button_background_focus="#89b482"
export wlogout_button_foreground_focus="#665c54"
export wlogout_button_border_radius="2px"

########################## EWW ##########################
export eww_x="0%"
export eww_y="1%"
export eww_w="80%"
export eww_h="36px"

export eww_bar_border_radius="10px"
export eww_widgets_border_radius="5px"

export rosewater="#d8a657"
export flamingo="#ea6962"
export mauve="#d3869b"
export dark_mauve="#d3869b"
export maroon="#3c1f1e"
export peach="#d8a657"
export teal="#7daea3"
export sky="#89b482"
export sapphire="#7daea3"
export dark_blue="#89b482"
export lavender="#7daea3"

export overlay2="#7c6f64"
export overlay1="#928374"
export overlay0="#a89984"

export surface0="#32302f"

export base="#1d2021"
export mantle="#928374"
export crust="#665c54"

export border="#32361a"

########################## NVIM ##########################
export nvim_theme="gruvbox"

export nvim_lualine_a='{\n          function()\n            return "󰧱"\n          end,\n          color = function()\n            return { bg = mode_color[vim.fn.mode()] }\n          end,\n        },\n        {\n          "mode",\n          color = function()\n            return { bg = mode_color[vim.fn.mode()] }\n          end,\n        },\n'
export nvim_lualine_b='{\n          "branch",\n          icon = "",\n          color = { bg = c.surface0, fg = c.purple },\n        },\n        {\n          "diff",\n          colored = true,\n          symbols = i_lualine.diff,\n          color = { bg = c.surface0 },\n        },\n'
export nvim_lualine_x='{\n          lsp_progess,\n          color = { bg = c.surface0 },\n          cond = conditions.has_lsp_client,\n        },\n        {\n          function()\n            return "󰘦"\n          end,\n          color = { bg = c.purple, fg = c.black },\n          cond = conditions.has_lsp_client,\n        },\n'

########################## DUNST ##########################
export dunst_low_frame_color="#7daea3"
export dunst_normal_frame_color="#89b482"
export dunst_critical_frame_color="#ea6962"
