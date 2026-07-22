# Personal Preferences and Coding Style

## Python

- Never use `Any` unless 100% necessary or specifically instructed.

## Rust

- Write code as if Clippy's `nursery` and `pedantic` lints are enabled.
- Write idiomatic Rust. Prefer built-in traits, generics, lifetimes, iterator
  adapters, and standard-library facilities where appropriate.
- Prefer custom error types for all internal and external `Result` errors.
  The binary entry point (`main.rs`) is the exception.

### Imports and Module Paths

- Import types from namespaces at the top of the file with `use`.
- Prefer imported types over fully qualified module paths when practical.
  Prefer:

```rust
use crate::protocol::Response;
use color_eyre::eyre;

fn parse(input: &[u8]) -> eyre::Result<Option<Response>>;
```

over:

```rust
fn parse(input: &[u8]) -> color_eyre::Result<Option<Response>>;
```

- This rule may be relaxed for common or clarifying module namespaces, such as
  `error`, and custom `Result` packages, such as `color-eyre` or `miette`.
- When the same imports from a library are used repeatedly, create and use a
  library-specific prelude where appropriate.

### Tests

- In module-level tests, import the parent module with:

```rust
use super::*;
```

- Do not selectively import individual items from the parent module unless
  necessary.
- Use the `claims` crate for expressive assertions involving `Result` and
  `Option` values.

  Prefer:

```rust
assert_ok_eq!(parse(&input), Some(Response::Success(value)));
```

over:

```rust
assert_eq!(parse(&input), Ok(Some(Response::Success(value))));
```

- Use the assertion macro that best matches the expected result:

```rust
assert_ok!(operation());
assert_err!(operation());
assert_some!(value);
assert_none!(value);
```

### Inlining

- Add `#[inline]` to small, frequently called functions where inlining is
  applicable and beneficial.
- Do not add `#[inline]` mechanically. It is generally appropriate for thin
  wrappers, trivial accessors, and performance-sensitive hot paths.

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

When uncertain, prefer: thiserror, color-eyre, clap, strum, tracing, claims, rstest, tempfile.

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
