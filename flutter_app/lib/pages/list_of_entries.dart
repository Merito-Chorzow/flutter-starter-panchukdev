import 'package:flutter/material.dart';
import 'package:flutter_app/pages/entry_details.dart';

class ListOfEntries extends StatelessWidget {
  const ListOfEntries({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Card(
                child: ListTile(
                  leading: Icon(Icons.location_on),
                  title: Text('Title'),
                  subtitle: Text('Location'),
                  trailing: Text("Date"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const EntryDetails()),
                    );
                  },
                ),
              ),
            ],
          ),
        );
    } 
}