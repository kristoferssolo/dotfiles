# Keep work credentials and tool installations in their native locations.
set -gx XDG_CONFIG_HOME "$HOME/.config"
set -gx XDG_CACHE_HOME "$HOME/.cache"
set -gx XDG_DATA_HOME "$HOME/.local/share"
set -gx XDG_STATE_HOME "$HOME/.local/state"
set -gx STARSHIP_CONFIG "$XDG_CONFIG_HOME/starship/starship.toml"
set -gx TERMINAL rio
# Use the managed config even when newer Atuin versions prefer ~/.atuin.
set -gx ATUIN_CONFIG_DIR "$XDG_CONFIG_HOME/atuin"

# Homebrew on Apple Silicon or Intel. Set PATH before other conf.d files run.
if test -x /opt/homebrew/bin/brew
    /opt/homebrew/bin/brew shellenv fish | source
else if test -x /usr/local/bin/brew
    /usr/local/bin/brew shellenv fish | source
end
fish_add_path "$HOME/.local/bin"

if command -q nvim
    set -gx EDITOR nvim
    set -gx VISUAL nvim
    alias v=nvim
    alias e=nvim
end
if command -q eza
    alias ls="eza -a --icons --group-directories-first"
end
if command -q lazygit
    alias lg=lazygit
end
