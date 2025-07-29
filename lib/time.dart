import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Progress App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ProgressScreen(),
    );
  }
}

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Loading Progress')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text('Fetching data...', style: TextStyle(fontSize: 18)),
              const SizedBox(height: 20),
              DelayedProgressWidget(),
              const SizedBox(height: 10),
              const Text(
                'Please wait',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DelayedProgressWidget extends StatefulWidget {
  const DelayedProgressWidget({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _DelayedProgressWidgetState createState() => _DelayedProgressWidgetState();
}

class _DelayedProgressWidgetState extends State<DelayedProgressWidget> {
  double progress = 0.0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      setState(() {
        progress += 1 / 3;
        if (progress > 1.0) {
          progress = 1.0; // Cap progress at 1.0
          timer.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      value: progress,
      minHeight: 10.0,
      backgroundColor: Colors.grey[300],
      valueColor: const AlwaysStoppedAnimation<Color>(Colors.blueAccent),
    );
  }
}
