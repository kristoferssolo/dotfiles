# vidir.yazi

This plugin is a bulk-rename plugin using [vidir](https://linux.die.net/man/1/vidir).

## Requirements

- [yazi >= v25.2.7](https://github.com/sxyazi/yazi)
- [vidir](https://linux.die.net/man/1/vidir) (sometimes included in [moreutils](https://man.archlinux.org/listing/extra/moreutils/) package)

## Installation

```bash
ya pack -a kristoferssolo/vidir
```

## Usage

Add this to your `~/.config/yazi/keymap.toml`:

```toml
[[manager.prepend_keymap]]
on = "B"
run = [ "escape --visual", "plugin --sync vidir" ]
desc = "Bulk rename with vidir"
```

## License

This plugin is MIT-licensed. For more information check the [LICENSE](LICENSE) file.
