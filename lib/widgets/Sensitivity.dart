/*
SensitiveContent is a widget that marks a part of your UI as containing sensitive information. Its purpose is to signal to the underlying operating system (currently Android 15+ only) that the screen should be blacked out during screen sharing or screen recording to protect user privacy.

Think of it as the digital equivalent of covering a document when someone is looking over your shoulder. If your app displays passwords, financial details, or personal messages, you can wrap that content in this widget to prevent it from being accidentally exposed during a screen capture session.

When to Use It 🧐
You should use SensitiveContent on pages or widgets that display private user data. The most common use cases are:

Login Screens: To hide password or OTP (One-Time Password) fields.

Financial Apps: For pages showing bank account balances, credit card numbers, or transaction histories.

Healthcare Apps: To protect patient data or medical records.

Messaging Apps: For pages displaying private conversations.

When any SensitiveContent widget on the screen is active, the entire screen is obscured during media projection. This means you don't need to wrap every single sensitive widget; wrapping the parent page is often enough.

Important Note: This widget currently only works on Android 15 (API 35) and newer. On older Android versions and other platforms like iOS, it has no effect.

*/

import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Required for ContentSensitivity

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SensitiveContentExample(),
    );
  }
}

class SensitiveContentExample extends StatefulWidget {
  const SensitiveContentExample({super.key});

  @override
  State<SensitiveContentExample> createState() =>
      _SensitiveContentExampleState();
}

class _SensitiveContentExampleState extends State<SensitiveContentExample> {
  bool _isSecretVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SensitiveContent Demo')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'This is public information that can always be seen.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _isSecretVisible = !_isSecretVisible;
                  });
                },
                child: Text(_isSecretVisible ? 'Hide Secret' : 'Show Secret'),
              ),
              const SizedBox(height: 30),

              // This is the widget that conditionally displays the sensitive info.
              if (_isSecretVisible)
                // The SensitiveContent widget wraps our secret data.
                SensitiveContent(
                  // We mark the content as 'sensitive'.
                  sensitivity: ContentSensitivity.sensitive,
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.red[100],
                      border: Border.all(color: Colors.red),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Column(
                      children: [
                        Text(
                          'SECRET CODE:',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '123-456-789',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
