# Linux desktop tools and GNU command options.
alias nsxiv="nsxiv -a"
alias img="oculante"
alias rm="rm -vI"
alias keychain="keychain --dir $XDG_RUNTIME_DIR/keychain"
alias diff="diff --color=auto"
alias grep="grep --color=auto"
alias ip="ip -color=auto"
alias battery="acpi"
alias day="redshift -PO 6500"
alias night="redshift -PO 4500"
alias dv="doasedit"
alias lf="lfub"
alias lock="swaylock"
alias sv="rsv"
alias wg-down="wg-quick down wg0"
alias wg-up="wg-quick up wg0"

# doas for system commands
for command in mount umount rsv pacman updatedb su shutdown poweroff reboot zzz systemctl wg wg-quick
    alias $command="doas $command"
end
