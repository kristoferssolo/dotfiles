#!/usr/bin/env fish

# Use neovim for vim if present
if command -v nvim >/dev/null
    set -gx vimdiff "nvim -d"
end

# Verbosity and settings
alias bc="bc -ql"
alias cp="cp -vi"
alias df="df -h"
alias mkdir="mkdir -pv"
alias mv="mv -iv"
alias wget="wget --hsts-file=$XDG_DATA_HOME/wget-hsts"

# Colorize commands
if command -q moor
    alias less="moor"
end
if command -q eza
    alias ls="eza -a --icons --group-directories-first"
end

# Common command abbreviations
alias code="vscodium"
if set -q EDITOR; and test -n "$EDITOR"
    alias e="$EDITOR"
    alias v="$EDITOR"
end
alias fetch="fastfetch"
alias j="joshutoub"
alias lg="lazygit"
alias lzd="lazydocker"
alias py="python"
alias weather="curl wttr.in/"
alias ww="$EDITOR ~/neorg/"
alias va="source .venv/bin/activate.fish"
alias yy="yazi"

# Git aliases
alias gP="git push"
alias ga="git add"
alias gap="git add --patch"
alias gc="git commit"
alias gd="git diff --output-indicator-new=' ' --output-indicator-old=' '"
alias gds="git diff --staged"
alias gl="git log --all --graph --pretty=format:'%C(magenta)%h %C(white) %an  %ar%C(auto)  %D%n%s%n'"
alias gp="git pull"
alias gC="git clone"
alias gs="git status --short"
