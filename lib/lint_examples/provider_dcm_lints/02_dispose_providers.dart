import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// --- dispose-providers ---
class Database {
  void open() {}
  void close() {}
}

class DatabaseService {
  final Database _db;

  DatabaseService() : _db = Database() {
    _db.open();
  }

  void dispose() {
    _db.close(); // This cleanup never happens without dispose callback!
  }
}

// BAD: dispose() is never called
class MyAppBad extends StatelessWidget {
  const MyAppBad({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => DatabaseService(),
      // 💥 No dispose callback! Database connection leaked!
      child: const DatabaseConsumer(),
    );
  }
}

// GOOD: dispose() is called on unmount
class MyAppGood extends StatelessWidget {
  const MyAppGood({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => DatabaseService(),
      dispose: (_, service) => service.dispose(), // ✅ Cleanup happens
      child: const DatabaseConsumer(),
    );
  }
}

class DatabaseConsumer extends StatelessWidget {
  const DatabaseConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    final db = context.watch<DatabaseService?>();
    return Text(db != null ? 'Database Service Created' : 'No Service');
  }
}
