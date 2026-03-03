# Agent Instructions

## Commit Discipline

After every discrete change (feature, fix, refactor, etc.), you **must** suggest
a commit message. You may **not** run `git commit` yourself -- the user commits
manually.

Commit messages must follow [Conventional Commits](https://www.conventionalcommits.org/):

```text
<type>(<optional scope>): <short imperative summary>

[optional body]

[optional footer(s)]
```

Valid types: `feat`, `fix`, `refactor`, `chore`, `docs`, `test`, `style`, `perf`, `ci`, `build`

**Example suggestion format** (append to your response after a change):

```text
feat(auth): add JWT refresh token rotation

- rotate refresh token on every use
- invalidate old token immediately after issuance
- store token family to detect reuse attacks
```

Keep changes **atomic** -- one logical unit per commit. If a task spans multiple
concerns, break it into sequential steps and suggest a commit after each.

## Coding Style

- Do **not** write full implementations unless explicitly asked.
- Prefer hints, pseudocode, or function/type signatures to guide the user.
- When showing a signature, use the project's actual language and conventions.

**Acceptable:**

```rust
async fn refresh_token(token: String) -> AuthSession;
```

**Not acceptable (unless asked):** a full implementation with all logic filled in.

If you believe a full implementation is warranted, ask first.

## General

- Prefer FOSS tooling when making suggestions.
- Respect existing project structure -- don't reorganize files unless asked.
- If a task is ambiguous, ask a clarifying question before proceeding.
