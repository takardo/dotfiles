local wezterm = require 'wezterm'

return {
  -- Set the background transparency
  window_background_opacity = 0.8,  -- Adjust the value for more or less transparency

  -- Disable tabs
  enable_tab_bar = false,

  -- Set a default font
  font = wezterm.font("JetBrains Mono"),

  -- Optional: Set the color scheme
  color_scheme = "Dracula",

  -- Optional: Set a custom window padding
  window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
  },

  -- Confirm on close

    window_close_confirmation = "NeverPrompt",


  -- Disable window decorations (remove the window frame and title bar)
  window_decorations = "NONE",
}
