#!/usr/bin/env fish

# Initialize starship and zoxide
if status is-interactive
    starship init fish | source
    zoxide init fish | source
    atuin init fish | source
end
