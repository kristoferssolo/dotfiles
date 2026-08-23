function fish_user_key_bindings
    # Accept autosuggestion and enter insert mode with Shift+A
    bind -M default A vi_append_accept

    # Tab completion with fzf (zsh fzf-tab style)
    bind -M insert \t fzf_complete
    bind -M default \t fzf_complete

    # bind -M insert \co 'yazicd; commandline -f repaint'
    # Ctrl+O for yazicd
    # bind -M default \co 'yazicd; commandline -f repaint'
    bind -M insert \co 'yazicd; printf "\e[5 q"; commandline -f repaint'
    bind -M default \co 'yazicd; printf "\e[5 q"; commandline -f repaint'

    # Ctrl+N to open nvim in current directory
    bind -M insert \cn open_nvim_here
    bind -M default \cn open_nvim_here

    # Ctrl+F for sesh
    bind -M insert \cF fzf_sesh_connect
    bind -M default \cF fzf_sesh_connect

    # Ctrl+E to edit command line in editor
    bind -M insert \ce edit_command_buffer
    bind -M default \ce edit_command_buffer
end
