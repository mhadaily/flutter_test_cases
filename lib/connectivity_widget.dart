import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'connectivity_service.dart';

class ConnectivityBanner extends StatelessWidget {
  final ConnectivityService connectivityService;

  const ConnectivityBanner({super.key, required this.connectivityService});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ConnectivityResult>>(
      future: connectivityService.checkConnectivity(),
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const SizedBox.shrink(); // Show nothing while loading or if empty
        }

        // Check if the list contains 'none'.
        final isConnected = !snapshot.data!.contains(ConnectivityResult.none);

        return Material(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            color: isConnected ? Colors.green : Colors.red,
            child: Center(
              child: Text(
                isConnected ? 'Online' : 'Offline',
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        );
      },
    );
  }
}
