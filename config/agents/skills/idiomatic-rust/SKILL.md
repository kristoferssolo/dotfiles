---
name: idiomatic-rust
description: >-
  Write, refactor, and review Rust code using idiomatic language patterns and repository conventions. Use for Rust source files, Cargo projects, API and type design, ownership, errors, modules, tests, async code, macros, or Clippy findings.
---
# Write Idiomatic Rust

## Establish context

- Inspect `Cargo.toml`, the toolchain and lint configuration, relevant modules,
  nearby call sites, and existing tests before proposing or making changes.
- Treat repository conventions and existing public APIs as authoritative. Use
  the preferences below when the repository has no stronger convention.
- Keep the change scoped. Preserve behavior and public API compatibility unless
  the task explicitly requires changing them.

## Design with the language

- Prefer standard-library types, traits, and language features over custom
  abstractions. Consider `From`, `TryFrom`, `FromStr`, `Iterator`,
  `IntoIterator`, `AsRef`, `Borrow`, `Default`, and the operator traits when
  their semantics match the domain.
- Model invariants with enums, newtypes, constructors, and visibility. Make
  invalid states difficult or impossible to represent without introducing
  types that add no meaningful guarantee.
- Use generics, associated types, and lifetimes when they make relationships
  clearer or remove real duplication. Do not generalize for hypothetical reuse.
- Prefer borrowing over cloning and allocation. Accept borrowed forms when the
  caller should retain ownership, and return owned values when ownership must
  cross the API boundary.
- Prefer iterator adapters when they make the data flow clearer. Use direct
  control flow when an iterator chain would hide mutation, error handling, or
  early exits.
- Use macros only when they remove meaningful repetition while keeping errors
  and generated behavior understandable.
- Use `strum` derive macros for repetitive enum behavior when appropriate,
  especially parsing, display, iteration, and string metadata. Do not add
  `strum` for trivial enums or when a standard trait implementation is clearer.
- Avoid adding dependencies when the standard library or an existing dependency
  handles the requirement simply.

## Handle errors deliberately

- Define typed, domain-specific errors for library and internal boundaries.
  Preserve source errors and useful context instead of converting failures into
  strings.
- Use the repository's established error-reporting approach. In binaries,
  prefer `miette` or `color-eyre` at the outermost application boundary when no
  project convention exists.
- Avoid `unwrap` and `expect`. Use them only for a locally evident invariant
  that cannot fail in valid execution, and make that invariant clear.

## Organize code predictably

- Import commonly used types and traits with `use` instead of repeating fully
  qualified paths. Retain module qualification when it prevents ambiguity.
- Keep unit tests in a `tests` submodule at the end of the source file. Reserve
  top-level `tests/` for integration tests.
- Introduce a prelude only when the same coherent imports recur across several
  modules. Do not create one as speculative organization.
- Keep each hand-written Rust source file at or below 500 lines. Before a file
  reaches that limit, separate cohesive responsibilities into focused modules.
  Split along domain and ownership boundaries rather than moving arbitrary
  chunks solely to reduce the line count.
- Keep functions and modules focused around a single responsibility.
- Write comments for invariants, non-obvious tradeoffs, safety requirements,
  and public usage. Keep them synchronized with the code.

## Write focused tests

- Test observable behavior, edge cases, and meaningful invariants. Avoid tests
  that merely mirror implementation details.
- In module-level tests, use `use super::*;` unless a narrower import is required
  to avoid a real conflict.
- Prefer `claims` macros such as `assert_ok!`, `assert_ok_eq!`, `assert_err!`,
  `assert_some!`, and `assert_none!` over unwrapping or comparing nested
  `Result` and `Option` values directly.
- Use descriptive test names without a redundant `test_` prefix.

## Validate the result

- Run the repository's canonical check command when one exists, preferring a
  `just` recipe or documented project command.
- Otherwise, run the relevant subset of formatting, Clippy, and tests. Treat
  Clippy's `pedantic` and `nursery` lints as enabled, and do not silence a lint
  without a specific justification.
- Do not use `cargo run` or a development server as a substitute for checks.
- Report the exact commands and outcomes. Do not claim the code is fixed or
  complete when relevant validation was not run or did not pass.
