#!/usr/bin/env bash

########################## GENERAL ##########################
######### FONTS #########
export monospace_font="JetBrainsMono Nerd Font"
export san_serif_font="Product Sans"

######### COLORS #########
export foreground="#CDD6F4"
export background="#1E1E2E"

export black="#45475A"
export b_black="#585B70"

export red="#F38BA8"
export b_red="#F38BA8"

export green="#A6E3A1"
export b_green="#A6E3A1"

export yellow="#F9E2AF"
export b_yellow="#F9E2AF"

export blue="#89B4FA"
export b_blue="#89B4FA"

export magenta="#F5C2E7"
export b_magenta="#F5C2E7"

export cyan="#94E2D5"
export b_cyan="#94E2D5"

export white="#BAC2DE"
export b_white="#A6ADC8"

########################## KITTY ##########################
export kitty_opacity=0.6

export kitty_selection_foreground="#1E1E2E"
export kitty_selection_background="#F5E0DC"
export kitty_url_color="#F5E0DC"
export kitty_active_border_color="#B4BEFE"
export kitty_inactive_border_color="#6C7086"
export kitty_bell_border_color="#F9E2AF"
export kitty_active_tab_forground="#11111B"
export kitty_active_tab_background="#CBA6F7"
export kitty_inactive_tab_background="#181825"
export kitty_mark3_background="#74C7EC"

########################## HYPERLAND ##########################
export hyprland_gaps_in=10
export hyprland_gaps_out=20
export hyprland_border_size=2
export hyprland_active_border="rgba(89b4faee)"
export hyprland_inactive_border="rgba(6c7086aa)"

export hyprland_border_radius=10
export hyprland_has_blur="yes"
export hyprland_blur_size=3
export hyprland_blur_passes=3

export hyrpland_has_shadow="yes"
export hyrpland_shadow_range=4
export hyrpland_render_power=3
export hyrpland_shadow_color="rgba(1a1a1aee)"

########################## CAVA ##########################
export cava_file="[color]\ngradient = 1\ngradient_count = 8\ngradient_color_1 = '#94e2d5'\ngradient_color_2 = '#89dceb'\ngradient_color_3 = '#74c7ec'\ngradient_color_4 = '#89b4fa'\ngradient_color_5 = '#cba6f7'\ngradient_color_6 = '#f5c2e7'\ngradient_color_7 = '#eba0ac'\ngradient_color_8 = '#f38ba8'\n"

########################## WLOGOUT ##########################
export wlogout_color="#cdd6f4"
export wlogout_background="rgba(30, 30, 46, 0.5)"
export wlogout_button_background="rgba(30, 30, 46, 0)"
export wlogout_button_background_hover="rgba(49, 50, 68, 0.1)"
export wlogout_button_background_focus="#cba6f7"
export wlogout_button_foreground_focus="#1e1e2e"
export wlogout_button_border_radius="30px"

########################## EWW ##########################
export eww_x="0%"
export eww_y="1%"
export eww_w="96%"
export eww_h="36px"

export eww_bar_border_radius="12.5px"
export eww_widgets_border_radius="16px"

########################## EWW, NVIM ##########################
export rosewater="#f5e0dc"
export flamingo="#f2cdcd"
export mauve="#cba6f7"
export dark_mauve="#b695de"
export maroon="#eba0ac"
export peach="#fab387"
export teal="#94e2d5"
export sky="#89dceb"
export sapphire="#74c7ec"
export dark_blue="#7ba2e1"
export lavender="#b4befe"

export overlay2="#9399b2"
export overlay1="#7f849c"
export overlay0="#6c7086"

export surface0="#313244"

export base="#141521"
export mantle="#181825"
export crust="#11111b"

export border="#28283d"

########################## NVIM ##########################
export nvim_theme="catppuccin"

export nvim_lualine_a='{\n          "mode",\n          color = function()\n            return { bg = mode_color[vim.fn.mode()] }\n          end,\n          separator = { right = sep.right },\n        },\n'
export nvim_lualine_b='{\n          "branch",\n          icon = "",\n          color = { bg = c.surface0, fg = c.purple },\n          separator = { right = sep.right },\n        },\n        {\n          "diff",\n          colored = true,\n          symbols = i_lualine.diff,\n          color = { bg = c.surface0 },\n          separator = { left = sep.left, right = sep.right },\n        },\n'
export nvim_lualine_x='{\n          lsp_progess,\n          color = { bg = c.surface0 },\n          separator = { left = sep.left },\n          cond = conditions.has_lsp_client,\n        },\n        {\n          function()\n            return i_lualine.lsp\n          end,\n          -- separator = { left = sep.left, right = sep.right },\n          separator = { left = sep.left },\n          color = { bg = c.purple, fg = c.black },\n          cond = conditions.has_lsp_client,\n        },\n'

########################## DUNST ##########################
export dunst_low_frame_color="#191d24"
export dunst_normal_frame_color="#0d0f16"
export dunst_critical_frame_color="#0d0f16"

########################## GTK ##########################
export gtk_is_dark=1
export gtk_theme_name="Catppuccin-Mocha-Standard-Sapphire-Dark"
