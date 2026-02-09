# Login shell - auto-start Wayland compositor
# Only runs on TTY1 and if not already running

if status is-login
    if test (tty) = "/dev/tty1"
        if not pgrep -x niri >/dev/null 2>&1
            set -gx WM "niri"
            # set -gx XDG_CURRENT_DESKTOP niri
            # set -gx XDG_SESSION_TYPE wayland
            # set -gx XDG_SESSION_DESKTOP niri
            if command -q dbus-run-session
                exec dbus-run-session niri --session
            else
                exec niri --session
            end
        end

        # Uncomment for Hyprland instead:
        # if not pgrep -x Hyprland >/dev/null 2>&1
        #     set -gx WM "Hyprland"
        #     set -gx XDG_CURRENT_DESKTOP Hyprland
        #     set -gx XDG_SESSION_TYPE wayland
        #     set -gx XDG_SESSION_DESKTOP Hyprland
        #     exec Hyprland
        # end
    end
end
