#!/usr/bin/env fish

starship init fish | source
zoxide init fish | source

set -g fish_history_size 1000000

set -gx fish_complete_path "$XDG_CONFIG_HOME/fish/completions" $fish_complete_path

# fzf configuration
set -gx FZF_DEFAULT_OPTS "--height 40% --layout=reverse --border"
set -gx FZF_DEFAULT_COMMAND "fd --type f"

# Functions
function cd
    if test (count $argv) -eq 0
        builtin cd ~
    else
        builtin cd $argv
    end
    eza -a --icons --group-directories-first
end

function lfcd
    set tmp (mktemp -uq)
    lf -last-dir-path="$tmp" $argv
    if test -f "$tmp"
        set dir (cat "$tmp")
        if test -d "$dir" -a "$dir" != (pwd)
            cd "$dir"
        end
    end
end

function yazicd
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    yazi $argv --cwd-file="$tmp"
    set cwd (cat "$tmp")
    if test -n "$cwd" -a "$cwd" != "$PWD"
        cd "$cwd"
        eza -a --icons --group-directories-first
    end
    rm -f "$tmp"
end

# Keybindings
fish_vi_key_bindings


# Source other files
# if test -f "$HOME/.local/share/../bin/env"
#     source "$HOME/.local/share/../bin/env"
# # PATH configuration
# fish_add_path $BUN_INSTALL/bin
# fish_add_path $HOME/.local/bin
#
# # Environment setup
# if test -f "$HOME/.local/share/bin/env"
#     source "$HOME/.local/share/bin/env"
# end
#
# # Bun completions
# if test -f "/home/kristofers/.bun/_bun"
#     source "/home/kristofers/.bun/_bun"
# end
