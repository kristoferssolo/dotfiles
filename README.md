# Solorice Dotfiles

Personal Linux dotfiles managed with [Dotter](https://github.com/SuperCuber/dotter).

This repo is organized around reusable package groups and a small set of host
profiles. Most configuration lives under `config/`, helper scripts live under
`local/bin/`, and extra local assets live under `local/share/`.

## What is here

- Shell setup for `zsh`, `fish`, shared shell env, `tmux`, `starship`, and terminal tools
- Desktop configs for both X11 and Wayland setups
- App configs for tools such as `lf`, `mpv`, `git`, `lazygit`, `jj`, `zathura`, `ghostty`, `alacritty`, `rofi`, `fuzzel`, `waybar`, `dunst`, and more
- Local scripts in `~/.local/bin`
- Fonts, desktop entries, wallpapers, and other assets in `~/.local/share`

Neovim is not managed in this repository anymore. It lives in the separate [SoloVim](https://codeberg.org/kristoferssolo/SoloVim) repo:

```sh
git clone https://codeberg.org/kristoferssolo/SoloVim ~/.config/nvim
```

## Profiles

Dotter package composition is defined in `.dotter/global.toml`.

Top-level environment profiles:

- `x11`
- `x11-laptop`
- `wayland`

The local examples in `.dotter/` currently include:

- `.dotter/executor.toml`
- `.dotter/artix-laptop.toml`

Both example profiles enable the `wayland` package and set machine-specific
template variables such as DPI, font size, terminal, and browser.

## Install

1. Clone the repository.
2. Pick or create a local Dotter profile in `.dotter/`.
3. Apply the dotfiles with the bundled Dotter binary.

Example:

```sh
git clone https://codeberg.org/kristoferssolo/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
cp .dotter/executor.toml .dotter/local.toml
./dotter -c .dotter/local.toml
```

If you are setting up a laptop Wayland machine instead, start from
`.dotter/artix-laptop.toml`.

Before first use of Yazi, run:

```sh
ya pkg install
```

That restores the plugins and flavors declared in `config/yazi/package.toml`.

## Layout

- `config/`: XDG-style application configuration
- `local/bin/`: personal scripts linked into `~/.local/bin`
- `local/share/`: fonts, wallpapers, desktop files, and other shared assets
- `.dotter/global.toml`: package graph and file mappings
- `.dotter/*.toml`: machine-specific profile inputs

## Notes

- The setup tries to keep `$HOME` clean and prefers XDG locations where possible.
- Some files are rendered from Dotter templates, so profile variables matter.
- Yazi plugin and flavor dependencies are installed separately with `ya pkg install`.
- The repository includes Linux, ARM, and Windows Dotter binaries: `dotter`, `dotter.arm`, and `dotter.exe`.

## License

MIT. See [`LICENSE`](LICENSE) file.
