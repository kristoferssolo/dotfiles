function lfcd
    set tmp (mktemp -uq)
    lf -last-dir-path="$tmp" $argv
    if test -f "$tmp"
        set dir (cat "$tmp")
        test -d "$dir" && test "$dir" != (pwd) && z "$dir"
    end
    rm -f $tmp 2>/dev/null
end
