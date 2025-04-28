#!/bin/bash

GLOBAL_EMAIL=$(git config --global user.email)
REPO_EMAIL=$(git config --local user.email)

# Check if the local email is empty OR equal to the global email
if [ -z "$REPO_EMAIL" ] || [ "$REPO_EMAIL" = "$GLOBAL_EMAIL" ]; then
    exit 0  # TRUE: Include the key
else
    exit 1  # FALSE: Don't include the key
fi
