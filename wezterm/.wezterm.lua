local wezterm = require 'wezterm'
local config = wezterm.config_builder()
local color_frame = 'gray'

-- window setting
config.window_background_opacity = 0.8
config.macos_window_background_blur = 28
config.window_padding = {
    left = 2,
    right = 2,
    top = 8,
    bottom = 8,
}

config.color_scheme = 'Tokyo Night'
config.font = wezterm.font("0xProto Nerd Font Mono", {weight = "Bold",stretch="Expanded"})
config.font_size = 13
config.line_height = 1.2
config.enable_tab_bar = false
config.window_decorations = "RESIZE"

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

-- for window platform
-- config.default_prog = { 'powershell' }

return config