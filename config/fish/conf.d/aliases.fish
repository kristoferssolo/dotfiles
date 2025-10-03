# Use neovim for vim if present
if type -q nvim
    set -g vimdiff "nvim -d"
end

# Verbosity and settings that you pretty much just always are going to wand
alias bc="bc -ql"
alias cp="cp -vi"
alias df="df -h"
alias mkdir="mkdir -pv"
alias mv="mv -iv"
alias nsxiv="nsxiv -a"
alias rm="rm -vI"
alias wget="wget --hsts-file=$XDG_DATA_HOME/wget-hsts"
alias keychain="keychain --dir $XDG_RUNTIME_DIR/keychain"

# Colorize commands when possible
alias diff="diff --color=auto"
alias grep="rg --color=auto"
alias ip="ip -color=auto"
alias less="moor"
alias ls="eza -a --icons --group-directories-first"

# These common commands ate just too long! Abbreviate them
alias battery="acpi"
alias code="vscodium"
alias day="redshift -PO 6500"
alias dv="doasedit"
alias e="$EDITOR"
alias fetch="fastfetch"
alias lf="lfub"
alias lg="lazygit"
alias lock="swaylock"
alias lzd="lazydocker"
alias night="redshift -PO 4500"
alias py="python"
alias sv="rsv"
alias v="$EDITOR"
alias weather="curl wttr.in/"
alias wg-down="wg-quick down wg0"
alias wg-up="wg-quick up wg0"
alias ww="$EDITOR ~/neorg/"
alias yarn="yarn --use-yarnrc $XDG_CONFIG_HOME/yarn/config"
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
alias gs="git status --short"

# doas alias
for command in mount umount rsv sv pacman updatedb su shutdown poweroff reboot zzz systemctl wg wg-quick
    alias $command="doas $command"
end
