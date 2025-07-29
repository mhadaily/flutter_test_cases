import 'package:flutter/material.dart';

class ThemeHelper {
  // This class requires a BuildContext to access theme data.
  Color getPrimaryColor(BuildContext context) {
    return Theme.of(context).colorScheme.primary;
  }
}

// The refactored class has no dependency on Flutter's context.
// It depends only on the data model (ThemeData).
class RefactoredThemeHelper {
  Color getPrimaryColor(ThemeData theme) {
    return theme.colorScheme.primary;
  }
}
