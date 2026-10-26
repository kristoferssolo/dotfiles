#!/usr/bin/env python3
"""Install a Finder launcher and make it the default for text and source files."""

from datetime import datetime
import json
from pathlib import Path
import platform
import plistlib
import shutil
import subprocess
import tempfile
import time


EXTENSIONS = (
    "txt", "md", "markdown", "py", "pyi", "json", "jsonl", "yaml", "yml",
    "toml", "ini", "cfg", "conf", "env", "log", "rs", "lua", "fish", "sql",
    "sh", "bash", "zsh", "c", "h", "cpp", "hpp", "go", "rb", "typ",
)
BUNDLE_ID = "local.neovim.ghostty"

DEFAULTS_HELPER = r'''
import AppKit
import CoreServices
import UniformTypeIdentifiers

let app = URL(fileURLWithPath: CommandLine.arguments[1])
let bundleID = CommandLine.arguments[2]
let verify = CommandLine.arguments[3] == "verify"
let extensions = Array(CommandLine.arguments.dropFirst(4))
func fail(_ message: String) -> Never {
    fputs(message + "\n", stderr)
    exit(1)
}
if verify {
    let root = FileManager.default.temporaryDirectory.appendingPathComponent(UUID().uuidString)
    try FileManager.default.createDirectory(at: root, withIntermediateDirectories: true)
    defer { try? FileManager.default.removeItem(at: root) }
    for ext in extensions {
        let file = root.appendingPathComponent("check.\(ext)")
        try "".write(to: file, atomically: true, encoding: .utf8)
        let resolved = NSWorkspace.shared.urlForApplication(toOpen: file)
        guard let resolved, Bundle(url: resolved)?.bundleIdentifier == bundleID else {
            fail("Default application verification failed for .\(ext): \(String(describing: resolved))")
        }
    }
    print("Verified Finder defaults for \(extensions.count) file extensions")
    exit(0)
}
let registered = LSRegisterURL(app as CFURL, true)
guard registered == noErr else { fail("App registration failed: \(registered)") }

var types = Set(["public.text", "public.plain-text", "public.source-code"])
for ext in extensions {
    guard let type = UTType(filenameExtension: ext) else {
        fail("No file type registered for .\(ext)")
    }
    types.insert(type.identifier)
}
var previous: [String: String] = [:]
for type in types.sorted() {
    previous[type] = LSCopyDefaultRoleHandlerForContentType(type as CFString, .all)?
        .takeRetainedValue() as String? ?? ""
}
// Print a recovery record before making any changes.
print(String(data: try JSONSerialization.data(withJSONObject: previous, options: .sortedKeys), encoding: .utf8)!)
fflush(stdout)
for type in types.sorted() {
    let result = LSSetDefaultRoleHandlerForContentType(type as CFString, .all, bundleID as CFString)
    guard result == noErr else { fail("Setting \(type) failed: \(result)") }
}
'''


def main():
    if platform.system() != "Darwin":
        raise SystemExit("This installer is for macOS.")
    if not Path("/Applications/Ghostty.app").is_dir():
        raise SystemExit("Install Ghostty in /Applications first.")
    if not shutil.which("nvim") or not shutil.which("fish"):
        raise SystemExit("Install Neovim and Homebrew Fish first.")

    home = Path.home()
    app = home / "Applications/Neovim.app"
    backup = home / ".local/state/neovim-launcher" / datetime.now().strftime("%Y%m%d-%H%M%S-%f")
    backup.mkdir(parents=True)
    preferences = home / "Library/Preferences/com.apple.LaunchServices/com.apple.launchservices.secure.plist"
    if preferences.exists():
        shutil.copy2(preferences, backup / "launchservices.plist")

    query = '''
import Foundation
import UniformTypeIdentifiers
let types = Dictionary(uniqueKeysWithValues: CommandLine.arguments.dropFirst().map {
    ($0, UTType(filenameExtension: $0)!.identifier)
})
print(String(data: try JSONSerialization.data(withJSONObject: types), encoding: .utf8)!)
'''
    types = json.loads(subprocess.check_output(["swift", "-e", query, *EXTENSIONS], text=True))
    declarations = []
    for extension, type_id in types.items():
        if type_id.startswith("dyn.") or type_id.startswith(f"{BUNDLE_ID}.text."):
            type_id = f"{BUNDLE_ID}.text.{extension}"
            types[extension] = type_id
            declarations.append({
                "UTTypeIdentifier": type_id,
                "UTTypeConformsTo": ["public.plain-text"],
                "UTTypeDescription": f"{extension.upper()} text document",
                "UTTypeTagSpecification": {"public.filename-extension": [extension]},
            })

    with tempfile.TemporaryDirectory(prefix="neovim-launcher-") as temporary:
        root = Path(temporary)
        built = root / "Neovim.app"
        subprocess.run([
            "osacompile", "-o", str(built),
            str(Path(__file__).with_name("Neovim.applescript")),
        ], check=True)
        info_path = built / "Contents/Info.plist"
        info = plistlib.loads(info_path.read_bytes())
        info.update({
            "CFBundleIdentifier": BUNDLE_ID,
            "CFBundleName": "Neovim",
            "CFBundleDisplayName": "Neovim",
            "CFBundleShortVersionString": "1.0",
            "CFBundleVersion": "1",
            "LSUIElement": True,
            "UTExportedTypeDeclarations": declarations,
            "CFBundleDocumentTypes": [{
                "CFBundleTypeName": "Text and source code",
                "CFBundleTypeRole": "Editor",
                "LSHandlerRank": "Alternate",
                "LSItemContentTypes": ["public.text", "public.source-code"],
            }] + [{
                "CFBundleTypeName": f"{extension.upper()} document",
                "LSItemContentTypes": [types[extension]],
                "CFBundleTypeRole": "Editor",
                "LSHandlerRank": "Alternate",
            } for extension in EXTENSIONS],
        })
        info_path.write_bytes(plistlib.dumps(info))
        subprocess.run(["codesign", "--force", "--sign", "-", str(built)], check=True)
        app.parent.mkdir(exist_ok=True)
        if app.exists():
            if plistlib.loads((app / "Contents/Info.plist").read_bytes()).get("CFBundleIdentifier") != BUNDLE_ID:
                raise SystemExit(f"Refusing to replace an unrelated app at {app}")
            shutil.move(str(app), backup / "Neovim.app")
        shutil.copytree(built, app)
        helper = root / "defaults.swift"
        helper.write_text(DEFAULTS_HELPER)
        result = subprocess.run([
            "swift", str(helper), str(app), BUNDLE_ID, "set", *EXTENSIONS,
        ], text=True, capture_output=True)
        (backup / "defaults-result.txt").write_text(result.stdout + result.stderr)
        if result.stdout:
            first, _, remaining = result.stdout.partition("\n")
            (backup / "previous-defaults.json").write_text(json.dumps(json.loads(first), indent=2) + "\n")
            print(remaining.strip())
        if result.returncode:
            raise SystemExit(f"Default setup failed. Details and backups are in {backup}")
        # LaunchServices may cache the old associations within the setter process.
        deadline = time.monotonic() + 15
        while True:
            verified = subprocess.run([
                "swift", str(helper), str(app), BUNDLE_ID, "verify", *EXTENSIONS,
            ], text=True, capture_output=True)
            if verified.returncode == 0:
                print(verified.stdout.strip())
                break
            if time.monotonic() >= deadline:
                raise SystemExit(verified.stderr.strip())
            time.sleep(0.5)
    print(f"Installed {app}")
    print(f"Previous defaults saved in {backup}")


if __name__ == "__main__":
    main()
