function __insert_unquoted_path --description "Insert a path token without quotes; preserve ~ when possible"
    set -l p $argv[1]

    # Rewrite /home/user/... -> ~/...
    if string match -q -- "$HOME/*" $p
        set p "~/"(string sub -s (math (string length -- "$HOME/") + 1) -- $p)
    end

    # Escape as a single token using backslashes (not quotes), so ~ keeps working.
    # This produces things like: ~/My\ Dir/file.txt
    set -l escaped (string escape --style=script -- $p)

    # If fish decided to use quotes anyway, fall back to the raw (unescaped) string.
    # (This avoids `'~/...'` which breaks tilde expansion.)
    if string match -qr -- '^".*"$|^\'.*\'$' $escaped
        set escaped $p
    end

    commandline -t -- $escaped
end
