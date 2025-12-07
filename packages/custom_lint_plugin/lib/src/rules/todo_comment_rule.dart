import 'package:analyzer/analysis_rule/analysis_rule.dart';
import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/token.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/error/error.dart';

/// A lint rule that reports TODO comments in the code.
/// This rule is disabled by default and must be explicitly enabled.
class TodoCommentRule extends AnalysisRule {
  static const LintCode code = LintCode(
    'todo_comment',
    'Avoid TODO comments in code.',
    correctionMessage: 'Consider resolving or removing TODO comments.',
  );

  TodoCommentRule()
      : super(
          name: 'todo_comment',
          description: 'Reports TODO comments in the Dart code.',
        );

  @override
  LintCode get diagnosticCode => code;

  @override
  void registerNodeProcessors(
    RuleVisitorRegistry registry,
    RuleContext context,
  ) {
    var visitor = _TodoCommentVisitor(this, context);
    registry.addCompilationUnit(this, visitor);
  }
}

class _TodoCommentVisitor extends SimpleAstVisitor<void> {
  const _TodoCommentVisitor(this.rule, this.context);

  final AnalysisRule rule;
  final RuleContext context;

  @override
  void visitCompilationUnit(CompilationUnit unit) {
    for (final token
        in unit.beginToken.toListWithCommentsAndNext()) {
      if (token.type == TokenType.SINGLE_LINE_COMMENT ||
          token.type == TokenType.MULTI_LINE_COMMENT) {
        if (token.lexeme.contains('TODO')) {
          rule.reportAtOffset(
            token.offset,
            token.length,
          );
        }
      }
    }
  }
}

extension on Token {
  List<Token> toListWithCommentsAndNext() {
    final tokens = <Token>[];
    Token? current = this;
    while (current != null) {
      // Add preceding comments
      Token? comment = current.precedingComments;
      while (comment != null) {
        tokens.add(comment);
        comment = comment.next;
      }
      // Add the token itself
      tokens.add(current);
      if (current.type == TokenType.EOF) break;
      current = current.next;
    }
    return tokens;
  }
}
