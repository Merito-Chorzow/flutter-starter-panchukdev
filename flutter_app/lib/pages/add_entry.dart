import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';

class AddEntry extends StatelessWidget {
  const AddEntry({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Entry')),
      body: Center(
        child: ElevatedButton(
          child: const Text('Add entry page'),
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