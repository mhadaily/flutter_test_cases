# Flutter Test Cases - The Hard Parts

A comprehensive collection of complex Flutter testing scenarios that developers often struggle with. These test cases demonstrate solutions to the most challenging aspects of Flutter testing, originally covered in [this article](https://dcm.dev/blog/2025/07/30/navigating-hard-parts-testing-flutter-developers/) 🔥

## Why This Repository?

Flutter testing can be straightforward for simple widgets, but real-world applications present complex challenges that aren't well documented. This repository serves as a practical reference for:

- **Developers** learning to test complex Flutter scenarios
- **Teams** establishing testing best practices
- **Projects** needing examples of production-grade test implementations

## Test Patterns Covered

### 🕐 Time & Async Operations
**Files:** `edge_timer_test.dart`, `microtask_timer_test.dart`, `infinite_timer_test.dart`, `time_test.dart`, `runasync_test.dart`

Testing time-dependent code without waiting for real time to pass. Examples include:
- Handling timezone changes and DST transitions
- Testing timer callbacks and periodic operations
- Controlling async execution with `FakeAsync`
- Managing microtasks and event loops

### 🔌 Dependency Injection & Mocking
**Files:** `album_test.dart`, `connectivity_widget_test.dart`

Isolating components from external dependencies:
- Mocking HTTP clients for network calls
- Creating test doubles for platform-specific plugins
- Using Mockito with code generation
- Injecting services into widgets for testability

### 📱 Responsive & Context-Dependent UI
**Files:** `responsive_test.dart`, `responsive2_test.dart`

Testing widgets that adapt to different contexts:
- Simulating different screen sizes with `MediaQuery`
- Testing responsive breakpoints
- Verifying layout changes across device types
- Handling context-dependent logic

### ⚠️ Error Handling & Edge Cases
**Files:** `error_test.dart`, `binding_test.dart`

Ensuring robust error handling:
- Testing exception scenarios
- Verifying error UI states
- Handling initialization failures
- Testing fallback behaviors

### 🧭 Navigation & Routing
**Files:** `navigation_test.dart`, `navigator_observer_test.dart`

Testing navigation flows:
- Verifying route transitions
- Using `NavigatorObserver` for navigation tracking
- Testing deep linking scenarios
- Handling navigation state

### 🎨 Custom Rendering & Painting
**Files:** `custompainter_test.dart`, `fade_test.dart`

Testing custom visual components:
- Verifying custom painter output
- Testing animations and transitions
- Using `canvas_test` for painting verification
- Testing visual effects

### 🎨 Theme & Styling
**Files:** `theme_test.dart`

Testing theme-dependent behavior:
- Verifying theme data extraction
- Testing dark/light mode switching
- Color and style inheritance

## Getting Started

### Prerequisites
```bash
flutter --version  # Flutter 3.8.1 or higher
```

### Installation
```bash
# Clone the repository
git clone https://github.com/yourusername/flutter_test_cases.git
cd flutter_test_cases

# Install dependencies
flutter pub get

# Generate mock files
dart run build_runner build --delete-conflicting-outputs
```

### Running Tests
```bash
# Run all tests
flutter test

# Run specific test file
flutter test test/album_test.dart

# Run with coverage
flutter test --coverage
```

## Contributing

We welcome contributions! To add a new test case:

1. Fork the repository
2. Create a test file in `/test` following the naming convention `*_test.dart`
3. If using mocks, add `@GenerateMocks` annotation and regenerate mocks
4. Ensure all tests pass
5. Submit a pull request with a description of the testing scenario

### Contribution Guidelines
- Each test should demonstrate a specific "hard part" of Flutter testing
- Include comments explaining the challenge and solution
- Follow existing code style and patterns
- Update this README if adding a new category of tests

## Test Dependencies

Key packages used for testing:
- `flutter_test`: Core testing framework
- `mockito`: Mock generation and stubbing
- `fake_async`: Time control in tests
- `canvas_test`: Custom painter testing
- `timezone`: Timezone-specific testing
- `clock`: Time abstraction

## Resources

- [Flutter Testing Documentation](https://docs.flutter.dev/testing)
- [Mockito Package](https://pub.dev/packages/mockito)
- [Original Article](https://dcm.dev/blog/2025/07/30/navigating-hard-parts-testing-flutter-developers/)

---

## For AI Agents and LLMs

This repository contains Flutter test examples for complex scenarios. Each test file demonstrates specific testing patterns:

**Testing Patterns Index:**
- Time manipulation: Use `FakeAsync` and `tester.pump()` to control time flow
- HTTP mocking: Use `MockClient` from mockito with `@GenerateMocks([http.Client])`
- Widget testing with DI: Inject mock services through constructor parameters
- Responsive testing: Wrap widgets with `MediaQuery` to simulate screen sizes
- Navigation testing: Use `NavigatorObserver` to track navigation events
- Custom painter testing: Use `canvas_test` package for painting verification
- Error state testing: Create mocks that throw exceptions to test error handling

**Key Testing Utilities:**
- `testWidgets()`: For widget testing with `WidgetTester`
- `test()`: For unit testing non-widget code
- `group()`: For organizing related tests
- `setUp()/tearDown()`: For test initialization and cleanup
- `when().thenAnswer()`: For stubbing mock behavior
- `verify()`: For verifying mock interactions

**Common Testing Patterns in This Repository:**
1. Always generate mocks with `dart run build_runner build --delete-conflicting-outputs`
2. Use dependency injection to make widgets testable
3. Control async operations with `FakeAsync` for deterministic tests
4. Test both success and failure scenarios
5. Use `pumpWidget()` to render widgets and `pump()` to trigger rebuilds

Each test file is self-contained and demonstrates a complete testing scenario with proper setup, execution, and verification phases. 
