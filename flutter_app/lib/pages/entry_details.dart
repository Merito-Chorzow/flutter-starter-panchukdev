import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';

class EntryDetails extends StatelessWidget {
  const EntryDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Entry Details')),
      body: Center(
        child: ElevatedButton(
          child: const Text('Back to Entries'),
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