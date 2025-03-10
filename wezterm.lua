--local wezterm = requiere('wezterm')
local config = {}

--config.initial_cols = 180
--config.initial_rows = 70
config.audible_bell = 'Disabled'
config.window_decorations = 'TITLE | RESIZE'

config.window_frame = {
	border_left_width = '0.15cell',
	border_right_width = '0.15cell',
	border_bottom_height = '0.15cell',
	border_top_height = '0.15cell',

	border_left_color = 'pink',
	border_right_color = 'pink',
	border_bottom_color = 'pink',
	border_top_color =  'pink',
}

--config.window_background_image = '/home/test/Images/Console/bocch.png';


config.colors = {
	background = '#2A1E2E',
	foreground = '#F2D1E8',
	cursor_bg = '#F28FB0',
	cursor_border = '#F28FB0',
	cursor_fg = '#2A1E2E';
	
	selection_bg = '#3F2C4A',
	selection_fg = '#F2D1E8',

	ansi = {"#2E1F2F", "#F28FB0", "#A3E4D7", "#F7DC6F", "#BB8FCE", "#E59866", "#85C1E9", "#F2D1E8"}, -- Colores básicos
	brights = {"#5D3F5F", "#F7A6C1", "#CDEBD5", "#FAE6A8", "#D7B6DD", "#F0B589", "#AED6F1", "#FAE1EF"}, -- Colores brillantes
}

config.font_size = 13
config.enable_tab_bar = false
config.window_background_opacity = 0.5
--config.disable_default_key_bindings = true

return config

