import 'package:analysis_server_plugin/edit/dart/correction_producer.dart';
import 'package:analysis_server_plugin/edit/dart/dart_fix_kind_priority.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer_plugin/utilities/change_builder/change_builder_core.dart';
import 'package:analyzer_plugin/utilities/fixes/fixes.dart';
import 'package:analyzer_plugin/utilities/range_factory.dart';

/// A quick fix that replaces print() with debugPrint().
class ReplacePrintWithDebugPrint extends ResolvedCorrectionProducer {
  static const _fixKind = FixKind(
    'dart.fix.replacePrintWithDebugPrint',
    DartFixKindPriority.standard,
    "Replace print() with debugPrint()",
  );

  ReplacePrintWithDebugPrint({required super.context});

  @override
  CorrectionApplicability get applicability =>
      CorrectionApplicability.singleLocation;

  @override
  FixKind get fixKind => _fixKind;

  @override
  Future<void> compute(ChangeBuilder builder) async {
    final target = node;
    if (target is MethodInvocation && target.methodName.name == 'print') {
      await builder.addDartFileEdit(file, (fileEditBuilder) {
        fileEditBuilder.addSimpleReplacement(
          range.node(target.methodName),
          'debugPrint',
        );
      });
    }
  }
}
