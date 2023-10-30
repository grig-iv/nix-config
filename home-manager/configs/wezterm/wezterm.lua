local wezterm = require 'wezterm'
local act = wezterm.action

return {
    color_scheme = "Catppuccin Mocha",
    enable_tab_bar = false,
    disable_default_key_bindings = true,

    font = wezterm.font_with_fallback {
        { family = "JetBrainsMono Nerd Font" },
        'Noto Sans Sinhala', -- amoungus font "ඞ"
    },

    keys = {
        {
            key = 'Enter',
            mods = 'CTRL',
            action = act.SendKey { key = 'Enter', mods = 'CTRL' },
        },
        { key = 'V', mods = 'CTRL|SHIFT', action = act.PasteFrom 'Clipboard' },
        { key = 'C', mods = 'CTRL|SHIFT', action = act.CopyTo 'ClipboardAndPrimarySelection' },
    },

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
