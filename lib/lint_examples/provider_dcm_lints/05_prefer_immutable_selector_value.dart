import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// --- prefer-immutable-selector-value ---

class MutableUserProfile {
  MutableUserProfile(this.name);
  String name; // Mutable field: mutating keeps the same reference
}

class ImmutableUserProfile {
  const ImmutableUserProfile({required this.name});
  final String name;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is ImmutableUserProfile && other.name == name);
  }

  @override
  int get hashCode => name.hashCode;
}

class MutableUserModel extends ChangeNotifier {
  MutableUserProfile _profile = MutableUserProfile('Alice');
  MutableUserProfile get profile => _profile;

  void rename(String name) {
    _profile.name = name; // Same instance, selector sees no change
    notifyListeners();
  }
}

class ImmutableUserModel extends ChangeNotifier {
  ImmutableUserProfile _profile = const ImmutableUserProfile(name: 'Alice');
  ImmutableUserProfile get profile => _profile;

  void rename(String name) {
    _profile = ImmutableUserProfile(
      name: name,
    ); // New instance triggers rebuild
    notifyListeners();
  }
}

class ProfileViewBad extends StatelessWidget {
  const ProfileViewBad({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Selector<MutableUserModel?, MutableUserProfile?>(
          selector: (_, user) => user?.profile, // Mutable value
          builder: (_, profile, __) =>
              Text('Name: ${profile?.name ?? 'unknown'}'),
        ),
        ElevatedButton(
          onPressed: () => context.read<MutableUserModel?>()?.rename('Bob'),
          child: const Text('Rename (no rebuild)'),
        ),
      ],
    );
  }
}

class ProfileViewGood extends StatelessWidget {
  const ProfileViewGood({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Selector<ImmutableUserModel?, ImmutableUserProfile?>(
          selector: (_, user) => user?.profile, // Immutable value
          builder: (_, profile, __) =>
              Text('Name: ${profile?.name ?? 'unknown'}'),
        ),
        ElevatedButton(
          onPressed: () => context.read<ImmutableUserModel?>()?.rename('Bob'),
          child: const Text('Rename (rebuilds)'),
        ),
      ],
    );
  }
}

class ImmutableSelectorApp extends StatelessWidget {
  const ImmutableSelectorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ChangeNotifierProvider<MutableUserModel?>(
          create: (_) => MutableUserModel(),
          child: const ProfileViewBad(),
        ),
        ChangeNotifierProvider<ImmutableUserModel?>(
          create: (_) => ImmutableUserModel(),
          child: const ProfileViewGood(),
        ),
      ],
    );
  }
}
