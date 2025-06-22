#!/usr/bin/env sh

if [ ! -d "$HOME/.config/nix-config" ]; then
    git clone git@github.com:grig-iv/nix-config.git ~/.config/nix-config
fi

if [ ! -d "$HOME/.config/nvim" ]; then
    git clone git@github.com:grig-iv/nvim.git ~/.config/nvim
fi

if [ ! -d "$HOME/.local/src/plato" ]; then
    git clone git@github.com:grig-iv/plato.git ~/.local/src/plato
    cd ~/.local/src/plato
    just install
fi

if [ ! -d "$HOME/.local/src/win-layout" ]; then
    git clone git@github.com:grig-iv/win-layout.git ~/.local/src/win-layout
    cd ~/.local/src/win-layout
    just install
fi

if [ ! -d "$HOME/maps" ]; then
    git clone git@github.com:grig-iv/maps.git ~/maps
fi
