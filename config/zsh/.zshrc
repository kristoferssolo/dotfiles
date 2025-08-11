#!/bin/zsh
# Import and execute startup file
[ -f "$XDG_CONFIG_HOME/zsh/startup" ] && source "$XDG_CONFIG_HOME/zsh/startup"
fpath=("$XDG_CONFIG_HOME/zsh/completions/" $fpath)
autoload -U compinit && compinit

# Add completions to search path
if [[ ":$FPATH:" != *":$XDG_CONFIG_HOME/zsh/completions:"* ]]; then
    export FPATH="$XDG_CONFIG_HOME/zsh/completions:$FPATH"
fi

# Options
setopt appendhistory        # Immediately append history instead of overwriting
setopt sharehistory         # Share history across terminals
setopt autocd               # If only directory path is entered, cd there
setopt correct              # Auto correct mistakes setopt extendedglob       # Extended globaling. Allows using regular expressions with *
setopt hist_ignore_all_dups # If a new command is a duplicate, remove older one
setopt hist_ignore_space    # Don't save commands that start with space
setopt hist_find_no_dups    #
setopt inc_append_history   # Save commands are added to the history immediately
setopt nobeep               # No beep
setopt nocaseglob           # Case insensitive globbing
setopt numericglobsort      # Sort filenames numeracally when it makes sense

autoload -U select-word-style

# Themeing
autoload -U colors && colors

zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"     # Colored completion (different colors fr dirs/files/etc)
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'   # Case sensitive TAB completions
zstyle ':completion:*' rehash true                          # Automatically find new executables in path
zstyle ':completion:*' menu no
# Speed up completions
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' cache-path ~/.cache/zsh/cache
zstyle ':completion:*' menu select
zstyle ':completion:*' use-cache on
autoload -U compinit
autoload -Uz _rye
zmodload zsh/complist
compinit
_comp_options+=(globdots) # Include hidden files

HISTSIZE=1000000
SAVEHIST=$HISTSIZE
HISTDUP=erase
HISTFILE="$XDG_CACHE_HOME/zsh/history"
WORDCHARS=${WORDCHARS//\/[&.;]/} # Don't consider certain part of the word

[ -f "$XDG_CONFIG_HOME/shell/aliasrc" ] && source "$XDG_CONFIG_HOME/shell/aliasrc"

zmodload zsh/terminfo

# Keybindings
bindkey -e
# vi mode
bindkey -v
export KEYTIMEOUT=1

# Change cursor shape for different vi modes.
zle-keymap-select() {
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

# Run eza on directory change
function cd {
    new_directory="$*"
    if [ $# -eq 0 ]; then
        new_directory=${HOME}
    fi
    z "${new_directory}" && eza -a --icons --group-directories-first
}

# Use lf to switch directories and bind it to ctrl-o
lfcd() {
    tmp="$(mktemp -uq)"
    trap 'rm -f $tmp >/dev/null 2>&1 && trap - HUP INT QUIT TERM PWR EXIT' HUP INT QUIT TERM PWR EXIT
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && z "$dir" || return
    fi
}

function yazicd() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
    yazi "$@" --cwd-file="$tmp"
    if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		z -- "$cwd" && eza -a --icons --group-directories-first
	fi
	rm -f -- "$tmp" >/dev/null 2>&1
}

function tmux-window-name() {
	($TMUX_PLUGIN_MANAGER_PATH/tmux-window-name/scripts/rename_session_windows.py &)
}

function fzf_sesh_connect_widget() {
  local session
  session=$(
    sesh list --icons | fzf-tmux -p 80%,70% \
      --no-sort --ansi \
      --border-label ' sesh ' \
      --prompt '⚡  ' \
      --header '  ^a all  ^t tmux  ^g configs  ^x zoxide  ^d tmux kill  ^f find' \
      --bind 'tab:down,btab:up' \
      --bind 'ctrl-a:change-prompt(⚡  )+reload(sesh list --icons)' \
      --bind 'ctrl-t:change-prompt(🪟  )+reload(sesh list -t --icons)' \
      --bind 'ctrl-g:change-prompt(⚙️  )+reload(sesh list -c --icons)' \
      --bind 'ctrl-x:change-prompt(📁  )+reload(sesh list -z --icons)' \
      --bind 'ctrl-f:change-prompt(🔎  )+reload(fd -H -d 2 -t d -E .Trash . ~)' \
      --bind 'ctrl-d:execute(tmux kill-session -t {2..})+change-prompt(⚡  )+reload(sesh list --icons)' \
      --preview-window 'right:55%' \
      --preview 'sesh preview {}'
  )

  # if the user picked something, build & run the command
  if [[ -n $session ]]; then
    BUFFER="sesh connect \"$session\""
    zle accept-line
  fi
}
zle -N fzf_sesh_connect_widget

# Navigate words with CTRL+ARROW keys
bindkey '^H' backward-kill-word # delete previous word with CTRL+BACKSPACE
bindkey '^[Oc' forward-word
bindkey '^[Od' backward-word
bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word
bindkey '^[[3~' delete-char
bindkey '^[[Z' undo             # SHIFT+TAB undo last action

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# Use vim keys in tab complete menu
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -v '^?' backward-delete-char

bindkey -s '^o' '^uyazicd\n'
# bindkey -s '^a' 'ubc -lq\n'
bindkey '^[[P' delete-char

# Edit line in vim with ctrl-e
autoload edit-command-line
zle -N edit-command-line
bindkey '^e' edit-command-line
bindkey -M vicmd '^[[P' vi-delete-char
bindkey -M vicmd '^e' edit-command-line
bindkey -M visual '^[[P' vi-delete

bindkey -s '^n' '^uv .\n'
# bindkey -s '^f' '^utmux neww tmux-sessionizer\n'
bindkey '^F' fzf_sesh_connect_widget

eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

[[ -r ~/.local/share/zsh/plugins/znap/znap.zsh ]] ||
    git clone --depth 1 -- \
        https://github.com/marlonrichert/zsh-snap.git ~/.local/share/zsh/plugins/znap
source ~/.local/share/zsh/plugins/znap/znap.zsh

znap source zsh-users/zsh-autosuggestions
znap source zsh-users/zsh-history-substring-search
znap source zsh-users/zsh-completions
znap source MichaelAquilina/zsh-autoswitch-virtualenv
znap source zdharma-continuum/fast-syntax-highlighting
znap source Aloxaf/fzf-tab

autoload -U compinit && compinit
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'

[ -f "$XDG_CONFIG_HOME/zsh/zoxide" ] && source "$XDG_CONFIG_HOME/zsh/zoxide"

export PATH="$BUN_INSTALL/bin:$PATH"

# bun completions
[ -s "/home/kristofers/.bun/_bun" ] && source "/home/kristofers/.bun/_bun"
