typeset -U PATH path

# Disable files
export LESSHISTFILE=-

export $(dbus-launch)

# Default Apps
export EDITOR="nvim"
export VISUAL="nvim"
export READER="zathura"
export TERMINAL="alacritty"
export BROWSER="firefox"
export VIDEO="mpv"
export IMAGE="nsxiv"
export WM="awesome"


# ~/ Clean-up
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_STATE_HOME="$HOME/.local/share"

export ANDROID_SDK_HOME="${XDG_CONFIG_HOME:-$HOME/.config}/android"
export ANSIBLE_CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/ansible/ansible.cfg"
export CARGO_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/cargo"
export CUDA_CACHE_PATH="{$XDG_CACHE_HOME}/nv"
export ELECTRUMDIR="${XDG_DATA_HOME:-$HOME/.local/share}/electrum"
export GNUPGHOME="${XDG_DATA_HOME:-$HOME/.local/share}/gnupg"
export GOPATH="${XDG_DATA_HOME:-$HOME/.local/share}/go"
export GTK2_RC_FILES="${XDG_CONFIG_HOME:-$HOME/.config}/gtk-2.0/gtkrc"
export HISTFILE="${XDG_CONFIG_HOME:-$HOME/.config}/zsh/history"
export HISTFILE="${XDG_DATA_HOME:-$HOME/.local/share}/history"
export INPUTRC="${XDG_CONFIG_HOME:-$HOME/.config}/shell/inputrc"
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="{$XDG_CONFIG_HOME:-$HOME/.config}/java"
export KODI_DATA="${XDG_DATA_HOME:-$HOME/.local/share}/kodi"
export LESSHISTFILE="-"
export MBSYNCRC="${XDG_CONFIG_HOME:-$HOME/.config}/mbsync/config"
export NOTMUCH_CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/notmuch-config"
export PASSWORD_STORE_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/password-store"
export RUSTUP_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/rustup"
export TMUX_TMPDIR="$XDG_RUNTIME_DIR"
export UNISON="${XDG_DATA_HOME:-$HOME/.local/share}/unison"
export WEECHAT_HOME="${XDG_CONFIG_HOME:-$HOME/.config}/weechat"
export WGETRC="${XDG_CONFIG_HOME:-$HOME/.config}/wget/wgetrc"
export WINEPREFIX="${XDG_DATA_HOME:-$HOME/.local/share}/wineprefixes/default"
export XINITRC="${XDG_CONFIG_HOME:-$HOME/.config}/x11/xinitrc"
export ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"

# Other program settings
export MOZ_USE_XINPUT2="1"		# Mozilla smooth scrolling/touchpads.
export QT_QPA_PLATFORMTHEME="gtk2"	# Have QT use gtk2 theme.

# Adds `~/.local/bin` to $PATH
export PATH="$PATH:${$(find ~/.local/bin -type d -printf %p:)%%:}"

