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

## PyCharm

`.chezmoitemplates/ideavimrc` provides SoloVim-style editing and workflow keys through IdeaVim.
Chezmoi links `~/.config/ideavim/ideavimrc` to that file, so edits through either
path update the repository directly.
See [the PyCharm setup guide](docs/pycharm.md) for installation on macOS, the
companion IDE keymap, and differences from Neovim.

## MultiViewer

MultiViewer settings and saved setups live in `.chezmoitemplates/multiviewer/`.
Chezmoi links `config.json`, `setups.config.json`, and `setups.schema.json` from
`~/.config/MultiViewer/` to those files. Changes saved in MultiViewer update the
repository files directly. Login data, caches, and downloaded configuration stay
local to each machine.

Quit MultiViewer before syncing or applying changes. Back up those three files
on a machine with existing settings, then apply the links:

```sh
chezmoi apply ~/.config/MultiViewer
```

The repository is inside Nextcloud on this machine, so these files sync with it.
For machines using separate Git clones, commit and push changes, then pull them
on the other machine before reopening MultiViewer. Saved setups include monitor
positions and sizes, so you may need to adjust them for a different display setup.

## Layout

- `.chezmoidata.toml` – shared template defaults
- `.chezmoiignore` – profile-specific source exclusions
- `chezmoi.toml.example` – local machine override example
- `dot_config/` – XDG application configuration
- `dot_local/` – commands, assets, and user-local data
