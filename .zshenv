typeset -U PATH path

# Other XDG paths
export XDG_DATA_HOME=${XDG_DATA_HOME:="$HOME/.local/share"}
export XDG_CACHE_HOME=${XDG_CACHE_HOME:="$HOME/.cache"}
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:="$HOME/.config"}

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
export XINITRC="${XDG_CONFIG_HOME:-$HOME/.config}/x11/xinitrc"
export ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"
export HISTFILE="${XDG_CONFIG_HOME:-$HOME/.config}/zsh/history"
export CARGO_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/cargo"

# Other program settings
export MOZ_USE_XINPUT2="1"		# Mozilla smooth scrolling/touchpads.

# Adds `~/.local/bin` to $PATH
# export PATH="$PATH:${$(find ~/.local/bin -type d -printf %p:)%%:}"
PATH=$PATH:/home/$USER/.local/bin
