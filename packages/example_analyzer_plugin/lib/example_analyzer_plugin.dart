import 'package:analysis_server_plugin/plugin.dart';
import 'package:analysis_server_plugin/registry.dart';

import 'src/fixes/replace_print_with_debug_print.dart';
import 'src/rules/avoid_print_rule.dart';
import 'src/rules/empty_container_rule.dart';
import 'src/rules/todo_comment_rule.dart';

/// Main plugin class that registers all custom lint rules and fixes.
class CustomAnalysisPlugin extends Plugin {
  @override
  String get name => 'Custom Analysis Plugin';

  @override
  void register(PluginRegistry registry) {
    // Register warning rules (enabled by default)
    registry.registerWarningRule(AvoidPrintRule());
    registry.registerWarningRule(EmptyContainerRule());

    // Register lint rules (disabled by default, must be explicitly enabled)
    registry.registerLintRule(TodoCommentRule());

    // Register quick fixes
    registry.registerFixForRule(
      AvoidPrintRule.code,
      ReplacePrintWithDebugPrint.new,
    );
  }
}

// Top-level plugin instance required for analyzer to load
final plugin = CustomAnalysisPlugin();
