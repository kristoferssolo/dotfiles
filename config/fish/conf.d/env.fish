if not contains "$HOME/.local/share/../bin" $PATH
    # Prepending path in case a system-installed binary needs to be overridden
    set -x PATH "$HOME/.local/share/../bin" $PATH
end

# Cargo
set -gx CARGO_HOME "$XDG_DATA_HOME/cargo"
test -d "$CARGO_HOME/bin"; and fish_add_path --move "$CARGO_HOME/bin"

# Bun
set -gx BUN_INSTALL "$XDG_DATA_HOME/bun"
test -d "$BUN_INSTALL/bin"; and fish_add_path --move "$BUN_INSTALL/bin"

# Deno
set -gx DENO_INSTALL "$XDG_DATA_HOME/deno"
test -d "$DENO_INSTALL/bin"; and fish_add_path --move "$DENO_INSTALL/bin"

# pnpm
set -gx PNPM_INSTALL "$XDG_DATA_HOME/pnpm"
test -d "$PNPM_INSTALL/bin"; and fish_add_path --move "$PNPM_INSTALL/bin"
