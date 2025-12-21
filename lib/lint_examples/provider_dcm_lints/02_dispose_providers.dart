import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// --- dispose-providers ---

// BAD EXAMPLE
class BadDatabaseScope extends StatelessWidget {
  const BadDatabaseScope({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider<DatabaseService>(
      // 💥 No dispose callback, connection stays open
      create: (_) => DatabaseService(),
      child: const DatabaseConsumer(),
    );
  }
}

// GOOD EXAMPLE
class GoodDatabaseScope extends StatelessWidget {
  const GoodDatabaseScope({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider<DatabaseService>(
      create: (_) => DatabaseService(),
      dispose: (_, service) => service.dispose(),
      child: const DatabaseConsumer(),
    );
  }
}

// ---------------------------------------------------------------------------
// Supporting types
// ---------------------------------------------------------------------------

class DatabaseConsumer extends StatelessWidget {
  const DatabaseConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    final db = context.watch<DatabaseService?>();
    return Text((db?.isOpen ?? false) ? 'Connected' : 'Closed');
  }
}

class DatabaseService {
  bool _open = true;
  bool get isOpen => _open;

  void query(String _) {}

  void dispose() {
    _open = false;
  }
}
