function open_nvim_here --description "Open nvim in cwd"
    # Run nvim ($EDITOR) on the current dir
    command $EDITOR .

    # After returning, force fish to resync its vi mode + cursor
    commandline -f vi-default 2>/dev/null
    commandline -f vi-insert 2>/dev/null
    printf '\e[5 q'
    commandline -f repaint 2>/dev/null
end
