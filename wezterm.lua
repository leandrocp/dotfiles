local wezterm = require("wezterm")
local action = wezterm.action

return {
  color_scheme = "Catppuccin Frappe",
  font = wezterm.font("Hack Nerd Font Mono"),
  font_size = 14.0,

  window_padding = {
    left = "1.5cell",
    right = "1.5cell",
    top = "0.5cell",
    bottom = "0.5cell",
  },

  leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 },

  keys = {
    { key = "h", mods = "LEADER", action = action.ActivatePaneDirection("Left") },
    { key = "l", mods = "LEADER", action = action.ActivatePaneDirection("Right") },
    { key = "j", mods = "LEADER", action = action.ActivatePaneDirection("Down") },
    { key = "k", mods = "LEADER", action = action.ActivatePaneDirection("Up") },
    { key = "-", mods = "LEADER", action = action.SplitVertical({ domain = "CurrentPaneDomain" }) },
    { key = "\\", mods = "LEADER", action = action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
  },
}
