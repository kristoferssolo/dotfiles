# Personal Preferences

## Python

- Never use `Any` unless 100% necessary or specifically instructed.

## Rust

- Write as if Clippy nursery and pedantic are enabled.
- Import the types from namespaces at the top of the file with `use`.
- The code must be Rust idiomatic – use built in traits, generics, lifetimes, etc.
- Prefer using custom error types for all internal and external Result errors, except for the binary entry point (`main.rs`).

## TypeScript

- Never use `any` unless 100% necessary or specifically instructed.

## Commands

- Don't run dev server commands (e.g., `cargo run server`) – assume it's already running.
- Focus on checking commands like `just check` if the project has justfile, otherwise do `cargo clippy`, `uv run ruff`.

## Package Managers

- Use uv.
- Use pnpm if the project already uses it, otherwise use bun.
- Never use npm or yarn.

## Tech Stack Preferences

When uncertain, prefer: thiserror, miette, clap, strum, tracing, claims, rstest, tempfile.

## Code Style

- Always strive for concise, simple solutions.
- If a problem can be solved in a simpler way, propose it.

## Workflow

- If asked to do too much work at once, stop and state that clearly.

## Commits

After every discrete change (feature, fix, refactor, etc.), you **must** suggest
a commit message. You may **not** run `git commit` yourself -- the user commits
manually.

Commit messages must follow [Conventional Commits](https://www.conventionalcommits.org/):

```gitcommit
<type>(<optional scope>): <short imperative summary>
```

Valid types: `feat`, `fix`, `refactor`, `chore`, `docs`, `test`, `style`, `perf`, `ci`, `build`

Keep changes **atomic** – one logical unit per commit. If a task spans multiple
concerns, break it into sequential steps and suggest a commit after each.

## Helper Style

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
- Respect existing project structure – don't reorganize files unless asked.
- If a task is ambiguous, ask a clarifying question before proceeding.
