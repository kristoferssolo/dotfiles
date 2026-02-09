#!/usr/bin/env fish

# XDG Base Directory
set -gx XDG_CACHE_HOME "$HOME/.cache"
set -gx XDG_CONFIG_HOME "$HOME/.config"
set -gx XDG_DATA_HOME "$HOME/.local/share"
set -gx XDG_STATE_HOME "$HOME/.local/share"

# Java
set -gx JAVA_HOME "/usr/lib/jvm/java-21-openjdk"

# Bun
set -gx BUN_INSTALL "$XDG_DATA_HOME/bun"

# PATH (fish_add_path dedupes; --move puts them first)
fish_add_path --move "$HOME/.local/bin"
fish_add_path --move "$HOME/.spicetify"
fish_add_path --move "$XDG_DATA_HOME/bun/bin"
fish_add_path --move "$BUN_INSTALL/bin"
fish_add_path --move "$HOME/.lmstudio/bin"
fish_add_path --move "$JAVA_HOME/bin"

# Cargo / Deno (avoid sourcing bash scripts)
set -gx CARGO_HOME "$XDG_DATA_HOME/cargo"
test -d "$CARGO_HOME/bin"; and fish_add_path --move "$CARGO_HOME/bin"

set -gx DENO_INSTALL "$XDG_DATA_HOME/deno"
test -d "$DENO_INSTALL/bin"; and fish_add_path --move "$DENO_INSTALL/bin"

# Disable files
set -gx LESSHISTFILE -

set -gx MANPAGER 'nvim +Man!'
set -gx LIBSEAT_BACKEND logind

# Default Apps
set -gx BROWSER "floorp"
set -gx EDITOR "nvim"
set -gx VISUAL "$EDITOR"
set -gx IMAGE "oculante"
set -gx READER "zathura"
set -gx TERMINAL "alacritty"
set -gx VIDEO "mpv"

set -gx GTK_THEME rose-pine-gtk
set -gx HYPRSHOT_DIR "$HOME/Pictures/screenshots"

# XDG compliance for various programs
set -gx ANDROID_HOME "$XDG_CONFIG_HOME/android"
set -gx ANDROID_SDK_HOME "$XDG_CONFIG_HOME/android"
set -gx ANDROID_USER_HOME "$XDG_DATA_HOME/android"
set -gx ANSIBLE_CONFIG "$XDG_CONFIG_HOME/ansible/ansible.cfg"
set -gx CARGO_HOME "$XDG_DATA_HOME/cargo"
set -gx CUDA_CACHE_PATH "$XDG_CACHE_HOME/nv"
set -gx DOCKER_CONFIG "$XDG_CONFIG_HOME/docker"
set -gx ELECTRUMDIR "$XDG_DATA_HOME/electrum"
set -gx GNUPGHOME "$XDG_DATA_HOME/gnupg"
set -gx GOPATH "$XDG_DATA_HOME/go"
set -gx GRADLE_USER_HOME "$XDG_DATA_HOME/gradle"
set -gx GTK2_RC_FILES "$XDG_CONFIG_HOME/gtk-2.0/gtkrc"
set -gx HISTFILE "$XDG_DATA_HOME/history"
set -gx INPUTRC "$XDG_CONFIG_HOME/shell/inputrc"
set -gx IPYTHONDIR "$XDG_CONFIG_HOME/ipython"
set -gx JUPYTER_CONFIG_DIR "$XDG_CONFIG_HOME/jupyter"
set -gx KERAS_HOME "$XDG_DATA_HOME/keras"
set -gx KODI_DATA "$XDG_DATA_HOME/kodi"
set -gx MBSYNCRC "$XDG_CONFIG_HOME/mbsync/config"
set -gx MYPY_CACHE_DIR "$XDG_CACHE_HOME/mypy"
set -gx MYSQL_HISTFILE "$XDG_DATA_HOME/mysql_history"
set -gx NODE_REPL_HISTORY "$XDG_DATA_HOME/node_repl_history"
set -gx NOTMUCH_CONFIG "$XDG_CONFIG_HOME/notmuch-config"
set -gx NPM_CONFIG_USERCONFIG "$XDG_CACHE_HOME/npm/npmrc"
set -gx PARALLEL_HOME "$XDG_CONFIG_HOME/parallel"
set -gx PASSWORD_STORE_DIR "$XDG_DATA_HOME/password-store"
set -gx PYENV_ROOT "$XDG_DATA_HOME/pyenv"
set -gx PYTHONSTARTUP "$HOME/python/pythonrc"
set -gx REDISCLI_HISTFILE "$XDG_DATA_HOME/redis/rediscli_history"
set -gx RUSTUP_HOME "$XDG_DATA_HOME/rustup"
set -gx RYE_HOME "$XDG_DATA_HOME/rye"
set -gx SSB_HOME "$XDG_DATA_HOME/zoom"
set -gx STARSHIP_CONFIG "$XDG_CONFIG_HOME/starship/starship.toml"
set -gx TEXMFVAR "$XDG_CACHE_HOME/texlive/texmf-var"
set -gx TMUX_TMPDIR "$XDG_RUNTIME_DIR"
set -gx UNISON "$XDG_DATA_HOME/unison"
set -gx W3M_DIR "$XDG_DATA_HOME/w3m"
set -gx WEECHAT_HOME "$XDG_CONFIG_HOME/weechat"
set -gx WGETRC "$XDG_CONFIG_HOME/wget/wgetrc"
set -gx WINEPREFIX "$XDG_DATA_HOME/wineprefixes/default"
set -gx XAUTHORITY "$XDG_RUNTIME_DIR/Xauthority"
set -gx XCURSOR_PATH "/usr/share/icons:$XDG_DATA_HOME/icons"
set -gx XINITRC "$XDG_CONFIG_HOME/x11/xinitrc"
set -gx ZDOTDIR "$XDG_CONFIG_HOME/zsh"
set -gx JAVA_HOME "/usr/lib/jvm/java-21-openjdk"
set -gx WAKATIME_HOME "$XDG_CONFIG_HOME/wakatime"
set -gx PSQL_HISTORY "$XDG_DATA_HOME/psql_history"
set -gx STACK_ROOT "$XDG_DATA_HOME/stack"
set -gx STACK_XDG 1

# Other program settings
set -gx AWT_TOOLKIT "MToolkit wmname LG3D"
set -gx DICS "/usr/share/stardict/dic/"
set -gx FZF_DEFAULT_OPTS "--layout=reverse --height 40%"
set -gx LESS -R
set -gx LESSOPEN "| /usr/bin/highlight -O ansi %s 2>/dev/null"
set -gx LESS_TERMCAP_mb (printf '\e[1;31m')
set -gx LESS_TERMCAP_md (printf '\e[1;36m')
set -gx LESS_TERMCAP_me (printf '\e[0m')
set -gx LESS_TERMCAP_se (printf '\e[0m')
set -gx LESS_TERMCAP_so (printf '\e[01;44;33m')
set -gx LESS_TERMCAP_ue (printf '\e[0m')
set -gx LESS_TERMCAP_us (printf '\e[1;32m')
set -gx MOZ_USE_XINPUT2 "1"
set -gx QT_QPA_PLATFORMTHEME "qt5ct"
set -gx QT_SCREEN_SCALE_FACTORS "1;1"
set -gx SUDO_ASKPASS "$HOME/.local/bin/dmenupass"
set -gx _JAVA_AWT_WM_NONREPARENTING 1

set -gx ZDOTDIR "$XDG_CONFIG_HOME/zsh"
