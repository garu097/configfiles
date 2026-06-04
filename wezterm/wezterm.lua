local wezterm = require 'wezterm'
local act = wezterm.action
local config = wezterm.config_builder()
local color_frame = 'gray'
local sizex_frame = '0.4cell'
local sizey_frame = '0.14cell'

-- window setting
config.use_ime = false
config.window_background_opacity = 0.8
config.macos_window_background_blur = 8
config.window_padding = {
    left = 4,
    right = 4,
    top = 12,
    bottom = 4,
}

config.color_scheme = 'tokyonight_night'
config.font = wezterm.font("0xProto Nerd Font Mono", {weight = "Bold", stretch="Expanded"})
config.font_size = 14
config.line_height = 1.5
config.enable_tab_bar = false
config.window_decorations = "RESIZE"
config.initial_rows = 40
config.initial_cols = 280
config.enable_csi_u_key_encoding = true
config.window_frame = {
    border_left_width = sizex_frame,
    border_right_width = sizex_frame,
    border_bottom_height = sizey_frame,
    border_top_height = sizey_frame,
    border_left_color = color_frame,
    border_right_color = color_frame,
    border_bottom_color = color_frame,
    border_top_color = color_frame,
}

config.default_cursor_style = "BlinkingUnderline"
config.cursor_thickness = 2
config.send_composed_key_when_left_alt_is_pressed = false
config.keys = {
    { key = 'f', mods= 'CTRL|CMD', action = act.ToggleFullScreen},
    { key = 'A', mods = 'CTRL|SHIFT', action = act.QuickSelect }, -- Default QuickSelect key bind (Ctrl-Shift-Space) gets capture by something else
    { key = 'Enter', mods = 'ALT', action = act.SendString '\x1b\r' },
}

config.window_close_confirmation = 'NeverPrompt'

-- for window platform
-- config.default_prog = { 'powershell' }

return config