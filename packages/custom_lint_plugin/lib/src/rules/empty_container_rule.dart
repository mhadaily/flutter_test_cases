import 'package:analyzer/analysis_rule/analysis_rule.dart';
import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/error/error.dart';

/// A warning rule that detects empty Container widgets in Flutter code.
/// This rule is enabled by default as a warning rule.
class EmptyContainerRule extends AnalysisRule {
  static const LintCode code = LintCode(
    'empty_container',
    'Empty Container widgets have no visual effect.',
    correctionMessage: 'Remove the empty container or add child widgets.',
  );

  EmptyContainerRule()
      : super(
          name: 'empty_container',
          description: 'Detects empty Container widgets in Flutter code.',
        );

  @override
  LintCode get diagnosticCode => code;

  @override
  void registerNodeProcessors(
    RuleVisitorRegistry registry,
    RuleContext context,
  ) {
    var visitor = _EmptyContainerVisitor(this, context);
    registry.addInstanceCreationExpression(this, visitor);
  }
}

class _EmptyContainerVisitor extends SimpleAstVisitor<void> {
  const _EmptyContainerVisitor(this.rule, this.context);

  final AnalysisRule rule;
  final RuleContext context;

  @override
  void visitInstanceCreationExpression(InstanceCreationExpression node) {
    var constructorName = node.constructorName.type.name.lexeme;
    if (constructorName == 'Container' && node.argumentList.arguments.isEmpty) {
      rule.reportAtNode(node);
    }
  }
}
