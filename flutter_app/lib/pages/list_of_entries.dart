import 'package:flutter/material.dart';
import 'package:flutter_app/entry.dart';
import 'package:flutter_app/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_app/pages/entry_details.dart';


class ListOfEntries extends StatefulWidget {
  @override
  _ListOfEntriesState createState() => _ListOfEntriesState();
}

class _ListOfEntriesState extends State<ListOfEntries> {
  List<Entry> entries = [];

  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _latitudeController = TextEditingController();
  final _longitudeController = TextEditingController();
  final _dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getEntries();
  }

  Future<void> _getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Location services are disabled. Please enable them.')),
      );
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Location permissions are denied')),
        );
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Location permissions are permanently denied')),
      );
      return;
    }

    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _latitudeController.text = position.latitude.toString();
      _longitudeController.text = position.longitude.toString();
    });
  }

  Future<void> _addEntry() async {
    if (_titleController.text.isNotEmpty &&
        _descriptionController.text.isNotEmpty &&
        _latitudeController.text.isNotEmpty &&
        _longitudeController.text.isNotEmpty &&
        _dateController.text.isNotEmpty) {
      Entry entry = Entry(
        id: DateTime.timestamp().toString(),
        title: _titleController.text,
        description: _descriptionController.text,
        date: _dateController.text,
        latitude: _latitudeController.text,
        longitude: _longitudeController.text,
      );

      String msg = await Services().addEntry(entry);

      if (msg.contains("Error:")) {
        print(msg);
      } else {
        setState(() {
          entries.add(entry);
        });
      }

      Navigator.of(context).pop();
      _titleController.clear();
      _descriptionController.clear();
      _latitudeController.clear();
      _longitudeController.clear();
      _dateController.clear();
    }
  }

  void _showAddEntryDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add New Entry'),
          content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            // height: MediaQuery.of(context).size.height * 0.9,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                    controller: _titleController,
                    decoration: InputDecoration(labelText: "Title"),
                  ),
                  TextField(
                    controller: _descriptionController,
                    decoration: InputDecoration(labelText: "Description"),
                  ),
                  TextField(
                    controller: _dateController,
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: "Date",
                      suffixIcon: Icon(Icons.calendar_today),
                    ),
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      );
                      if (pickedDate != null) {
                        setState(() {
                          _dateController.text =
                              pickedDate.toString().split(" ")[0];
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: ElevatedButton.icon(
                      onPressed: _getLocation,
                      icon: Icon(Icons.my_location),
                      label: Text("Provide Location"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 4, 169, 145),
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _latitudeController,
                    decoration: InputDecoration(labelText: "Latitude"),
                    keyboardType: TextInputType.number,
                  ),
                  TextField(
                    controller: _longitudeController,
                    decoration: InputDecoration(labelText: "Longitude"),
                    keyboardType: TextInputType.number,
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: _addEntry,
              child: Text("Add Entry"),
            ),
          ],
        );
      },
    );
  }

  Future<void> getEntries() async {
    entries = await Services().getEntries();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Geo Journal",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 4, 169, 145),
      ),
      body: ListView.builder(
        itemCount: entries.length,
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.all(5),
            margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7.5),
              border: Border.all(color: Colors.black, width: 1),
            ),
            child: ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EntryDetails(
                      title: entries[index].title,
                      date: DateTime.tryParse(entries[index].date) ?? DateTime.now(),
                      description: entries[index].description,
                      latitude: double.tryParse(entries[index].latitude) ?? 0.0,
                      longitude: double.tryParse(entries[index].longitude) ?? 0.0,
                    ),
                  ),
                );
              },
              title: Text(entries[index].title,
                  style: TextStyle(fontSize: 18)),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Date: ${entries[index].date}",
                      style: TextStyle(fontSize: 16)),
                  Text("Lat: ${entries[index].latitude}",
                      style: TextStyle(fontSize: 16)),
                  Text("Lon: ${entries[index].longitude}",
                      style: TextStyle(fontSize: 16)),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddEntryDialog,
        backgroundColor: const Color.fromARGB(255, 4, 169, 145),
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}