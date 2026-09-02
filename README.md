# Solorice Dotfiles

Personal Linux dotfiles managed with [chezmoi](https://www.chezmoi.io/).

Chezmoi uses chezmoi's naming convention:
`dot_config` maps to `~/.config` and `dot_local` maps to `~/.local`.
Neovim is managed separately in [SoloVim](https://codeberg.org/kristoferssolo/SoloVim):

```sh
git clone https://github.com/kristoferssolo/SoloVim ~/.config/nvim
```

## Profiles

The default profile is `desktop`. Its values live in `.chezmoidata.toml`.
Set a machine-specific profile and overrides in chezmoi's untracked config:

```sh
mkdir -p ~/.config/chezmoi
cp chezmoi.toml.example ~/.config/chezmoi/chezmoi.toml
```

Available profiles are:

| Profile | Use |
| --- | --- |
| `desktop` | Niri and Hyprland desktop setup |
| `laptop` | Niri and Hyprland laptop setup |
| `x11` | Awesome desktop setup |
| `x11-laptop` | Awesome laptop setup |

Profile data controls conditional source inclusion through `.chezmoiignore`.
Values in `~/.config/chezmoi/chezmoi.toml` override the shared defaults.

## Install

Clone the repository and initialize chezmoi using its source directory:

```sh
git clone https://github.com/kristoferssolo/dotfiles.git ~/.dotfiles
chezmoi init --source ~/.dotfiles/home
chezmoi apply --dry-run
chezmoi apply
```

Install the applications you want through your distribution's package manager
before applying. Yazi packages and Fish plugins are not stored in this repository. Restore them
from their manifests after the first apply:

```sh
just plugins
```

## Layout

- `.chezmoidata.toml` – shared template defaults
- `.chezmoiignore` – profile-specific source exclusions
- `chezmoi.toml.example` – local machine override example
- `dot_config/` – XDG application configuration
- `dot_local/` – commands, assets, and user-local data
