if status is-interactive
    fish_vi_key_bindings

    set -g fish_cursor_default block
    set -g fish_cursor_insert line
    set -g fish_cursor_replace_one underscore
    set -g fish_cursor_visual block

    function __force_beam_cursor --on-event fish_prompt
        commandline -f vi-default 2>/dev/null
        commandline -f vi-insert 2>/dev/null
        printf '\e[5 q'
        command sleep 0.02 2>/dev/null
        printf '\e[5 q'
    end
end
