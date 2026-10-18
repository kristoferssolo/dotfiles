# Solorice Dotfiles

Personal Linux dotfiles and a small work macOS profile managed with [chezmoi](https://www.chezmoi.io/).

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
| `mac` | Fish, local-only Atuin, Rio, Starship, bat, lazygit, and IdeaVim |

Profile data controls conditional source inclusion through `.chezmoiignore`.
Values in `~/.config/chezmoi/chezmoi.toml` override the shared defaults.

## Install

Clone the repository and initialize chezmoi using its source directory:

```sh
git clone https://github.com/kristoferssolo/dotfiles.git ~/.dotfiles
chezmoi init --source ~/.dotfiles
chezmoi apply --source ~/.dotfiles --dry-run
chezmoi apply --source ~/.dotfiles
```

Set `sourceDir = "~/.dotfiles"` at the top of your local chezmoi config to use
that checkout without passing `--source` on later commands.

Install the applications you want through your distribution's package manager
before applying. Yazi packages and Fish plugins are not stored in this repository. Restore them
from their manifests after the first apply:

```sh
just plugins
```

## Work Mac

The `mac` profile deploys only the configs listed above. It excludes Linux
desktop settings, personal Git and jj identities, MultiViewer setups, and the
scripts and data under `~/.local`. New application configs stay excluded until
they are added to the work profile's list in `.chezmoiignore`.

With [Homebrew](https://docs.brew.sh/Installation) installed, run these commands
in the Mac's existing shell:

```sh
brew install chezmoi fish atuin starship zoxide fzf eza bat lazygit neovim
brew install --cask rio font-jetbrains-mono-nerd-font
git clone https://github.com/kristoferssolo/dotfiles.git ~/.dotfiles
mkdir -p ~/.config/chezmoi
```

Before the first apply, create `~/.config/chezmoi/chezmoi.toml` with the following
contents. If it already exists, merge these settings into it:

```toml
sourceDir = "~/.dotfiles"

[data]
profile = "mac"
font_size = "14"

[git]
autoCommit = false
autoPush = false
```

Then review and apply:

```sh
chezmoi init --source ~/.dotfiles
chezmoi managed
chezmoi diff
chezmoi apply --dry-run
chezmoi apply
bat cache --build
```

Rio starts Homebrew Fish on Apple Silicon or Intel without changing your
account's login shell. Its config uses the Metal renderer on macOS. Other terminals
can run `fish` directly. Optional Fish
integrations start only when installed. Yazi and sesh keybindings need their
respective tools, which this profile does not install or configure. Follow the
[PyCharm guide](docs/pycharm.md) to enable IdeaVim and install its companion keymap.
Neovim's config is still installed separately as described above.

Atuin keeps its normal local database on the Mac. The work profile forces
`auto_sync = false` and `update_check = false`, keeps the daemon disabled, and
replaces the personal server address with an unused loopback endpoint. Automatic
sync and update checks follow [Atuin's config settings](https://docs.atuin.sh/main/configuration/config/).
Do not log into your personal Atuin account or copy its database, session, or
encryption key onto the work machine. These settings do not remove history or
credentials from an existing installation. Fish explicitly selects
`~/.config/atuin` so the managed config also takes effect with newer Atuin versions.
Environment overrides and a different config can change this behavior.

On another profile, set `atuin_sync = false` under `[data]` for the same local-only
Atuin settings. Existing Linux profiles retain their personal sync configuration
by default.

Keep work Git identity and signing settings in the Mac's local Git config. Fish
loads `~/.config/fish/config.local.fish` last for private work paths and environment
settings. Chezmoi does not manage that file. The work environment uses Homebrew's
[Fish shell setup](https://docs.brew.sh/Manpage#shellenv-shell-), and leaves native
credential and language-tool locations alone.

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
