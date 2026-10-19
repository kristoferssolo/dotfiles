#!/bin/sh
# @vicinae.schemaVersion 1
# @vicinae.title Close Focused Window
# @vicinae.mode silent

exec /usr/bin/osascript <<'APPLESCRIPT'
use framework "AppKit"
use scripting additions

set frontApp to current application's NSWorkspace's sharedWorkspace()'s frontmostApplication()
if frontApp is missing value then return

set bundleID to frontApp's bundleIdentifier() as text
if bundleID is "com.mitchellh.ghostty" then
    -- Borderless Ghostty has no accessibility close button for OmniWM to press.
    tell application id "com.mitchellh.ghostty"
        if (count windows) > 0 then close window front window
    end tell
else
    do shell script "/Applications/OmniWM.app/Contents/MacOS/omniwmctl command close-focused-window"
end if
APPLESCRIPT
