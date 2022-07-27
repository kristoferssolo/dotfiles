typeset -U PATH path

# Disable files
export LESSHISTFILE=-


# Default Apps
export EDITOR="nvim"
export VISUAL="nvim"
export READER="zathura"
export TERMINAL="alacritty"
export BROWSER="vivaldi"
export VIDEO="mpv"
export IMAGE="nsxiv"
export WM="awesome"


# ~/ Clean-up
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_STATE_HOME="$HOME/.local/share"

export XINITRC="${XDG_CONFIG_HOME:-$HOME/.config}/x11/xinitrc"
export ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"
export HISTFILE="${XDG_CONFIG_HOME:-$HOME/.config}/zsh/history"
export CARGO_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/cargo"
export GNUPGHOME="${XDG_DATA_HOME:-$HOME/.local/share}/gnupg"
export CUDA_CACHE_PATH="{$XDG_CACHE_HOME}/nv"
export GOPATH="{$XDG_DATA_HOME:-$HOME/.local/share}/go"
export GTK2_RC_FILES="${XDG_CONFIG_HOME:-$HOME/.config}/gtk-2.0/gtkrc"
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="{$XDG_CONFIG_HOME:-$HOME/.config}/java"
export RUSTUP_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/rustup"


# Other program settings
export MOZ_USE_XINPUT2="1"		# Mozilla smooth scrolling/touchpads.

# Adds `~/.local/bin` to $PATH
export PATH="$PATH:${$(find ~/.local/bin -type d -printf %p:)%%:}"

