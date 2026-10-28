#!/usr/bin/env python3
"""Check chezmoi platform selection in temporary directories, without downloads."""

import json
from pathlib import Path
import plistlib
import shutil
import subprocess
import tempfile
import tomllib


ROOT = Path(__file__).resolve().parents[1]
PROFILES = ("desktop", "laptop", "x11", "x11-laptop", "mac")
LINUX_APPLICATIONS = (
    "MultiViewer", "asm-lsp", "cliamp", "neomutt", "spotify-tui",
    "sql-language-server", "sqruff", "viu", "zellij",
)
SOLO_LAYOUT = "Library/Keyboard Layouts/SoloLayout.bundle/Contents"


def run(*args, **kwargs):
    result = subprocess.run(
        args, text=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE,
        **kwargs,
    )
    if result.returncode:
        raise RuntimeError(result.stderr.strip())
    return result.stdout


def check(base, original, os_name, arch, profile):
    case = f"{os_name}-{arch}-{profile}"
    work = base / case
    source = work / "source"
    shutil.copytree(original, source)
    home = work / "home"
    home.mkdir()
    config = work / "config.toml"
    config.touch()
    command = (
        "chezmoi", "--config", str(config), "--source", str(source),
        "--destination", str(home), "--persistent-state", str(work / "state.boltdb"),
        "--cache", str(work / "cache"), "--override-data",
        json.dumps({"chezmoi": {"os": os_name, "arch": arch}, "profile": profile}),
    )

    # Render the real manifests, then represent downloads with local target files.
    # This checks OS guards and ignore rules without contacting remote servers.
    externals = {}
    for manifest in sorted((ROOT / ".chezmoiexternals").iterdir()):
        externals.update(tomllib.loads(run(*command, "execute-template", input=manifest.read_text())))
    if os_name == "darwin":
        for name, entry in externals.items():
            target = entry.get("targetPath", name)
            assert not target.startswith(".local/share/"), (case, target)
            assert not any(app in target for app in ("gtk-4.0", "zathura", "awesome", "obs-studio", "rio", "alacritty")), (case, target)
    else:
        assert ".local/share/fonts/jetbrainsmono" in externals, case
        assert ".local/share/themes/rose-pine-gtk" in externals, case
        assert (".config/awesome/awesome-wm-widgets" in externals) == (profile in ("x11", "x11-laptop")), case

    for name, entry in externals.items():
        target = Path(entry.get("targetPath", name))
        # Source names use dot_ prefixes to represent hidden destination names.
        parts = ["dot_" + part[1:] if part.startswith(".") else part for part in target.parts]
        fixture = source.joinpath(*parts)
        if entry["type"] != "file":
            fixture /= "external-fixture"
        fixture.parent.mkdir(parents=True, exist_ok=True)
        fixture.write_text("fixture\n")

    managed = set(run(*command, "managed", "--include", "files,symlinks").splitlines())
    state = json.loads(run(*command, "dump", "--format", "json"))
    assert ".config/fish/config.fish" in managed, case
    assert ".config/fish/conf.d/aliases.fish" in managed, case
    assert ".config/fish/config.local.fish" not in managed, case
    assert not any(p.startswith(("tests/", "docs/")) for p in managed), case
    assert not {"README.md", "justfile", "chezmoi.toml.example"} & managed, case
    assert (".config/omniwm/settings.toml" in managed) == (os_name == "darwin"), case
    for path in (
        ".config/karabiner/karabiner.json",
        ".config/karabiner/assets/complex_modifications/solo-layout.json",
        ".config/karabiner/assets/complex_modifications/1792582317.json",
        ".config/karabiner/solo-layout/build-layout.swift",
        f"{SOLO_LAYOUT}/Info.plist",
        f"{SOLO_LAYOUT}/Resources/Solo Layout.keylayout",
    ):
        assert (path in managed) == (os_name == "darwin"), (case, path)
    assert not any(p.startswith((".config/karabiner/backups/", ".config/karabiner/automatic_backups/")) for p in managed), case
    assert ".config/btop/btop.conf" in managed, case
    for app in LINUX_APPLICATIONS:
        assert any(p.startswith(f".config/{app}/") for p in managed) == (
            os_name == "linux" and profile != "mac"
        ), (case, app)
    if os_name == "darwin":
        tomllib.loads(state[".config/omniwm/settings.toml"]["contents"])
        json.loads(state[".config/karabiner/karabiner.json"]["contents"])
        info = plistlib.loads(state[f"{SOLO_LAYOUT}/Info.plist"]["contents"].encode())
        assert info["CFBundleIdentifier"] == "com.kristians.keyboardlayout.SoloLayout", case
    assert (".config/fish/conf.d/00-mac.fish" in managed) == (os_name == "darwin"), case
    assert (".local/share/vicinae/scripts/close-focused-window.sh" in managed) == (
        os_name == "darwin" and profile != "mac"
    ), case
    assert (".config/mekle/config.toml" in managed) == (
        os_name == "linux" and profile != "mac"
    ), case
    assert (".config/sesh/sesh.toml" in managed) == (profile != "mac"), case

    if os_name == "darwin":
        for prefix in (
            ".config/niri/", ".config/hypr/", ".config/awesome/", ".config/transmission-daemon/",
            ".config/gtk-", ".config/zsh/", ".config/shell/", ".config/wireplumber/",
            ".local/share/applications/", ".local/share/fonts/", ".local/share/themes/",
            ".config/rio/", ".config/alacritty/",
        ):
            assert not any(p.startswith(prefix) for p in managed), (case, prefix)
        for path in (
            ".local/bin/dmenupass", ".local/bin/transadd", ".local/bin/swap-wallpaper",
            ".local/bin/tlimit", ".config/fish/conf.d/00-profile.fish",
            ".config/fish/conf.d/env.fish", ".config/fish/conf.d/linux-aliases.fish",
            ".config/fish/conf.d/login.fish",
        ):
            assert path not in managed, (case, path)
    elif profile != "mac":
        assert ".config/transmission-daemon/settings.json" in managed, case
        assert ".local/bin/tlimit" in managed, case
        assert ".config/fish/conf.d/linux-aliases.fish" in managed, case
        assert (".config/niri/config.kdl" in managed) == (profile in ("desktop", "laptop")), case
        assert (".config/awesome/rc.lua" in managed) == (profile in ("x11", "x11-laptop")), case

    if profile == "mac":
        allowed = {"fish", "atuin", "bat", "btop", "ghostty", "ideavim", "karabiner", "lazygit", "omniwm", "starship"}
        assert all(
            (p.startswith(".config/") and p.split("/")[1] in allowed)
            or (os_name == "darwin" and p.startswith(f"{SOLO_LAYOUT}/"))
            for p in managed
        ), case
        assert ".config/bat/themes/external-fixture" in managed, case
        assert not any(p.startswith((".config/git/", ".config/jj/", ".local/")) for p in managed), case
        atuin = tomllib.loads(state[".config/atuin/config.toml"]["contents"])
        assert atuin["auto_sync"] is False and atuin["update_check"] is False, case
        assert atuin["sync_address"] == "http://127.0.0.1:0", case

    ghostty = state[".config/ghostty/config"]["contents"]
    if os_name == "darwin":
        fish_path = "/opt/homebrew/bin/fish" if arch == "arm64" else "/usr/local/bin/fish"
        assert f"command = /usr/bin/env -u NO_COLOR {fish_path} --login" in ghostty, case
        assert "class =" not in ghostty, case
        environment = state[".config/fish/conf.d/00-mac.fish"]["contents"]
        assert "set -gx TERMINAL ghostty" in environment, case
    else:
        assert "command =" not in ghostty, case
        if profile != "mac":
            rio = tomllib.loads(state[".config/rio/config.toml"]["contents"])
            assert rio["renderer"]["backend"] == "vulkan", case

    if profile != "mac":
        sesh = tomllib.loads(state[".config/sesh/sesh.toml"]["contents"])
        repos = "~/repos/" if os_name == "darwin" else "~/Nextcloud/repos/"
        assert all(session["path"].startswith(repos) for session in sesh["session"]), case
        assert any(window["name"] == "typst" for window in sesh.get("window", [])) == (os_name == "linux"), case
        assert bool(sesh.get("wildcard")) == (os_name == "linux"), case
        if os_name == "linux":
            mekle = tomllib.loads(state[".config/mekle/config.toml"]["contents"])
            assert isinstance(mekle["search_dirs"], list) and mekle["search_dirs"], case
        keymap = state[".config/yazi/keymap.toml"]["contents"]
        rules = tomllib.loads(keymap)["mgr"]["prepend_keymap"]
        platform = "macos" if os_name == "darwin" else "linux"
        active = [rule for rule in rules if rule.get("for") in (None, "unix", platform)]
        commands = json.dumps([rule["run"] for rule in active])
        assert ("pbcopy" in commands) == (os_name == "darwin"), case
        if os_name == "darwin":
            assert "wl-copy" not in commands and "setbg" not in commands, case
        else:
            environment = state[".config/fish/conf.d/00-profile.fish"]["contents"]
            assert 'set -gx TERMINAL "rio"' in environment, case

    for path, entry in state.items():
        if path.endswith(".fish") and entry["type"] == "file" and "/completions/" not in path:
            run("fish", "--no-config", "--no-execute", input=entry["contents"])
    print(f"PASS {case}: {len(managed)} managed files")


def main():
    with tempfile.TemporaryDirectory(prefix="dotfiles-platforms-") as directory:
        base = Path(directory)
        original = base / "original"
        original.mkdir()
        names = run("git", "-C", str(ROOT), "ls-files", "--cached", "--others", "--exclude-standard", "-z")
        for name in set(names.split("\0")):
            if not name or name.startswith(".chezmoiexternals/") or not (ROOT / name).is_file():
                continue
            target = original / name
            target.parent.mkdir(parents=True, exist_ok=True)
            shutil.copy2(ROOT / name, target)
        # Ensure local-only files stay excluded, even if accidentally added.
        for name in ("dot_local/bin/executable_dmenupass", "dot_config/fish/config.local.fish",
                     "dot_config/private_karabiner/backups/karabiner.json",
                     "dot_config/private_karabiner/automatic_backups/karabiner.json"):
            fixture = original / name
            fixture.parent.mkdir(parents=True, exist_ok=True)
            fixture.write_text("# platform fixture\n")
        for os_name, arch in (("linux", "amd64"), ("darwin", "arm64"), ("darwin", "amd64")):
            for profile in PROFILES:
                check(base, original, os_name, arch, profile)


if __name__ == "__main__":
    main()
