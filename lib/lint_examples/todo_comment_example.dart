// Example file demonstrating the todo_comment rule
//
// This rule detects TODO comments in the code.
// This is a lint rule (disabled by default) and must be explicitly enabled.

class TodoCommentExamples {
  // TODO: Implement this method
  void pendingImplementation() {
    // Method body to be implemented
  }

  // TODO: Refactor this logic
  void complexMethod() {
    // Some complex logic here
    final result = calculate();
    process(result);
  }

  // TODO: Add error handling
  int calculate() {
    return 42;
  }

  void process(int value) {
    // TODO: Validate input
    print(value);
  }

  // TODO Fix bug in production
  void buggyMethod() {
    // Known issue
  }

  /* TODO: Multi-line comment
     This needs to be addressed
     in the next sprint
  */
  void futureWork() {
    // Placeholder
  }

  // This is a regular comment (will NOT trigger warning)
  void regularComment() {
    // Just a normal comment
  }

  /// Documentation comment (will NOT trigger warning)
  /// Even if it mentions tasks
  void documentedMethod() {
    // Implementation
  }
}

// TODO: Create unit tests for this class
class NeedsTests {
  void method1() {}
  void method2() {}
}

// TODO Refactor entire file structure
void globalTodoExample() {
  // TODO: Optimize performance
  for (var i = 0; i < 1000; i++) {
    // Processing
  }
}
