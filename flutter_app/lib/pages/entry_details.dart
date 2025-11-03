import 'package:flutter/material.dart';

class EntryDetails extends StatelessWidget {
  const EntryDetails({
    super.key,
    required this.title,
    required this.description,
    required this.date,
    required this.latitude,
    required this.longitude,
  });

  final String title;
  final String description;
  final DateTime date;
  final double latitude;
  final double longitude;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Entry Details', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromARGB(255, 4, 169, 145),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(title, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Text(date.toString(), style: TextStyle(fontSize: 18, color: Colors.grey[700])),
              SizedBox(height: 8),
              Text(description, style: TextStyle(fontSize: 16)),
              SizedBox(height: 16),
              Text('Latitude: $latitude', style: TextStyle(fontSize: 18)),
              SizedBox(height: 8),
              Text('Longitude: $longitude', style: TextStyle(fontSize: 18)),
              SizedBox(height: 24),
              ElevatedButton(
                child: Text("Back"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}