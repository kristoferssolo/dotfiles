function fzf_complete --description "fzf-tab style completion for fish"
    set -l cmd (commandline -opc)
    set -l token (commandline -t)

    # Get all fish completions for the current command line
    set -l completions (complete -C(commandline -cp))

    # If no completions, fallback to default behavior
    if test (count $completions) -eq 0
        commandline -f complete
        return
    end

    # If only one completion, insert it directly
    if test (count $completions) -eq 1
        set -l comp (string split \t -- $completions[1])[1]
        __insert_unquoted_path $comp
        commandline -f repaint
        return
    end

    # Multiple completions - show in fzf
    set -l selected (
        printf '%s\n' $completions |
        fzf --ansi \
            --height=50% \
            --reverse \
            --border \
            --cycle \
            --info=inline \
            --tabstop=4 \
            --prompt='❯ ' \
            --pointer='▶' \
            --marker='✓' \
            --bind 'tab:down,btab:up' \
            --preview-window='right:50%:wrap' \
            --preview='
                set item (string split \t {})[1]
                set real (eval echo $item 2>/dev/null || echo $item)
                if test -d "$real"
                    eza --color=always -la "$real" 2>/dev/null
                else if test -f "$real"
                    bat --color=always --style=numbers --line-range=:500 "$real" 2>/dev/null || cat "$real"
                else if test -e "$real"
                    ls -lah "$real"
                else
                    echo "$item"
                end
            '
    )

    if test -n "$selected"
        # Extract the actual completion (first field before tab)
        set -l comp (string split \t -- $selected)[1]
        __insert_unquoted_path $comp
    end

    commandline -f repaint
end
