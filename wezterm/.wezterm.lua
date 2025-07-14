local wezterm = require 'wezterm'
local config = wezterm.config_builder()
local color_frame = 'pink'
-- window setting
config.window_background_opacity = 0.97
config.macos_window_background_blur = 20
config.window_padding = {
    left = 4,
    right = 4,
    top = 8,
    bottom = 4,
}

config.color_scheme = 'Tokyo Night'
config.font = wezterm.font("0xProto Nerd Font Mono", {weight = "Bold", stretch="Expanded"})
config.font_size = 14
config.line_height = 1.4
config.enable_tab_bar = false
config.window_decorations = "RESIZE"
config.initial_rows = 40
config.initial_cols = 280
config.window_frame = {
    border_left_width = "0.28cell",
    border_right_width = "0.28cell",
    border_bottom_height = "0.14cell",
    border_top_height = "0.14cell",
    border_left_color = color_frame,
    border_right_color = color_frame,
    border_bottom_color = color_frame,
    border_top_color = color_frame,
}

config.default_cursor_style = "BlinkingUnderline"
config.cursor_thickness = 2
config.keys = {
    { key = 'f', mods= 'CTRL|CMD', action = wezterm.action.ToggleFullScreen},
    { key = 'A', mods = 'CTRL|SHIFT', action = wezterm.action.QuickSelect } -- Default QuickSelect key bind (Ctrl-Shift-Space) gets capture by something else
}

config.window_close_confirmation = 'NeverPrompt'

-- for window platform
-- config.default_prog = { 'powershell' }

return config