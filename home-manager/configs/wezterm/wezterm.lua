local wezterm = require 'wezterm'
local act = wezterm.action

package.path = package.path .. ';' .. os.getenv('HOME') .. '/.config/colors/?.lua'
local ok, nix_colors = pcall(require, 'colors')
local colors = {}
if ok then
    colors.foreground = nix_colors.text
    colors.background = nix_colors.base
    colors.cursor_bg = nix_colors.text
    colors.cursor_fg = nix_colors.base
end

return {
    enable_tab_bar = false,
    enable_kitty_keyboard = true,
    disable_default_key_bindings = true,
    disable_default_mouse_bindings = true,
    window_background_opacity = 0.95,
    warn_about_missing_glyphs = false,

    color_scheme = 'Catppuccin Mocha',
    colors = colors,

    font = wezterm.font_with_fallback {
        { family = 'JetBrainsMono Nerd Font' },
        'Noto Sans Sinhala', -- amoungus font "ඞ"
    },

    font_rules = {
        {
            intensity = 'Bold',
            font = wezterm.font {
                family = 'JetBrainsMono Nerd Font',
                weight = 'ExtraBold',
            },
        },
    },

    keys = {
        -- { key = "F",     mods = "CTRL|SHIFT", action = wezterm.action { SendString = "\x1b[70;5u" } },
        -- { key = "Enter", mods = "CTRL",       action = wezterm.action { SendString = "\x1b[5;5u" } },
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
