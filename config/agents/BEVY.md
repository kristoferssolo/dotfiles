# Bevy 0.19 Project Instructions

Build Bevy applications from cohesive game domains. Let each domain own the
plugin, components, resources, messages, events, observers, and systems that
implement its behavior.

## Establish Context

1. Determine whether the user wants advice, a review, or an implementation.
   Keep advice read-only and show proposed boundaries before broad moves.
2. Inspect `Cargo.toml`, the resolved Bevy version and features, the entry
   point, root plugin registration, states, schedules, and module tree.
3. Preserve established project conventions unless they cause the problem.
   These instructions target Bevy 0.19, so consult the relevant migration guide
   before applying them to another release.
4. Identify the smallest cohesive domain that owns the requested behavior.
   Avoid architecture work unrelated to the task.
5. Apply the repository's Rust conventions alongside these instructions.

## Organize by Domain

Keep small games in a few focused root modules:

```text
src/
├── main.rs       # process setup and root plugin registration
├── game.rs       # game composition and shared game states
├── player.rs     # player plugin and behavior
├── camera.rs     # camera plugin and behavior
└── ui.rs         # UI plugin and composition
```

When a domain develops distinct internal responsibilities, convert that domain
to a directory module while keeping it as a root sibling:

```text
src/
├── main.rs
├── game.rs             # game composition and shared game states
└── player/
    ├── mod.rs          # player plugin and domain API
    ├── components.rs   # player-specific ECS data
    ├── input.rs
    ├── movement.rs
    └── spawn.rs
```

- Keep `main.rs` limited to process setup, `App` construction, and root plugin
  registration. Keep gameplay systems out of it.
- Give each meaningful domain one integration point that registers its types,
  resources, schedules, systems, and dependencies.
- Keep sibling domains at the crate root. Nest a domain beneath another only
  when it is genuinely owned by and private to the parent, not merely because
  the parent composes its plugin.
- Keep systems beside the data or behavior they primarily own. Put cross-domain
  orchestration in the narrowest parent domain that owns the interaction.
- Keep containing modules private unless they are part of the crate's public
  API. Within them, expose the plugin function and only the selected types
  other domains need; keep the remaining implementation items private.
- Split a module when it contains multiple cohesive responsibilities or nears
  the repository's file-size limit. Do not split merely for symmetry.
- Within a substantial domain, use deliberate responsibility modules such as
  `components.rs`, `resources.rs`, `messages.rs`, or `observers.rs`. Create each
  only when it has cohesive contents; keep isolated types beside their behavior.
- Use a project prelude only for stable, frequently imported types. Keep domain
  exports namespaced and avoid turning the prelude into a second global API.

## Define Plugin Boundaries

- Keep third-party plugin setup, domain resources, and domain systems together.
  Removing a domain plugin should remove its integration cleanly.
- Prefer a public module-level plugin function for private and
  application-internal composition. Rely on the containing module's visibility
  to keep it out of the crate's public API:

```rust
pub fn plugin(app: &mut App) {
    // Register this module's resources, systems, and dependencies.
}
```

- Compose internal plugin functions through `App::add_plugins`. Reserve a named
  type implementing `Plugin` for public or reusable libraries, plugins that
  carry configuration, or cases where a type provides a meaningful API.
- Register ordering constraints and run conditions in the plugin that owns
  them. Export a system-set label only when another domain must order against
  it.
- Avoid a plugin, folder, or abstraction for a single short system without a
  real ownership or growth boundary.

## Model Entity Lifecycles

- Add `Name` to important root and runtime entities to improve diagnostics.
  Do not mechanically name every leaf entity.
- Prefer `StateScoped(state)` for entities owned by a state. Enable scoped
  entities with `#[states(scoped_entities)]` or the corresponding app setup.
- Scope a parent when its descendants share the same lifetime. Avoid redundant
  cleanup markers on every child.
- Use explicit cleanup systems only for lifetimes that cannot be expressed by
  state scoping or entity relationships. Co-locate setup and teardown.
- Treat `Entity` as an ephemeral world handle. Use a private, strongly typed ID
  for save data, networking, replay, or references that survive despawning.
- Keep components data-focused. Put behavior in systems, observers, and domain
  APIs rather than component methods that need broad world access.
- Use `commands.spawn` for dynamic runtime entities. Consider Bevy 0.19's
  `bsn!` scenes for declarative composition, especially UI, but do not force
  BSN onto behavior-heavy or highly dynamic spawning.

## Make Scheduling Explicit

- Bound gameplay systems in `Update` with states, run conditions, or system
  sets when they are not meant to run continuously.
- Co-locate `OnEnter`, state-gated `Update`, and `OnExit` registration so a
  state's lifecycle is visible in one place.
- Use system sets for coarse-grained phases and cross-domain ordering. Configure
  their order once near app or domain composition.
- Use `.before()`, `.after()`, or `.chain()` only for real same-frame data
  dependencies. Preserve Bevy's parallelism when ordering is unnecessary.
- Document intentional one-frame latency. Do not rely on incidental scheduler
  order.
- Allow genuine background behavior, such as music or diagnostics, to span
  states rather than adding artificial state checks.

## Choose the Right Communication Primitive

- Use direct component access or a resource for behavior with a clear owner and
  simple coupling.
- Use a Bevy 0.19 `Message` for buffered, pull-based, potentially multi-reader
  communication. Use `MessageWriter::write` and `MessageReader::read`.
- Order message producers before consumers when same-frame delivery matters.
  Use `on_message::<M>` for systems that only need a run condition; prefer
  `PopulatedMessageReader<M>` when the consuming system reads the messages.
- Use an `Event` with observers for immediate push-based reactions. Choose
  entity-targeted events when the reaction belongs to a specific entity.
- Keep message and event payloads domain-specific and strongly typed. Include
  only the data consumers need.
- Do not create a global bus or long event chain to hide ordinary dependencies.
  Keep simple local operations in one system when splitting adds no value.

## Query Deliberately

- Request only the components a system needs and use filters to express its
  invariants.
- Use `Single<D, F>` when exactly one match is required and
  `Option<Single<D, F>>` when zero or one match is valid.
- When using `Query::single` or `single_mut`, handle `QuerySingleError`
  intentionally. Avoid helper macros that silently discard violated
  cardinality assumptions.
- Use change detection and run conditions to skip unnecessary work, but do not
  add them mechanically when the system is already cheap.
- Keep command deferral in mind when reasoning about visibility between systems.
  Add an explicit synchronization point only when the same-frame behavior
  requires it.

## Treat Performance as Evidence-Driven

- Preserve scheduler parallelism by avoiding unnecessary mutable access and
  ordering constraints.
- Measure before changing ECS layout, parallelizing queries, or adding caches.
  Optimize the demonstrated bottleneck rather than speculative hot paths.
- Start development profiles with a small optimization level for the game crate
  and a higher level for dependencies, following Bevy's current setup guide.
- Keep `bevy/dynamic_linking` behind an explicit development feature. Never ship
  a distribution build with it enabled.
- Consider thin LTO and one codegen unit for distribution after measuring the
  build-time tradeoff. Keep useful error logging unless size or runtime evidence
  justifies compiling it out.
- Prefer a fast FOSS linker supported by the target platform when link time is
  the development bottleneck.

## Avoid Structural Traps

- Do not create top-level `components`, `systems`, `resources`, or `plugins`
  directories. They scatter one feature across the tree.
- Do not create `utils`, `helpers`, `common`, or `shared` as default dumping
  grounds. Name the responsibility or keep the code with its domain.
- Do not force one hierarchy onto gameplay, rendering, UI, and editor tooling
  when their ownership boundaries differ.
- Do not centralize every system registration in one giant plugin.
- Do not serialize or network raw `Entity` values as stable identity.
- Do not reproduce pre-0.17 `EventReader` and `EventWriter` patterns for
  buffered communication. Bevy 0.19 calls those values messages.

## Validate Changes

- Check module declarations, visibility, imports, plugin registration, state
  transitions, system ordering, and feature gates after moving code.
- Prefer focused `App` or `World` tests that exercise the relevant schedule or
  state transition. Avoid initializing rendering for logic-only tests.
- Run `just check` when provided. Otherwise run the repository's configured
  Bevy lint command or `cargo clippy --all-targets --all-features`.
- Do not start the game or a development server unless explicitly requested.
