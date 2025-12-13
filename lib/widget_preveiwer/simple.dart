import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';

class DesignSystemInput extends StatelessWidget {
  final String label;
  final String? errorText;
  final bool enabled;
  final String? helperText;

  const DesignSystemInput({
    super.key,
    required this.label,
    this.errorText,
    this.enabled = true,
    this.helperText,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      enabled: enabled,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: label,
        errorText: errorText,
        helperText: helperText,
      ),
    );
  }
}

/// Shared theme for all previews in this MultiPreview.
/// NOTE: must be a top-level *public* function because it's used in annotations.
PreviewThemeData designSystemPreviewTheme() => PreviewThemeData(
  materialLight: ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,
    colorSchemeSeed: Colors.blue,
  ),
  materialDark: ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,
    colorSchemeSeed: Colors.deepPurple,
  ),
);

// Define custom preview annotation for consistency
final class DesignSystemInputPreview extends MultiPreview {
  const DesignSystemInputPreview();

  @override
  List<Preview> get previews => const [
    Preview(
      name: 'Default - Light',
      brightness: Brightness.light,
      group: 'States',
      theme: designSystemPreviewTheme,
    ),
    Preview(
      name: 'Default - Dark',
      brightness: Brightness.dark,
      group: 'States',
      theme: designSystemPreviewTheme,
    ),
    Preview(
      name: 'With Helper - Light',
      brightness: Brightness.light,
      group: 'States',
      theme: designSystemPreviewTheme,
    ),
    Preview(
      name: 'With Helper - Dark',
      brightness: Brightness.dark,
      group: 'States',
      theme: designSystemPreviewTheme,
    ),
    Preview(
      name: 'Error - Light',
      brightness: Brightness.light,
      group: 'States',
      theme: designSystemPreviewTheme,
    ),
    Preview(
      name: 'Error - Dark',
      brightness: Brightness.dark,
      group: 'States',
      theme: designSystemPreviewTheme,
    ),
    Preview(
      name: 'Disabled - Light',
      brightness: Brightness.light,
      group: 'States',
      theme: designSystemPreviewTheme,
    ),
    Preview(
      name: 'Disabled - Dark',
      brightness: Brightness.dark,
      group: 'States',
      theme: designSystemPreviewTheme,
    ),
  ];

  @override
  List<Preview> transform() {
    final previews = super.transform();
    return previews.map((preview) {
      final builder = preview.toBuilder();
      final name = preview.name ?? '';

      if (name.contains('Helper')) {
        builder.wrapper = _helperWrapper;
      } else if (name.contains('Error')) {
        builder.wrapper = _errorWrapper;
      } else if (name.contains('Disabled')) {
        builder.wrapper = _disabledWrapper;
      } else {
        builder.wrapper = _defaultWrapper;
      }

      return builder.build();
    }).toList();
  }
}

// Wrapper functions for different states
Widget _defaultWrapper(Widget child) {
  // Previewer supplies MaterialApp + theme; we just add layout.
  return Scaffold(
    body: Padding(padding: const EdgeInsets.all(16), child: child),
  );
}

Widget _helperWrapper(Widget child) {
  return const Scaffold(
    body: Padding(
      padding: EdgeInsets.all(16),
      child: DesignSystemInput(
        label: 'Email',
        helperText: 'Enter your email address',
      ),
    ),
  );
}

Widget _errorWrapper(Widget child) {
  return const Scaffold(
    body: Padding(
      padding: EdgeInsets.all(16),
      child: DesignSystemInput(
        label: 'Email',
        errorText: 'Invalid email format',
      ),
    ),
  );
}

Widget _disabledWrapper(Widget child) {
  return const Scaffold(
    body: Padding(
      padding: EdgeInsets.all(16),
      child: DesignSystemInput(label: 'Email', enabled: false),
    ),
  );
}

// The preview
@DesignSystemInputPreview()
Widget designSystemInputPreview() {
  // Used by "Default" variants; other states override via wrapper.
  return const DesignSystemInput(label: 'Email Address');
}
