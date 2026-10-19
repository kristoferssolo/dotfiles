# Solorice Dotfiles

Personal Linux and macOS dotfiles managed with [chezmoi](https://www.chezmoi.io/).

Chezmoi uses chezmoi's naming convention:
`dot_config` maps to `~/.config` and `dot_local` maps to `~/.local`.
Neovim is managed separately in [SoloVim](https://codeberg.org/kristoferssolo/SoloVim):

```sh
git clone https://github.com/kristoferssolo/SoloVim ~/.config/nvim
```

## Apps

### Mac

- Window manager: OmniWM. Import the Mac's existing settings as described below.
- Terminal: Ghostty with Fish.
- Editor and IDE: Neovim with SoloVim, and PyCharm with IdeaVim and the SoloVim keymap.
- Shell tools: Starship, Atuin with local-only history, zoxide, fzf, eza, and bat.
- Git interface: lazygit. Git identity and signing settings stay local to the Mac.

### Linux

- Window manager: Niri for the desktop and laptop profiles. Hyprland configs are
  also included; the X11 profiles use AwesomeWM.
- Terminals: Rio by default, with Ghostty and Alacritty configs also available.
- Desktop shell and notifications: ashell and Mako, with Waybar and Dunst configs
  available for other setups.
- App launcher: Vicinae, with Fuzzel, Rofi, and Wofi configs also included.
- Browser: Floorp by default, configurable through local chezmoi data.
- Shell: Fish with Starship, Atuin, zoxide, and mekle. Legacy Zsh configs are
  also included.
- File managers: Yazi and lf.
- Terminal sessions: tmux, Zellij, and sesh.
- Version control: Git and jj, with lazygit, gitui, and gh-dash configs.
- Documents: Sioyek, Zathura, and Glow.
- Media and chat: mpv, Spotify, Vesktop with Vencord settings, and AyuGram.
- Sync and torrents: Nextcloud and Transmission daemon.
- System tools: btop, htop, Fastfetch, and paru.

MultiViewer settings are also tracked; see the section below for syncing them.
The work Mac profile deploys the smaller selection listed above. Having an app's
config in this repository does not install the app or enable it in every profile.

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
| `mac` | Small work setup with Fish, local-only Atuin, Ghostty, Starship, bat, lazygit, IdeaVim, and OmniWM settings when added |

The operating system and profile control different choices. Chezmoi detects the
OS automatically through `.chezmoi.os`. Linux desktop configs, Transmission daemon
settings, Linux-specific shell files, and scripts that require Linux tools are
excluded on macOS regardless of profile. OmniWM and the Homebrew Fish environment
are excluded on Linux. External fonts and GTK, Awesome, and Zathura downloads
follow the same OS selection.

Profiles select Linux desktop variants or the smaller work application set.
The default remains `desktop`; select `mac` explicitly on the work Mac to keep
personal applications and identities excluded. No `os` setting is needed in the
local config. See [chezmoi's machine differences guide](https://www.chezmoi.io/user-guide/manage-machine-to-machine-differences/)
for the template and ignore mechanisms.

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
brew install --cask ghostty font-jetbrains-mono-nerd-font
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

Ghostty is the only terminal configured on macOS. It starts Homebrew Fish on
Apple Silicon or Intel without changing your account's login shell, using its
[`command` setting](https://ghostty.org/docs/config/reference#command).
Fish sets `TERMINAL=ghostty` on macOS. Rio and Alacritty configs and their theme
downloads are Linux-only. Optional Fish
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

## Adding platform-specific files

Keep application files in the existing chezmoi layout, such as
`dot_config/omniwm/` and `dot_local/bin/executable_name`. Add their destination
paths to the appropriate OS section in `.chezmoiignore`. Use `.tmpl` conditions
for small differences within shared files. Fish's shared aliases live in
`aliases.fish`; Linux commands and GNU-specific flags live in `linux-aliases.fish`.
The existing Zsh and legacy shell setup remains Linux-only; macOS uses Fish.

The `mac` profile also has an explicit application allowlist at the top of
`.chezmoiignore`. Add shared applications there when you want them on the work
machine. Guard platform-specific allowlist entries with `.chezmoi.os` too, since
negated ignore patterns override exclusions. Git and jj remain
excluded from this profile, so work identity and signing configuration stay local.

OmniWM is already allowed for macOS, including the work profile. Its settings
aren't in this repository yet. On the Mac, import your existing configuration:

```sh
chezmoi add ~/.config/omniwm/settings.toml
chezmoi diff
```

That creates `dot_config/omniwm/settings.toml` in the source checkout. Commit and
push it to share the settings; Linux machines will ignore it. OmniWM documents
the settings path and live reload behavior in its
[configuration guide](https://omniwm.app/config/configuration/).

The macOS Vicinae config binds Option+Shift+Q to the Close Focused Window script.
Keep Vicinae running, enable IPC in OmniWM, and leave OmniWM's own Close Focused
Window shortcut unassigned. The script uses Ghostty's AppleScript API for
borderless Ghostty windows and OmniWM for other apps. Allow Vicinae to control
Ghostty if macOS requests Automation permission.

## Mekle and sesh

Mekle's `~/.config/mekle/config.toml` is managed on Linux only. Override
`mekle_search_dirs` under `[data]` in `~/.config/chezmoi/chezmoi.toml` to change
the search paths on a Linux machine. On macOS, edit the local mekle config
directly; chezmoi leaves it alone, including any existing customizations.
Mekle's history stays local on every platform.

Sesh has separate plain TOML configs in `.chezmoitemplates/sesh/`:

- `sesh-macos.toml` uses `~/repos/` and the Mac's terminal tools.
- `sesh-linux.toml` uses `~/Nextcloud/repos/` and includes the Nextcloud/Typst setup.

Edit the appropriate file to change that platform's sessions and windows.
Chezmoi selects it by OS and writes it to `~/.config/sesh/sesh.toml`.
The small `mac` profile still excludes sesh; other profiles deploy it on both OSes.

## Checking platform selection

Run `just check-platforms` with Python 3.11+, chezmoi, and Fish installed. It checks
the managed files, renders templates for Linux and macOS across all profiles,
and checks Fish startup files and functions for syntax errors. External download
targets use local fixtures, so the
check does not download themes or change your home directory. macOS application
behavior still needs checking on a Mac.

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
- `.chezmoiignore` – OS and profile-specific source exclusions
- `chezmoi.toml.example` – local machine override example
- `dot_config/` – XDG application configuration
- `dot_local/` – commands, assets, and user-local data
