# Import and execute startup file
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/startup" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/startup"

# Options
setopt correct              # Auto correct mistakes setopt extendedglob       # Extended globaling. Allows using regular expressions with *
setopt nocaseglob           # Case insensative globbing
setopt numericglobsort      # Sort filenames numeracally when it makse sense
setopt nobeep               # No beep
setopt appendhistory        # Immediately append history instead of overwriting
setopt histignorealldups    # If a new command is a duplicate, remove older one
setopt autocd               # If only directory path is entered, cd there
setopt inc_append_history   # Save commands are addded to the history immediately
setopt histignorespace      # Don't save commands that start with space

autoload -U select-word-style

# Themeing
autoload -U colors && colors

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'   # Case sensetive TAB completions
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"     # Colored completion (different colors fr dirs/files/etc)
zstyle ':completion:*' rehash true                          # Automaticly find new executables in path
# Speed up completions
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.config/zsh/cache
zstyle ':completion:*' menu select
autoload -U compinit
zmodload zsh/complist
compinit
_comp_options+=(globdots) # Include hidden files

HISTSIZE=1000000
SAVEHIST=1000000
HISTFILE="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/history"
WORDCHARS=${WORDCHARS//\/[&.;]/} # Don't consider certain part of the word

[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliasrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliasrc"

# theme/plugins
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh 2>/dev/null
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh 2>/dev/null
zmodload zsh/terminfo

# Keybindings
bindkey -e
# vi mode
bindkey -v
export KEYTIMEOUT=1

# Change cursor shape for different vi modes.
function zle-keymap-select {
    case $KEYMAP in
        vicmd) echo -ne '\e[1 q' ;;        # block
        viins | main) echo -ne '\e[5 q' ;; # beam
    esac
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne '\e[5 q'
}
zle -N zle-line-init
echo -ne '\e[5 q'                # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q'; } # Use beam shape cursor for each new prompt.

# Run exa on directory change
function cd() {
    new_directory="$*"
    if [ $# -eq 0 ]; then
        new_directory=${HOME}
    fi
    builtin cd "${new_directory}" && exa -a --icons --group-directories-first
}

# Use lf to switch directories and bind it to ctrl-o
function lfcd() {
    tmp="$(mktemp)"
    lfrun -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(bat "$tmp")"
        rm -f "$tmp" >/dev/null
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}

# Navigate words with CTRL+ARROW keys
bindkey '^[Oc' forward-word
bindkey '^[Od' backward-word
bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word
bindkey '^H' backward-kill-word # delete previous word with CTRL+BACKSPACE
bindkey '^[[Z' undo             # SHIFT+TAB undo last action
bindkey '^[[3~' delete-char

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# Use vim keys in tab complete menu
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

bindkey -s '^o' '^ulfcd\n'
# bindkey -s '^a' 'ubc -lq\n'
bindkey '^[[P' delete-char

# Edit line in vim with ctrl-e
autoload edit-command-line
zle -N edit-command-line
bindkey '^e' edit-command-line
bindkey -M vicmd '^[[P' vi-delete-char
bindkey -M vicmd '^e' edit-command-line
bindkey -M visual '^[[P' vi-delete

bindkey -s '^n' '^uv\n'

source /usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh 2>/dev/null

eval "$(starship init zsh)"
