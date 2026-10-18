#!/usr/bin/env fish

# Initialize installed interactive tools.
if status is-interactive
    if command -q starship
        starship init fish | source
    end
    if command -q zoxide
        zoxide init fish | source
    end
    if command -q atuin
        atuin init fish | source
    end
    if command -q mekle
        mekle init fish | source
    end
end

# Machine-specific settings stay outside the repository.
if test -f "$__fish_config_dir/config.local.fish"
    source "$__fish_config_dir/config.local.fish"
end
