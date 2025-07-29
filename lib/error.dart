// 1. A fake repository designed to always fail.
import 'package:flutter/material.dart';

class FakeRepository {
  Future<String> fetchData() async => throw Exception('Network error');
}

// The widget under test that depends on the repository.
class MyErrorWidget extends StatelessWidget {
  final FakeRepository repo;

  const MyErrorWidget({super.key, required this.repo});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: repo.fetchData(),
      builder: (context, snapshot) {
        // It correctly displays a Text widget when the future has an error.
        if (snapshot.hasError) {
          return const Text('Oops', key: Key('error_message'));
        }
        // Otherwise, it shows nothing.
        return const SizedBox.shrink();
      },
    );
  }
}
