#!/bin/bash

if ! command -v winget &> /dev/null; then
    echo "winget not found. Please install winget first."
    exit 1
fi

command_exists() {
    command -v "$1" >/dev/null 2>&1
}

if ! command_exists uv; then
    echo "uv not found. Installing uv using winget..."
    winget install --id=astral-sh.uv -e --silent
fi

if ! command_exists rg; then
    echo "ripgrep (rg) not found. Installing ripgrep using winget..."
    winget install --id=BurntSushi.Ripgrep -e --silent
fi

VIM_PLUG_PATH="$HOME/.vim/autoload/plug.vim"
if [ ! -f "$VIM_PLUG_PATH" ]; then
    echo "Downloading vim-plug..."
    curl -fLo "$VIM_PLUG_PATH" --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
else
    echo "vim-plug already installed."
fi

echo "Installing black, pylsp, and mypy with uv..."
uv tool install black pylsp mypy
