local wezterm = require("wezterm")
return {
	adjust_window_size_when_changing_font_size = false,
	color_scheme = "Sonokai (Gogh)",
	enable_tab_bar = false,
	font_size = 13.0,
	font = wezterm.font("Fira Code"),
	macos_window_background_blur = 30,

	-- window_background_image = '/Users/omerhamerman/Downloads/3840x1080-Wallpaper-041.jpg',
	-- window_background_image_hsb = {
	-- 	brightness = 0.01,
	-- 	hue = 1.0,
	-- 	saturation = 0.5,
	-- },
	-- window_background_opacity = 0.92,
	window_background_opacity = 1.0,
	-- window_background_opacity = 0.78,
	-- window_background_opacity = 0.20,
	window_decorations = "RESIZE",
	keys = {
		{
			key = "q",
			mods = "CTRL",
			action = wezterm.action.ToggleFullScreen,
		},
		{
			key = "'",
			mods = "CTRL",
			action = wezterm.action.ClearScrollback("ScrollbackAndViewport"),
		},
		{
			key = "H",
			mods = "CMD|SHIFT",
			action = wezterm.action.ActivatePaneDirection("Left"),
		},
		{
			key = "L",
			mods = "CMD|SHIFT",
			action = wezterm.action.ActivatePaneDirection("Right"),
		},
		{
			key = "K",
			mods = "CMD|SHIFT",
			action = wezterm.action.ActivatePaneDirection("Up"),
		},
		{
			key = "J",
			mods = "CMD|SHIFT",
			action = wezterm.action.ActivatePaneDirection("Down"),
		},
	},
	mouse_bindings = {
		-- Ctrl-click will open the link under the mouse cursor
		{
			event = { Up = { streak = 1, button = "Left" } },
			mods = "CTRL",
			action = wezterm.action.OpenLinkAtMouseCursor,
		},
	},
}
