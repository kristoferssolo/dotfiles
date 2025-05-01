# Source startup file
# if test -f "$XDG_CONFIG_HOME/zsh/startup"
#     source "$XDG_CONFIG_HOME/zsh/startup"
# end


# Starship prompt
starship init fish | source

# Aliases
if test -f "$XDG_CONFIG_HOME/fish/alias.fish"
    source "$XDG_CONFIG_HOME/fish/alias.fish"
end

# Environment variables
set -x KEYTIMEOUT 1

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
# end
