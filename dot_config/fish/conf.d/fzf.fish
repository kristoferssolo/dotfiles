# fzf.fish configuration - replicate zsh fzf-tab behavior

# Enable all fzf.fish features
set -g fzf_fish_custom_keybindings 1

# Directory preview (like your zsh config)
set -g fzf_preview_dir_cmd eza --all --color=always

# File preview
set -g fzf_preview_file_cmd bat --style=numbers --color=always

# fzf default options (matches your zsh FZF_DEFAULT_OPTS)
set -gx FZF_DEFAULT_OPTS "--layout=reverse --height=40% --border"

# Use fzf for completions (Tab key behavior)
set -g fzf_complete_opts --preview-window=right:50%
