#!/usr/bin/env bash

# Source: https://github.com/mountain-theme/Mountain/blob/master/docs/fuji.org

########################## GENERAL ##########################
######### FONTS #########
export monospace_font="Iosevka Nerd Font"
export san_serif_font="Product Sans"

######### COLORS #########
export foreground="#f0f0f0"
export background="#0f0f0f"

export black="#262626"
export b_black="#4c4c4c"

export red="#ac8a8c"
export b_red="#c49ea0"

export green="#8aac8b"
export b_green="#9ec49f"

export yellow="#aca98a"
export b_yellow="#c4c19e"

export blue="#8f8aac"
export b_blue="#a39ec4"

export magenta="#ac8aac"
export b_magenta="#c49ec4"

export cyan="#8aacab"
export b_cyan="#9ec3c4"

export white="#e7e7e7"
export b_white="#f0f0f0"

########################## KITTY ##########################
export kitty_opacity=0.95

export kitty_selection_foreground="#262626"
export kitty_selection_background="#f0f0f0"
export kitty_url_color="#c6a679"
export kitty_active_border_color="#ac8aac"
export kitty_inactive_border_color="#262626"
export kitty_bell_border_color="#aca98a"
export kitty_active_tab_forground="#262626"
export kitty_active_tab_background="#8aacab"
export kitty_inactive_tab_background="#4c4c4c"
export kitty_mark3_background="#8f8aac"

########################## HYPRLAND ##########################
export hyprland_gaps_in=5
export hyprland_gaps_out=10
export hyprland_border_size=4
export hyprland_active_border="rgba(f0f0f0aa)"
export hyprland_inactive_border="rgba(0f0f0fee)"

export hyprland_border_radius=0
export hyprland_has_blur="yes"
export hyprland_blur_size=3
export hyprland_blur_passes=3

export hyrpland_has_shadow="no"
export hyrpland_shadow_range=4
export hyrpland_render_power=3
export hyrpland_shadow_color="rgba(1a1a1aee)"

########################## CAVA ##########################
export cava_file="[color]\nbackground = default\nforeground = default"

########################## WLOGOUT ##########################
export wlogout_color="#e7e7e7"
export wlogout_background="rgba(15, 15, 15, 0.2)"
export wlogout_button_background="rgba(15, 15, 15, 0)"
export wlogout_button_background_hover="rgba(196, 158, 160, 0.1)"
export wlogout_button_background_focus="#c49ec4"
export wlogout_button_foreground_focus="#262626"
export wlogout_button_border_radius="2px"

########################## EWW ##########################
export eww_x="0%"
export eww_y="0%"
export eww_w="100%"
export eww_h="26px"

export eww_bar_border_radius="0px"
export eww_widgets_border_radius="5px"

export rosewater="#ceb188"
export flamingo="#c49ea0"
export mauve="#ac8aac"
export dark_mauve="#c49ec4"
export maroon="#ac8a8c"
export peach="#c6a679"
export teal="#a5b4cb"
export sky="#8a98ac"
export sapphire="#8aacab"
export dark_blue="#8a98ac"
export lavender="#a5b4cb"

export overlay2="#767676"
export overlay1="#a0a0a0"
export overlay0="#bfbfbf"

export surface0="#393939"

export base="#0f0f0f"
export mantle="#191919"
export crust="#262626"

export border="#4c4c4c"

########################## NVIM ##########################
export nvim_theme="mountain"

export nvim_lualine_a="{\n          function()\n            return ''\n          end,\n          color = function()\n            return { bg = mode_color[vim.fn.mode()] }\n          end,\n        },\n        {\n          'mode',\n          color = function()\n            return { bg = mode_color[vim.fn.mode()] }\n          end,\n        },\n"
export nvim_lualine_b="{\n          'branch',\n          icon = '',\n          color = { bg = c.surface0, fg = c.purple },\n        },\n        {\n          'diff',\n          colored = true,\n          symbols = i_lualine.diff,\n          color = { bg = c.surface0 },\n        },\n"
export nvim_lualine_x="{\n          lsp_progess,\n          color = { bg = c.surface0 },\n          cond = conditions.has_lsp_client,\n        },\n        {\n          function()\n            return '󰘦'\n          end,\n          color = { bg = c.purple, fg = c.black },\n          cond = conditions.has_lsp_client,\n        },\n"
