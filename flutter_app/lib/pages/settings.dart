import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Center(
        child: ElevatedButton(
          child: const Text('Settings page'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (context) => const LocationApp(),
              ),
            );
          },
        ),
      ),
    );
  }
}