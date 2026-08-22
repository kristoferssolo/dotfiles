# Solorice Dotfiles

Personal Linux dotfiles managed with [Dotter](https://github.com/SuperCuber/dotter).

The repository is organized by feature package and machine profile. Application
configuration lives in `config/`; personal commands and shared assets live in
`local/`.

Neovim is managed separately in [SoloVim](https://codeberg.org/kristoferssolo/SoloVim):

```sh
git clone https://codeberg.org/kristoferssolo/SoloVim ~/.config/nvim
```

## Profiles

Package definitions and file mappings live in `.dotter/global.toml`.

| Package | Use |
| --- | --- |
| `x11` | X11 desktop |
| `x11-laptop` | X11 laptop |
| `wayland` | Niri and Hyprland Wayland setup |

Machine profiles select a package and supply template variables such as the
terminal, browser, DPI, and font size:

- `.dotter/executor.toml` configures a desktop Niri machine.
- `.dotter/artix-laptop.toml` configures a laptop Niri machine.

## Install

Clone the repository, copy the closest profile to the ignored local profile,
and deploy it:

```sh
git clone https://codeberg.org/kristoferssolo/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
cp .dotter/executor.toml .dotter/local.toml
./dotter --local-config .dotter/local.toml
```

For a laptop, use `.dotter/artix-laptop.toml` instead. Install the applications
you want to use through your distribution's package manager before deploying.

Yazi plugins and flavors are not stored in this repository. Restore them after
the first deploy:

```sh
ya pkg install
```

## Layout

- `config/` — XDG application configuration
- `local/bin/` — commands linked to `~/.local/bin`
- `local/share/` — fonts, desktop entries, wallpapers, and other assets
- `.dotter/global.toml` — package graph and file mappings
- `.dotter/*.toml` — machine profile examples

The repository includes Dotter binaries for Linux, ARM Linux, and Windows:
`dotter`, `dotter.arm`, and `dotter.exe`.
