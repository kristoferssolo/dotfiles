# The Solorice (Kristofers Solo dotfiles)

- Very useful scripts are in `~/.local/bin/`
- Settings for:
  - nvim (text editor) 
    - Neovim configs have moved to separate repo and can be found [here](https://github.com/kristoferssolo/SoloVim).  
      ```shell
      git clone https://github.com/kristoferssolo/SoloVim ~/.config/nvim
      ```
  - zsh (shell)
  - lf (file manager)
  - nsxiv (image/gif viewer)
  - mpv (video player)
- I try to minimize what's directly in `~` so:
  - All configs that can be in `~/.config/` are there.
  - Some environmental variables have been set in `~/.zshenv` to move configs into `~/.config/`
