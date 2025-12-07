// Example file demonstrating the avoid_print rule
//
// This rule detects usage of print() and suggests using debugPrint() instead.
// The rule provides a quick fix to automatically replace print() with debugPrint().

void examplePrintUsage() {
  // This will trigger the avoid_print warning
  print('Hello, World!');

  // Multiple print statements
  print('Debug message 1');
  print('Debug message 2');

  // Print with variables
  final name = 'Flutter';
  print('Welcome to $name');

  // Print with complex expressions
  print('Result: ${calculateSum(5, 10)}');
}

int calculateSum(int a, int b) {
  final result = a + b;
  print('Calculating sum: $a + $b = $result');
  return result;
}

void logMessage(String message) {
  // This should also be flagged
  print('[LOG] $message');
}

// Correct usage (will not trigger the rule)
void correctDebugPrintUsage() {
  debugPrint('This is the correct way to log in Flutter');
  debugPrint('No warning for debugPrint');
}

// Helper function to demonstrate
void debugPrint(String message) {
  // Placeholder implementation
}

