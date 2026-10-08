# PyCharm with SoloVim keys

`.chezmoitemplates/ideavimrc` is linked to `~/.config/ideavim/ideavimrc` by
`dot_config/ideavim/symlink_ideavimrc.tmpl`. It follows the current SoloVim config's
Space leader, picker keys, LSP keys, split navigation, surround editing, and DAP
keys. PyCharm supplies the project search, refactoring, Git, and debugger tools.

Editing either path updates the same repository file. Config edits need no
`chezmoi apply`; reload IdeaVim with Space `oo`, or restart for extension mapping
changes. Keep the checkout available because the link points into it. Chezmoi
uses its source directory to generate the link target on each machine.

## Install on the Mac

1. Open PyCharm Settings with Command-comma. Under Plugins, install **IdeaVim**
   and **Vim AnyObject**, plus **HarpoonIJ**. Restart if prompted. Enable IdeaVim
   through Tools > Vim.
1. Install the local **SoloVim Documentation Popup Keys** helper from disk for
   the second `K` shortcut. It also restores the saved Project width after initial
   native Wayland sizing on Linux. Build its ZIP against your PyCharm installation:

   ```sh
   python3 .chezmoitemplates/pycharm/popup-keys/build.py \
     /Applications/PyCharm.app/Contents /tmp/SoloVimPopupKeys.zip
   ```

   Under Settings > Plugins, use the gear menu's **Install Plugin from Disk**
   and select that ZIP, then restart. This helper supports PyCharm 2026.2.
   If you skip it, change the `K` mapping's action to `QuickJavaDoc` for ordinary
   quick documentation. The helper is installed separately from Marketplace
   plugins and may need changes for later IDE versions.
1. From this repository's root, deploy only the IdeaVim config:

   ```sh
   chezmoi apply --source "$PWD" --dry-run ~/.config/ideavim/ideavimrc
   chezmoi apply --source "$PWD" ~/.config/ideavim/ideavimrc
   ```

   Without chezmoi, run these commands from the repository root:

   ```sh
   mkdir -p ~/.config/ideavim
   ln -s "$PWD/.chezmoitemplates/ideavimrc" ~/.config/ideavim/ideavimrc
   ```

   If you already have an IdeaVim config, review the dry-run diff or back it up
   and move it aside before creating the link manually. IdeaVim checks
   `~/.ideavimrc` and `~/_ideavimrc` before the XDG path, so migrate or rename
   those old files if present. Explicit custom paths also take precedence.

   IdeaVim uses `$XDG_CONFIG_HOME/ideavim/ideavimrc` when that environment variable
   is set, and `~/.config/ideavim/ideavimrc` otherwise, including on macOS. The
   chezmoi commands above deploy to `~/.config`; if your IDE receives a different
   `XDG_CONFIG_HOME`, create the link in that directory instead. Space `oo` follows
   the IDE's `XDG_CONFIG_HOME` when reloading.
1. In a PyCharm editor, run `:source ~/.config/ideavim/ideavimrc`. Later, Space `oo` saves files
   and reloads the config. No Neovim Lua files or plugin manager are needed.
1. Install the companion keymap for Harpoon and debugger keys outside the
   editor. Find its configuration directory through
   Help > Diagnostic Tools > Special Files and Folders, then quit PyCharm and copy
   `.chezmoitemplates/pycharm/SoloVim macOS.xml` into its `keymaps` directory.
   On macOS the directory is under
   `~/Library/Application Support/JetBrains/<product><version>/keymaps`.
   Create `keymaps` if it does not exist. Reopen PyCharm and select **SoloVim
   macOS** under Settings > Keymap.

Only the IdeaVim symlink is deployed automatically. The keymap is installed manually
because JetBrains uses version-specific configuration directories.

## Everyday keys

`Space pf` means press Space, then p, then f in Normal mode. Ctrl means the
physical Control key; Alt means Option on the Mac.

| Keys | PyCharm workflow |
| --- | --- |
| Ctrl-n / Space pf / Space pg | Find a file |
| Space ps / Space pw | Search the project / search selected text or current word |
| Space pb / Space pr | Open-file switcher / recent files |
| Space pk | Find an IDE action by name |
| `-` | Locate this file in the Project tree |
| Space b / Space ws | File outline / project symbols |
| Space a | Append current file to Harpoon |
| Ctrl-e / Option-1 to Option-4 | Harpoon menu / jump to a Harpoon file |
| Ctrl-h/j/k/l | Focus an editor split |
| Alt-j / Alt-k | Move current line or Visual-mode selected lines down / up |
| `:vsplit` / `:split` / Ctrl-w c | Create vertical/horizontal split / close split |
| `gd` / `gD` / `gi` | Declaration or usages / declaration only / implementation |
| `gr` / `gR` / `K` | Find usages / usages popup / documentation |
| Space lr / Space la | Rename / code actions and quick fixes |
| Space lD / Space wd | Type declaration / error description |
| `]d` / `[d` or Space lj/lk | Next/previous issue in the current file |
| Space xx / Space xd / Space pD | Problems tool window |
| Space f | Format file or visual selection |
| `gcc` / `gc{motion}` | Comment line / comment a region |
| `saiw"` / `sd"` / `sr"'` | Add quotes around word / delete quotes / change quotes |
| `vaa` / `via` / `vaf` / `vac` | Select argument / inner argument / function / class |
| Space gg / Space gl | Git local changes / Version Control tool window |
| Space gb / Space gd | Git blame / compare file against repository version |
| Space cf / Space oo | Copy absolute file path / save and reload IdeaVim |
| Space u / Space U | Recent Local History tool window / current file's history dialog |
| Space ot | Open terminal |

The companion keymap assigns Option-1 to Option-4 to Harpoon and reserves
F1 to F4/F6 for debugging. Conflicting function-key bindings are removed, while
their alternative shortcuts are preserved. Command shortcuts inherit the macOS
keymap. Ctrl-e opens Harpoon from Normal mode in the editor.

Press `K` on an object to show quick documentation. With the local helper,
press `K` again while the popup has focus to open the Documentation tool window.
The helper adds Shift-k only to that popup. It preserves the IDE's native
documentation shortcut and does not bind uppercase K in other text fields.

## Project tree with Oil-style keys

IdeaVim's built-in NERDTree extension supplies keyboard controls in PyCharm's
Project tree. It needs no separate plugin. Press `-` in the editor to open the
tree at the current file, then use:

| Keys in the tree | Action |
| --- | --- |
| j / k | Move down / up |
| Enter | Open file or expand/collapse directory |
| `-` | Select the parent node |
| Ctrl-v / Ctrl-s | Open file in vertical / horizontal split |
| n / N | Create file / directory |
| Ctrl-r | Rename selected item |
| d | Delete selected item through the IDE dialog |
| m | Open the item's context menu |
| q | Close the tree |

Opening a file also hides the tree, matching Oil's return to the editor. To keep
the sidebar open instead, set `g:NERDTreeQuitOnOpen` to 0. Disable **Open Files
with Single Click** in the Project tool window options if moving with j/k opens
files automatically. Restart PyCharm after first enabling the extension; later
changes to tree key variables may also need a restart because the extension
builds its mappings at initialization.

This remains a tree with IDE file-operation dialogs. Oil's editable directory
buffer and batched changes on `:w` are unavailable. See
[IdeaVim's NERDTree documentation](https://github.com/JetBrains/ideavim/wiki/NERDTree-support).

## Text objects with Vim AnyObject

The config enables the Marketplace plugin **Vim AnyObject** and disables the
built-in argument, function, and class extensions that would overlap with it.
Conditional and comment keys match SoloVim. Collection items move to `e` so
`ii`/`ai` can select conditionals instead of items.

| Inner / outer keys | Object |
| --- | --- |
| `if` / `af` | Function body / entire function |
| `ic` / `ac` | Class body / entire class |
| `ia` / `aa` | Argument / argument including separator |
| `il` / `al` | Loop body / entire loop |
| `ii` / `ai` | Current conditional branch body / entire conditional |
| `it` / `at` | Comment content / entire comment |
| `ie` / `ae` | Collection item / item including separator |
| `in` / `an` | Indentation block content / entire block lines |

Use these with operators or visual mode, such as `vaf`, `cif`, and `daa`.
Other AnyObject objects keep their defaults, including subwords on `iu`/`au`
and any quote type on `iq`/`aq`. The plugin also supplies `]`/`[` object motions,
such as `]a`/`[a` for arguments. The existing explicit `]d`/`[d` mappings keep
issue navigation, and `]m`/`[m` keep the IDE's Normal-mode method navigation.

Restart PyCharm after first enabling AnyObject or changing its mapping variables.
See the [AnyObject documentation](https://github.com/magidc/ideavim-anyobject/blob/release/README.md)
for the remaining objects and customization options.

## Debugging and tests

Select the project's Python interpreter under Settings > Python > Interpreter.
Create or select a run/debug configuration for the entry point or tests. For
pytest projects, select pytest under Settings > Python > Integrated Tools and
use the project's existing test configuration.

| Keys | Action |
| --- | --- |
| Space dd / Space dD | Toggle breakpoint / add conditional breakpoint |
| Space dl | Start debugging the selected configuration |
| Space dc / F1 | Resume a paused debugger |
| Space di / F2 | Step into |
| Space do / F3 | Step over |
| Space dO / F4 | Step out |
| Space dT / Space dt | Stop / open Debug tool window |
| Space dh / Space dP | Evaluate expression quickly / evaluation dialog |
| F6 | Rerun the current run/debug session |
| Space tr / Space td | Run / debug context at cursor, such as a test |
| Space ts / Space tl | Open Run tool window / rerun current session |

Starting and resuming are separate actions here. Use Space dl to start and Space
dc after a breakpoint. The IDE keymap keeps F1 to F4/F6 available when a debugger
panel has focus. Space mappings are intended for the editor.

## Editor and Mac settings

- Under Editor > General > Editor Tabs, set tab placement to **None** if you
  want your Neovim layout. Use file search, the switcher, and Harpoon instead.
- Use the project's Code Style or `.editorconfig`. For projects without a style,
  your Neovim defaults are four spaces and a visual guide at column 120.
- Your Neovim Python formatter uses Ruff, Ruff fixes/import sorting, and
  docformatter. In current PyCharm, configure Ruff under Settings > Python >
  Tools > Ruff if the project uses it. Enable formatting through **Reformat Code**
  so Space f uses Ruff, and configure its save actions to match the project.
  Plain Reformat Code otherwise uses PyCharm's formatter. This config does not
  recreate the complete Conform formatter chain.
- In macOS Keyboard settings, enable standard F1, F2, etc. function keys, or hold
  Fn when using debugger keys. If macOS consumes Ctrl-Space for input-source
  switching, change that OS shortcut before using it for completion.
- Insert mode keeps PyCharm's completion and live-template controls. Enter
  accepts a completion, Tab advances template fields, and Ctrl-h shows parameter
  info. Escape returns to Normal mode. Select mode stays native so typing replaces
  rename/template fields.
- If a configured shortcut invokes an unexpected IDE action, check Settings >
  Editor > Vim. The config uses per-key `sethandler` rules to route Normal-mode
  shortcuts to Vim while keeping Insert/Select-mode IDE controls.

## Sidebar size and Local History on Linux

The current Linux setup remembers a separate size for each tool window. PyCharm
2026.2 stores the project layout in its configuration directory's `workspace`
files and named layouts in `options/window.layouts.xml`. Quit the IDE before
editing either, because it writes its in-memory layout on exit.

The named Custom layout was aligned with the then-current bunyan-formatter
Project weight, `0.15654388`, about 400 pixels in a 2552-pixel window. The user's
later adjustment was `0.11892633`, about 303 pixels. The helper follows the
project's saved preference rather than imposing either width. The
Niri rules start the main PyCharm window at full column width so the panel is
not restored against a half-width starting window. That rule and aligning the
saved layouts did not stop the reset: the saved ratio survived, while the
visible panel was about half the requested size.

Runtime measurements confirmed that the root frame started at 1274 pixels and
later grew to 2552, while the Project panel kept its initial pixel width. On
exit, that smaller panel could overwrite the saved ratio as well. The original
ratio was recovered before testing the workaround.

The local helper watches the first 30 seconds after Project registration. It
checks the initial stable frame and each subsequent stable frame width, then
reapplies the saved Project ratio. After the initial check, it acts only when
the frame width changes, so manual panel resizing does not trigger another
correction at that same frame width.
Its `SoloVim Project layout` entries in
the IDE log record the saved ratio, frame width and panel dimensions. It runs
only under JetBrains' native Wayland toolkit and leaves macOS startup alone.
Version 0.1.2 passed two restarts where the frame grew after registration, but
missed a launch where the frame was already full width by registration. Version
0.1.3 checks both cases. Applying the corrected listener to the running IDE
restored the panel from 151 to 303 pixels and persisted `0.11892633`.
The plugin update was queued through the IDE's startup action manager so its
loaded JAR could remain untouched. The next launch will install version 0.1.3.

Space `u` uses Recent Changes, which opens the Local History tool window in the
installed PyCharm 2026.2. Move it to the left with its tool-window menu if you
want a sidebar. Space `U` keeps per-file history, which opens a separate dialog.
The Niri rules float that dialog at 1100 by 750 instead of giving it a full
column. These window-manager rules apply only on Linux.

The saved IDE layout is machine-local and is not deployed by chezmoi. Keep the
IdeaVim config and helper source in dotfiles; do not symlink the entire IDE
configuration directory.

## Differences worth learning

- Space u opens recent Local History, and Space U shows a single file's history.
  Use them to compare earlier versions and restore changes. They do not show
  Atone's branching undo graph. Normal-mode
  `u` and Ctrl-r still undo and redo. See
  [Local History](https://www.jetbrains.com/help/pycharm/local-history.html).
- HarpoonIJ supplies the file list. Space a appends, Ctrl-e opens its menu, and
  Option-1 to Option-4 jump to slots. Its behavior depends on the installed
  plugin version. See [HarpoonIJ](https://github.com/AlexGirardDev/HarpoonIJ).
- The Project tree replaces Oil browsing, but editing directory listings as text
  is unavailable. Use the tree's rename/move actions for file operations.
- File search follows PyCharm's project scope, excluded directories, and indexing.
  Space pg is the same file search as Space pf, rather than a Git-tracked filter.
  Space pb opens PyCharm's switcher, which also lists tool windows.
- Problems replaces Trouble. Space xd does not force a buffer-only filter; select
  **Current File** in the Problems window. Next/previous issue keys are file-local.
- Surround uses vim-surround matching, so some delimiter/whitespace behavior
  differs from mini.surround. AnyObject supplies code text objects, but selections
  follow its language support and may differ from SoloVim's Treesitter queries.
  `]m`/`[m` are Normal-mode IDE navigation actions.
- Ctrl-h/j/k/l navigate editor splits; they do not cross into an external tmux
  session. Use Space ot for the IDE terminal, or keep your terminal/tmux workflow.
  Ctrl-f's sesh picker, LazyGit popups, Neotest watch mode, and F5 reverse stepping
  are not recreated. Run `sesh`/`lazygit` in your terminal when needed.
- The original config assigns Ctrl-backslash to both LazyGit and previous-window
  navigation. This config chooses previous split; Git changes are on Space gg.

## Quick check after installing

Open a Python project and check Space pf, Space ps, gd, K twice, and Space lr.
Add a file with Space a, inspect the list with Ctrl-e, and jump back with Option-1.
Split an editor and try Ctrl-h/l. On scratch Python code, try gcc, saiw", sd",
vaf, vif, vac, vil, and vii, then undo. Finally, set a breakpoint with Space dd,
start with Space dl, and resume with F1.

For a missing action, run `:actionlist <part-of-name>` or use **IdeaVim: Track
Action IDs** from Find Action. Reload with Space oo after editing the config.

The action IDs, extension names, and mapping targets were checked against the
installed PyCharm 2026.2.3, IdeaVim 2.47.3, and HarpoonIJ 0.2.0 resources. The
popup helper compiles against that PyCharm installation. Its live popup behavior,
and Mac keyboard interactions still need the checks above. The growing-frame
startup path passed two consecutive restarts. The additional full-frame startup
case passed in the running IDE with version 0.1.3; its queued update still needs
a fresh-start check.

References: [IdeaVim configuration and actions](https://github.com/JetBrains/ideavim),
[IdeaVim extensions](https://github.com/JetBrains/ideavim/wiki/IdeaVim-Plugins),
[shortcut handlers](https://github.com/JetBrains/ideavim/wiki/sethandler),
[custom PyCharm keymaps](https://www.jetbrains.com/help/pycharm/configuring-keyboard-and-mouse-shortcuts.html),
[quick documentation](https://www.jetbrains.com/help/pycharm/viewing-reference-information.html), and
[Python tools including Ruff](https://www.jetbrains.com/help/pycharm/lsp-tools.html).
