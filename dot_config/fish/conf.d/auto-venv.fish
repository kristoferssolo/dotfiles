# Starship initializes later in config.fish. Keep virtualenv from saving the
# default prompt at startup and restoring it over Starship on deactivation.
set -gx VIRTUAL_ENV_DISABLE_PROMPT 1

function __auto_vent --on-variable PWD
    if test -f "$PWD/.venv/bin/activate.fish"
        source "$PWD/.venv/bin/activate.fish"
        return
    end

    if set -q VIRTUAL_ENV
        set -l project_dir (path dirname $VIRTUAL_ENV)
        if test "$PWD" != "$project_dir"; and not string match -q -- "$project_dir/*" "$PWD"
            deactivate 2>/dev/null
        end
    end
end

# Sesh and tmux can start Fish inside a project without changing PWD afterward.
if status is-interactive
    __auto_vent
end
