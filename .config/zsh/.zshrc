# Flex on ubuntu users
fastfetch
# pfetch

# Options
# setopt correct												  # Auto correct mistakes setopt extendedglob       # Extended globaling. Allows using regular expressions with *
setopt nocaseglob         # Case insensative globbing
setopt numericglobsort    # Sort filenames numeracally when it makse sense
setopt nobeep             # No beep
setopt appendhistory      # Immediately append history instead of overwriting
setopt histignorealldups  # If a new command is a duplicate, remove older one
setopt autocd             # If only directory path is entered, cd there
setopt inc_append_history # Save commands are addded to the history immediately
setopt histignorespace    # Don't save commands that start with space

autoload -U select-word-style

# Themeing
autoload -U colors && colors

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'	# Case sensetive TAB completions
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"		# Colored completion (different colors fr dirs/files/etc)
zstyle ':completion:*' rehash true												# Automaticly find new executables in path
# Speed up completions
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.config/zsh/cache
zstyle ':completion:*' menu select
autoload -U compinit
zmodload zsh/complist
compinit
_comp_options+=(globdots) # Include hidden files

HISTFILE=~/.config/zsh/.zshistory
HISTSIZE=10000
SAVEHIST=10000
WORDCHARS=${WORDCHARS//\/[&.;]/} # Don't consider certain part of the word

# theme/plugins
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh 2>/dev/null
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh 2>/dev/null
zmodload zsh/terminfo
eval "$(lua ~/.config/zlua/z.lua --init zsh)"

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

bindkey -s '^v' '^unvim .\n'

# Aliases
alias airpods='bluetoothctl connect C8:B1:CD:E0:14:4F'
alias battery='acpi'
alias code='vscodium'
alias cp='cp -iv' # Confirm before overwriting something
alias df='df -h'     # Human-readable sizes
alias diff='diff --color=auto'
alias dv='doasedit'
alias free='free -m' # Show sizes in MB
alias gitu='git add . && git commit && git push'
alias grep='grep --color=auto'
alias grep='rg'
alias ip='ip -color=auto'
alias lf='lfrun'
alias ls='exa -a --icons --group-directories-first'
alias matrix='unimatrix -s 95'
alias mkdir='mkdir -pv'
alias mv='mv -iv'
alias nsxiv='nsxiv -a'
alias pman='doas pacman'
alias py='python'
alias rm='rm -vI'
alias v='nvim'
alias weather='curl wttr.in/'
alias wget='wget --hsts-file="{$XDG_DATA_HOME:-$HOME/.local/share}/wget-hsts"'
alias ww='nvim ~/vimwiki/index.wiki'
alias zzz='doas zzz'
alias day='redshift -PO 5700'
alias night='redshift -PO 3600'

source /usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh 2>/dev/null

autoload -U promptinit
promptinit
prompt spaceship

# PROMPT
SPACESHIP_PROMPT_ADD_NEWLINE=false
SPACESHIP_PROMPT_SEPARATE_LINE=false
SPACESHIP_CHAR_SYMBOL="❯"
SPACESHIP_CHAR_SUFFIX=" "
# TIME
SPACESHIP_TIME_SHOW=false
SPACESHIP_EXEC_TIME_SHOW=false
# USER
SPACESHIP_USER_SHOW=false
# HOST
SPACESHIP_HOST_SHOW=false
SPACESHIP_HOST_PREFIX="at "
SPACESHIP_HOST_SUFFIX="$SPACESHIP_PROMPT_DEFAULT_SUFFIX"
SPACESHIP_HOST_COLOR="green"
# DIR
SPACESHIP_DIR_SHOW=true
SPACESHIP_DIR_PREFIX="in "
SPACESHIP_DIR_SUFFIX="$SPACESHIP_PROMPT_DEFAULT_SUFFIX"
SPACESHIP_DIR_TRUNC=3
SPACESHIP_DIR_COLOR="cyan"
# GIT
SPACESHIP_GIT_SHOW=true
SPACESHIP_GIT_PREFIX="on "
SPACESHIP_GIT_SUFFIX="$SPACESHIP_PROMPT_DEFAULT_SUFFIX"
SPACESHIP_GIT_SYMBOL=" "
# GIT BRANCH
SPACESHIP_GIT_BRANCH_SHOW=true
SPACESHIP_GIT_BRANCH_PREFIX="$SPACESHIP_GIT_SYMBOL"
SPACESHIP_GIT_BRANCH_SUFFIX=""
SPACESHIP_GIT_BRANCH_COLOR="magenta"
# GIT STATUS
SPACESHIP_GIT_STATUS_SHOW=true
SPACESHIP_GIT_STATUS_PREFIX=" ["
SPACESHIP_GIT_STATUS_SUFFIX="]"
SPACESHIP_GIT_STATUS_COLOR="red"
SPACESHIP_GIT_STATUS_UNTRACKED="?"
SPACESHIP_GIT_STATUS_ADDED="+"
SPACESHIP_GIT_STATUS_MODIFIED="!"
SPACESHIP_GIT_STATUS_RENAMED="»"
SPACESHIP_GIT_STATUS_DELETED="✘"
SPACESHIP_GIT_STATUS_STASHED="$"
SPACESHIP_GIT_STATUS_UNMERGED="="
SPACESHIP_GIT_STATUS_AHEAD="⇡"
SPACESHIP_GIT_STATUS_BEHIND="⇣"
SPACESHIP_GIT_STATUS_DIVERGED="⇕"

SPACESHIP_NODE_SHOW=false
SPACESHIP_ELM_SHOW=false
SPACESHIP_ELIXIR_SHOW=false
SPACESHIP_RUBY_SHOW=false
SPACESHIP_XCODE_SHOW_LOCAL=false
SPACESHIP_SWIFT_SHOW_LOCAL=false
SPACESHIP_GOLANG_SHOW=false
SPACESHIP_PHP_SHOW=false
SPACESHIP_RUST_SHOW=true
SPACESHIP_HASKELL_SHOW=false
SPACESHIP_JULIA_SHOW=false
SPACESHIP_DOTNET_SHOW=false
SPACESHIP_EMBER_SHOW=false
SPACESHIP_KUBECTL_VERSION_SHOW=false
SPACESHIP_KUBECONTEXT_SHOW=false
SPACESHIP_GRADLE_SHOW=false
SPACESHIP_MAVEN_SHOW=false
SPACESHIP_TERRAFORM_SHOW=false
SPACESHIP_JOBS_SHOW=false
SPACESHIP_AWS_SHOW=false
SPACESHIP_GCLOUD_SHOW=false
SPACESHIP_DOCKER_SHOW=true
SPACESHIP_VENV_SHOW=true
SPACESHIP_CONDA_SHOW=false
SPACESHIP_PYENV_SHOW=true
SPACESHIP_VI_MODE_SHOW=false
