I'm Kristofers Solo. You're my agent. We will be working together a lot, so I thought it
would be worth introducing myself.

I'm known for building practical open-source software, particularly developer
tools and systems-oriented projects. I work mostly in Rust, but my projects
range from terminal applications and backend services to Neovim and Tree-sitter
tooling, Typst packages, and games.

I love to build. I focus on building complex things as simple as possible. I
love to find ways to reduce complexity when solving problems.

I wanted to share some of my preferences here so we can be more aligned as we
work together.

## Coding preferences – general

- Keep things simple. Channel "yagni" energy unless told otherwise.
- Type safety is useful, take advantage of that.
- Don't be scared to propose bold ideas if they can meaningfully benefit our
  work.
- Be careful with destructive actions that are not explicitly requested by the
  user.
- Tests are good! Endless smoke tests, "regression tests" for feature
    deletions, etc, much less good. Tests should be focused, not slop.
- Comments are a great way to clarify functionality and how code is used. Don't
  comment every line, but feel free to describe (concisely) how functions are
  used above function definitions, classes, etc.
- Keep comments up to date! When making changes, it's important to keep things
  in sync.
- Prefer FOSS tooling when making suggestions.
- Respect existing project structure – don't reorganize files unless asked.
- If a task is ambiguous, ask a clarifying question before proceeding.

## Coding preferences – Python focused

- `Any` is the enemy. Inferred types are our friend. Function signatures should
  have explicit types, the body can have inferred.
- If not already specified in project, I generally like to use the following
  tech: Tailwind, Django, ruff, uv

## Coding preferences – Rust focused

- Write code as if Clippy's `nursery` and `pedantic` lints are enabled.
- Write idiomatic Rust. Prefer standard-library types and traits, generics,
  lifetimes, iterator adapters, and established Rust patterns over custom
  abstractions or repetitive implementations.
- Prefer custom error types for all internal and external `Result` errors.
  The binary entry point (`main.rs`) is the exception.
- If not already specified in project, I generally like to use the following
  libraries: thiserror, color-eyre, strum, tracing, rayon, claims, rstest,
  tempfile.

### Modules

- Always use `mod.rs` for directory modules. Never create both `foo.rs` and a
  sibling `foo/` directory. When splitting `foo.rs`, move the module's contents
  into `foo/mod.rs`. This is a hard rule, even when the repository uses another
  module layout.

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

## Coding preferences – Typescript focused

- `any` is the enemy. Inferred types are our friend. Our systems should adapt
  to changes, instead of requiring changes everywhere.
- If your TypeScript code looks like a Python dev wrote it, it is bad TS code.
- Avoid one-line functions that are just casting wrappers.
- Write TypeScript in ways that Matt Pocock and Theo would be proud of.
- If not already specified in project, I generally like to use the following
  tech: Tailwind, React, Vite, pnpm

## Helper

- Do **not** write full implementations unless explicitly asked.
- Prefer hints, pseudocode, or function/type signatures to guide the user.
- When showing a signature, use the project's actual language and conventions.

**Acceptable:**

```rust
async fn refresh_token(token: String) -> AuthSession;
```

**Not acceptable (unless asked):** a full implementation with all logic filled in.

If you believe a full implementation is warranted, ask first.

## Questions are read-only

- A question is a request for an answer, not for changes. If the message opens
  with "how hard would it be", "what are your thoughts", "why does", "should
  we", "is it possible", "can X and Y", or otherwise asks rather than
  instructs: answer it, and do not edit files.
- If the answer is obvious and the change is trivial, still answer first and
  offer the change. Ask before making it.

## Match ceremony to the task

- Do not spawn subagents or a multi-agent panel for work a single agent
  finished in one pass. Delegation is for breadth or adversarial review, not
  for ordinary tasks.
- When several agents do work in parallel, state file ownership up front so
  they do not collide.

## Visual and design work

- Do not edit real components first. For any non-trivial UI, layout, or copy
  change, build several distinct static mocks, publish them, report the URL,
  and stop. Wait for a pick before implementing.
- Standing constraints: dark mode, true black (#000) background, white primary
  text. Information-dense, no decorative card/pill chrome, no light-gray
  subtitle lines above sections. Minimal copy. No em dashes.
- Avoid continuously repainting CSS animations (pulse, shimmer, blur,
  spinners); they peg the GPU on high-refresh displays.

## Blast radius

- Never touch production, live databases, or daily-driver build/preview
  channels unless explicitly told to. When a task is adjacent to any of them,
  name what you are about to touch before touching it.

## Commands

- Don't run dev server commands (e.g., `cargo run server`) – assume it's already running.
- Focus on checking commands like `just check` if the project has a justfile,
  otherwise do `cargo clippy`, `uv run ruff`.

## Commits

After every discrete change (feature, fix, refactor, etc.), you **must** suggest
a commit message. You may **not** run `git commit` yourself -- the user commits
manually, unless otherwise specified.

Commit messages must follow [Conventional Commits](https://www.conventionalcommits.org/):

```gitcommit
fix(web): new threads no longer spice CPU
```

Keep changes **atomic** – one logical unit per commit. If a task spans multiple
concerns, break it into sequential steps and suggest a commit after each.

## Pull Requests

- Make sure titles follow conventions from the repo. They should be simple and easy to understand.
- PR descriptions should aim for simplicity. Open with a minimal, clear description of the problem. Follow up with how you solved it.
- **Open a draft PR, not a ready-for-review PR**.
- **Rebase onto latest `main` before opening**.
