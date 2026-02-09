function yazicd --description "yazi wrapper that cd's to last directory"
    set -l tmp (mktemp -t "yazi-cwd.XXXXXX")
    command yazi $argv --cwd-file="$tmp"
    if read -z cwd < "$tmp"; and [ "$cwd" != "$PWD" ]; and test -d "$cwd"
        z -- "$cwd"
        eza -a --icons --group-directories-first
    end
    rm -f -- "$tmp" >/dev/null

    # restore insert cursor (beam)
    printf '\e[5 q'
    commandline -f repaint 2>/dev/null
end
