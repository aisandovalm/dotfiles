-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices.

-- Initial window geometry — large centered window with desktop visible around it
config.initial_cols = 220
config.initial_rows = 50

-- Font and color scheme
config.color_scheme = 'rose-pine-moon'
config.max_fps = 120
config.font = wezterm.font("Hack Nerd Font", { weight = "Regular" })
config.font_size = 13.0

-- Tab bar: plain style at the top (matches screenshot)
config.enable_tab_bar = true
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = false
config.hide_tab_bar_if_only_one_tab = true
config.tab_max_width = 32

config.window_frame = {
  font = wezterm.font("Hack Nerd Font", { weight = "Bold" }),
  font_size = 13.0,
}

-- Window decorations: RESIZE keeps the window resizable without a title bar
config.window_decorations = "RESIZE"

-- Inactive pane dimming
config.inactive_pane_hsb = {
  saturation = 0.0,
  brightness = 0.5,
}

-- Background blur (macOS)
config.window_background_opacity = 0.8
config.macos_window_background_blur = 50

-- Key bindings
config.disable_default_key_bindings = true
config.leader = { key = "w", mods = "CTRL" }
config.keys = {
  {
    key = "v",
    mods = "CMD",
    action = wezterm.action({ PasteFrom = "Clipboard" }),
  },
  {
    key = "c",
    mods = "LEADER",
    action = wezterm.action.SpawnTab("CurrentPaneDomain"),
  },

  -- ── Tabs ────────────────────────────────────────────────────────────
  -- Create / close
  { key = 't', mods = 'CTRL|SHIFT', action = wezterm.action.SpawnTab 'CurrentPaneDomain' },
  { key = 'w', mods = 'CTRL|SHIFT', action = wezterm.action.CloseCurrentTab { confirm = true } },
  -- Cycle
  { key = 'Tab', mods = 'CTRL',       action = wezterm.action.ActivateTabRelative(1) },
  { key = 'Tab', mods = 'CTRL|SHIFT', action = wezterm.action.ActivateTabRelative(-1) },
  -- Jump to tab by number
  { key = '1', mods = 'ALT', action = wezterm.action.ActivateTab(0) },
  { key = '2', mods = 'ALT', action = wezterm.action.ActivateTab(1) },
  { key = '3', mods = 'ALT', action = wezterm.action.ActivateTab(2) },
  { key = '4', mods = 'ALT', action = wezterm.action.ActivateTab(3) },
  { key = '5', mods = 'ALT', action = wezterm.action.ActivateTab(4) },
  { key = '6', mods = 'ALT', action = wezterm.action.ActivateTab(5) },
  { key = '7', mods = 'ALT', action = wezterm.action.ActivateTab(6) },
  { key = '8', mods = 'ALT', action = wezterm.action.ActivateTab(7) },
  { key = '9', mods = 'ALT', action = wezterm.action.ActivateTab(8) },

  -- ── Panes ────────────────────────────────────────────────────────────
  -- Split panes
  { key = "|", mods = "LEADER", action = wezterm.action.SplitHorizontal { domain = "CurrentPaneDomain" } },
  { key = "-", mods = "LEADER", action = wezterm.action.SplitVertical   { domain = "CurrentPaneDomain" } },
  -- Navigate between panes
  { key = 'h', mods = 'CTRL|SHIFT', action = wezterm.action.ActivatePaneDirection 'Left' },
  { key = 'l', mods = 'CTRL|SHIFT', action = wezterm.action.ActivatePaneDirection 'Right' },
  { key = 'k', mods = 'CTRL|SHIFT', action = wezterm.action.ActivatePaneDirection 'Up' },
  { key = 'j', mods = 'CTRL|SHIFT', action = wezterm.action.ActivatePaneDirection 'Down' },
  -- Close current pane
  { key = 'x', mods = 'CTRL|SHIFT', action = wezterm.action.CloseCurrentPane { confirm = true } },
}

-- Tab bar colors (orange active tab, dark inactive — matches screenshot)
config.colors = {
  tab_bar = {
    background = '#1a1a2e',

    active_tab = {
      bg_color = '#c6783a',
      fg_color = '#ffffff',
    },
    inactive_tab = {
      bg_color = '#2d2d3f',
      fg_color = '#a0a0b0',
    },
    inactive_tab_hover = {
      bg_color = '#3d3d50',
      fg_color = '#c0c0d0',
    },
    new_tab = {
      bg_color = '#2d2d3f',
      fg_color = '#a0a0b0',
    },
    new_tab_hover = {
      bg_color = '#3d3d50',
      fg_color = '#c0c0d0',
    },
  },
}

return config
