# BLoC DCM Lints Examples

This folder collects runnable examples (Bad + Good) that demonstrate the
BLoC-related DCM lint rules discussed in the article:

> Read full article:
> ["BLoC Best Practices You're Probably Missing (Road to Flutter Production-Ready State Management)"](https://dcm.dev/blog)

Use these examples to learn the lints, reproduce issues, or integrate into
AI-assisted tooling and test harnesses.

DCM MCP server integration docs: Here is how you can integrate
[DCM MCP and Dart MCP server](https://dcm.dev/docs/ide-integrations/mcp-server/)

Files (in article order):

- 01_check_is_not_closed_after_async_gap.dart — Demonstrates
  `check-is-not-closed-after-async-gap` (emit after async gap).
- 02_emit_new_bloc_state_instances.dart — Demonstrates
  `emit-new-bloc-state-instances` (emit same instance vs copyWith).
- 03_avoid_existing_instances_in_bloc_provider.dart — Demonstrates
  `avoid-existing-instances-in-bloc-provider` (provider ownership).
- 04_avoid_instantiating_in_bloc_value_provider.dart — Demonstrates
  `avoid-instantiating-in-bloc-value-provider` (value provider lifecycle).
- 05_avoid_bloc_public_methods.dart — Demonstrates `avoid-bloc-public-methods`
  (use events, not public methods).
- 06_avoid_passing_build_context_to_blocs.dart — Demonstrates
  `avoid-passing-build-context-to-blocs` (pass data, not BuildContext).
- 07_avoid_passing_bloc_to_bloc.dart — Demonstrates `avoid-passing-bloc-to-bloc`
  (use listeners or streams instead).
- 08_avoid_empty_build_when.dart — Demonstrates `avoid-empty-build-when` (use
  buildWhen to optimize rebuilds).
- 09_prefer_sealed_bloc_events.dart — Demonstrates `prefer-sealed-bloc-events`
  and `prefer-sealed-bloc-state` (Dart 3 sealed types).
- 10_prefer_immutable_bloc_events.dart — Demonstrates
  `prefer-immutable-bloc-events` (immutability of events).
- 11_prefer_multi_bloc_provider.dart — Demonstrates `prefer-multi-bloc-provider`
  (avoid nested providers).
- 12_prefer_bloc_extensions.dart — Demonstrates `prefer-bloc-extensions` (use
  context.read/watch shortcuts).
- 13_prefer_bloc_event_and_state_suffix.dart — Demonstrates
  `prefer-bloc-event-suffix` and `prefer-bloc-state-suffix` (clear naming).

Usage

- Open the examples in your editor to see the Bad vs Good code.
- The "Bad" examples intentionally trigger lints so you can test analyzer/plugin
  behavior.
- Use these files with AI-assisted tooling or the DCM MCP integration to
  generate fixes or test suggestions.

License & Attribution

Based on the article "BLoC Best Practices You're Probably Missing (Road to
Flutter Production-Ready State Management)" from dcm.dev/blog. Examples were
adapted to be runnable in this repository.
