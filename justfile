# Restore Yazi packages and the Fish plugins listed in fish_plugins.
plugins:
    ya pkg update
    fisher update

# Check both operating systems without applying to the current home directory.
check-platforms:
    python3 tests/check_platforms.py
