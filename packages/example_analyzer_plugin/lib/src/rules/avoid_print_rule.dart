import 'package:analyzer/analysis_rule/analysis_rule.dart';
import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/error/error.dart';

/// A warning rule that detects usage of print() in production code.
/// This rule is enabled by default as a warning rule.
class AvoidPrintRule extends AnalysisRule {
  static const LintCode code = LintCode(
    'avoid_print',
    'Avoid using print() in production code.',
    correctionMessage: 'Use debugPrint() instead.',
  );

  AvoidPrintRule()
      : super(
          name: 'avoid_print',
          description: 'Avoid using print() in production code.',
        );

  @override
  LintCode get diagnosticCode => code;

  @override
  void registerNodeProcessors(
    RuleVisitorRegistry registry,
    RuleContext context,
  ) {
    var visitor = _AvoidPrintVisitor(this, context);
    registry.addMethodInvocation(this, visitor);
  }
}

class _AvoidPrintVisitor extends SimpleAstVisitor<void> {
  const _AvoidPrintVisitor(this.rule, this.context);

  final AnalysisRule rule;
  final RuleContext context;

  @override
  void visitMethodInvocation(MethodInvocation node) {
    if (node.methodName.name == 'print') {
      rule.reportAtNode(node);
    }
  }
}
