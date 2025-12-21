# Provider DCM Lints Examples

This folder collects runnable examples (Bad + Good) that demonstrate the
Provider-related DCM lint rules discussed in the article:

> Read full article:
> ["Flutter Provider Best Practices You're Probably Missing (Road to Flutter Production-Ready State Management)"](https://dcm.dev/blog)

Use these examples to learn the lints, reproduce issues, or integrate into
AI-assisted tooling and test harnesses.

DCM MCP server integration docs: Here is how you can integrate
[DCM MCP and Dart MCP server](https://dcm.dev/docs/ide-integrations/mcp-server/)

Files (in article order):

- 01_avoid_instantiating_in_value_provider.dart — Demonstrates
  `avoid-instantiating-in-value-provider` (value constructor lifecycle).
- 02_dispose_providers.dart — Demonstrates `dispose-providers` (cleanup for
  owned resources).
- 03_avoid_read_inside_build.dart — Demonstrates `avoid-read-inside-build`
  (subscribe when building UI).
- 04_avoid_watch_outside_build.dart — Demonstrates `avoid-watch-outside-build`
  (avoid subscriptions in callbacks).
- 05_prefer_immutable_selector_value.dart — Demonstrates
  `prefer-immutable-selector-value` (selector outputs should be immutable).
- 06_prefer_nullable_provider_types.dart — Demonstrates
  `prefer-nullable-provider-types` (defensive access for optional providers).
- 07_prefer_multi_provider.dart — Demonstrates `prefer-multi-provider` (flatten
  provider trees).
- 08_prefer_provider_extensions.dart — Demonstrates `prefer-provider-extensions`
  (use context.read/watch/select shortcuts).

Usage

- Open the examples in your editor to see the Bad vs Good code.
- The "Bad" examples intentionally trigger lints so you can test analyzer/plugin
  behavior.
- Use these files with AI-assisted tooling or the DCM MCP integration to
  generate fixes or test suggestions.

License & Attribution

Based on the article "Flutter Provider Best Practices You're Probably Missing
(Road to Flutter Production-Ready State Management)" from dcm.dev/blog. Examples
were adapted to be runnable in this repository.
