---
name: file-pr
description: >-
  File a concise pull request. Use when the user asks to file, open, or create a PR.
---
# File PR

Before filing, check whether a PR for this branch already exists. Review the
diff locally against `origin/main` to make sure its contents match the goal.

PR titles usually become commit messages, so follow the ropository's title conventions. Look at recently merged PRs and Git history for examples. Prefer a concise, human-readable title that explains why the change matters:

BAD:
`> ❌ perf(server): negotiate permessage-deflate on the websocket`

GOOD
`> ✅  perf(server): cut websocket from size by 70%+ with gzipping`

Open the description with a simple explanation of the problem based on the user's original prompt, then briefly explain the solution. Do not lead with and implementation inventory:

BAD
`> ❌ Removed implicit workspace carry-over from every "new thread" entry point
(Ctrl+n / Ctrl+Shift+o, sidebar v1/v2 buttons, command pallete). New threads
inherit only the project from context; branch, worktree and env mode always
come from configured defaults. Deleted buildContextualThreadOptions,
startNewThreadInProjectFromContext, and v1 sidebar's seed-context machinery.`

GOOD
`> ✅  My "new worktree" default was ignored when starting new thread on
existing worktrees. Super unintuitive. Now your preferences always apply.`

Open a draft PR rather than a ready-for-review PR
