# Custom Lint Plugin

A custom analyzer plugin for Dart and Flutter projects with built-in lint rules and quick fixes.

## Features

This plugin provides the following rules:

### Warning Rules (Enabled by Default)

- **avoid_print**: Detects usage of `print()` and suggests using `debugPrint()` instead
- **empty_container**: Detects empty Flutter Container widgets

### Lint Rules (Disabled by Default)

- **todo_comment**: Reports TODO comments in the code

## Installation

Add the plugin to your `analysis_options.yaml`:

```yaml
plugins:
  custom_lint_plugin:
    path: packages/custom_lint_plugin
    diagnostics:
      # Enable lint rules explicitly (warning rules are enabled by default)
      todo_comment: true
```

## Usage

Once configured, the plugin will automatically analyze your Dart/Flutter code and provide warnings and quick fixes in your IDE.
