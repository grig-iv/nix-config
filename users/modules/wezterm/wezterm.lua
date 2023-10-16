local wezterm = require 'wezterm'
local act = wezterm.action

return {
    color_scheme = "Catppuccin Mocha",
    enable_tab_bar = false,
    disable_default_key_bindings = true,
    mouse_bindings = {
        -- Bind 'Up' event of click to open hyperlinks
        {
            event = { Up = { streak = 1, button = 'Left' } },
            action = act.OpenLinkAtMouseCursor,
        },

        -- Scrolling up while holding CTRL increases the font size
        {
            event = { Down = { streak = 1, button = { WheelUp = 1 } } },
            mods = 'CTRL',
            action = act.IncreaseFontSize,
        },

        -- Scrolling down while holding CTRL decreases the font size
        {
            event = { Down = { streak = 1, button = { WheelDown = 1 } } },
            mods = 'CTRL',
            action = act.DecreaseFontSize,
        },
    }
}
