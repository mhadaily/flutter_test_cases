import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// --- prefer-immutable-selector-value ---

// BAD: Mutable UserProfile
class MutableUserProfile {
  String name; // 🚨 Mutable field!

  MutableUserProfile(this.name);
}

// GOOD: Immutable UserProfile
@immutable
class UserProfile {
  final String name; // ✅ Final field

  const UserProfile({required this.name});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserProfile &&
          runtimeType == other.runtimeType &&
          name == other.name;

  @override
  int get hashCode => name.hashCode;
}

class UserModel extends ChangeNotifier {
  UserProfile _profile = const UserProfile(name: 'Alice');

  UserProfile get profile => _profile;

  void rename(String name) {
    _profile = UserProfile(name: name); // New instance triggers rebuild
    notifyListeners();
  }
}

// BAD: Mutable value may cause skipped or incorrect rebuilds
class SelectorBad extends StatelessWidget {
  const SelectorBad({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<UserModel?, MutableUserProfile?>(
      selector: (_, user) {
        // 💥 If UserProfile is mutable, bad things happen
        return MutableUserProfile(user?.profile.name ?? 'unknown');
      },
      builder: (_, profile, child) {
        return Text(profile?.name ?? 'unknown');
      },
    );
  }
}

// GOOD: Immutable value ensures correct rebuilds
class SelectorGood extends StatelessWidget {
  const SelectorGood({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<UserModel?, UserProfile?>(
      selector: (_, user) => user?.profile, // ✅ Immutable value
      builder: (_, profile, child) {
        return Text(profile?.name ?? 'unknown');
      },
    );
  }
}

class ImmutatableSelectorApp extends StatelessWidget {
  const ImmutatableSelectorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ChangeNotifierProvider<UserModel?>(
          create: (_) => UserModel(),
          child: Column(
            children: const [
              SelectorBad(),
              Text('Bad: Mutable (might not rebuild)'),
            ],
          ),
        ),
        ChangeNotifierProvider<UserModel?>(
          create: (_) => UserModel(),
          child: Column(
            children: const [
              SelectorGood(),
              Text('Good: Immutable (rebuilds correctly)'),
            ],
          ),
        ),
      ],
    );
  }
}
