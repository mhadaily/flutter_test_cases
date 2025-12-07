# Flutter Test Cases - The Hard Parts

A comprehensive collection of advanced test cases and tools for Flutter development.

## 📝 Testing The Hard Parts For Flutter Developers

Complex test cases for Flutter covering challenging scenarios, which I have covered in [this article](https://dcm.dev/blog/2025/07/30/navigating-hard-parts-testing-flutter-developers/) 🔥

## 🔍 Custom Lint Plugin Based on Dart 3.10+ and New Analyzer API

In addition to comprehensive test cases, this repository includes a **custom analyzer plugin** demonstrating the new Dart 3.10+ analyzer plugin API. The plugin implements multiple lint rules for Flutter and Dart projects, covered in [this article about creating custom lint rules](https://dcm.dev/blog/custom-lint-plugin/) (placeholder for article).

### Features

- **3 Custom Lint Rules**:
  - `avoid_print` - Detects print() usage and suggests debugPrint()
  - `empty_container` - Identifies empty Flutter Container widgets
  - `todo_comment` - Reports TODO comments in code
- **Quick Fixes**: Automatic code fixes for applicable rules
- **Example Files**: Practical demonstrations of each rule in action
- **Best Practices**: Follows Dart package structure and modern plugin architecture

### Testing Configuration

This repository is configured to test **only the custom lint plugin** with all standard Flutter lints disabled. This allows for isolated testing of the plugin rules. The `analysis_options.yaml` is set up with:

- ✅ Custom plugin enabled
- ✅ Warning rules enabled by default (`avoid_print`, `empty_container`)
- ✅ Lint rules configurable in `diagnostics` section (`todo_comment`)
- ❌ All standard `package:flutter_lints` rules disabled for focused testing

## 📦 Project Structure

```text
├── lib/                          # Main application code
│   ├── lint_examples/            # Demonstrations of lint rules
│   └── ...
├── test/                         # Test cases
├── packages/
│   └── custom_lint_plugin/       # Custom analyzer plugin
└── analysis_options.yaml         # Analyzer configuration
```

## 🤝 Contribution

We welcome contributions! To contribute:

1. Clone the repository
2. Add your test cases or improvements
3. Ensure the CI/CD pipeline passes
4. Submit your pull request

## 📚 Resources

- [Dart Test Documentation](https://dart.dev/guides/testing)
- [Flutter Testing Guide](https://flutter.dev/testing)
- [Dart Analyzer Plugin API](https://github.com/dart-lang/sdk/tree/main/pkg/analysis_server_plugin)

---

**Happy Testing & Linting!** ✨
