---
name: optimize-rust-performance
description: >-
  Diagnose, measure, and improve runtime performance in Rust applications and libraries. Use for reported slowness, high CPU or memory use, benchmark regressions, throughput or latency goals, profiling, allocation reduction, contention, async-runtime overhead, or Cargo release-profile tuning.
---
# Optimize Rust Performance

Use an evidence-first loop: reproduce, measure, profile, change one cause, and compare.

## Establish the measurement

- Identify the affected workload, metric, target hardware, acceptable tradeoff, and whether the path is CPU-, allocation-, I/O-, lock-, or latency-bound.
- Inspect `Cargo.toml`, feature flags, release profiles, architecture-specific code, existing benchmarks, and CI performance checks before changing code or dependencies.
- Reproduce with production-equivalent inputs and a release build. Keep inputs, features, environment, concurrency, and CPU power mode fixed between runs.
- Prefer an existing benchmark harness. If none exists, make the smallest representative benchmark or repeatable command necessary to measure the suspected hot path.
- Record a baseline with enough iterations to distinguish noise from a real change. Report the command, input, metric, and result.

Avoid using debug-build timings, a single wall-clock run, or synthetic microbenchmarks as proof of an end-to-end improvement.

## Find the limiting resource

Profile the measured workload before optimizing when the bottleneck is not already clear.

- Use sampling profiles for CPU hotspots and flame graphs; build with debug information when symbols are needed.
- Use allocation profiling for allocation-heavy paths; inspect allocation count and allocated bytes as well as elapsed time.
- Trace system calls, I/O waits, scheduler activity, locks, and async task behavior when CPU profiles do not explain the time.
- For tail latency, preserve request distributions and inspect p50, p95, p99, and maximum latency separately. Do not optimize an average while regressing the tail.
- Treat profiles as hypotheses. Confirm the suspected function with a focused benchmark or counter before changing it.

Choose the least intrusive tool available in the project environment. Do not add profiling crates or change production configuration solely for a one-off investigation unless that tooling will remain useful.

## Make targeted changes

Optimize in this usual order, stopping once the goal is met:

1. Replace avoidable algorithmic or data-structure costs.
2. Eliminate unnecessary work, copies, allocations, parsing, and repeated lookups in the measured path.
3. Improve data representation and locality where measurements justify it.
4. Reduce synchronization, contention, blocking, or excess task scheduling.
5. Consider parallelism only for independent work and only after measuring its overhead and scalability.
6. Tune compiler or Cargo profiles last, documenting portability, compile-time, binary-size, and debuggability tradeoffs.

Preserve semantics, ordering, error behavior, cancellation, and public API contracts. Do not introduce `unsafe`, platform-specific CPU instructions, global caches, or unbounded concurrency without a demonstrated need and an explicit safety or portability review.

## Validate the result

- Rerun the same benchmark or workload against the baseline; report absolute and relative results, including variance when available.
- Run focused correctness tests and the repository's canonical Rust check command.
- Keep a benchmark only when it represents an important, stable workload or guards a meaningful regression. Remove diagnostic-only code and logging.
- Summarize the bottleneck, evidence, change, measured impact, and remaining tradeoffs. State clearly when no reliable improvement was observed.

## Common Rust checks

- Prefer borrowing, `Cow`, buffers, iterators, and `with_capacity` only when profiling shows they remove material allocations or work.
- Check accidental quadratic loops, repeated UTF-8 validation or parsing, clone-heavy APIs, formatted-string work, lock scope, channel pressure, and blocking operations inside async tasks.
- Verify that feature selection and release settings match deployment. Treat `lto`, `codegen-units`, `panic`, `strip`, and `target-cpu` as deployment decisions, not default optimizations.
- Use `cargo bench` or the project's benchmark command for throughput and latency measurements; use `cargo test` and the project's canonical check for correctness.
