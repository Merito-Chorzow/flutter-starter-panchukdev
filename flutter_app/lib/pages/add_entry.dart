import 'package:flutter/material.dart';
import 'package:location/location.dart';

class LocationService {
  Location location = Location();

  Future<bool> requestPermission() async {
    final permission = await location.requestPermission();
    return permission == PermissionStatus.granted;
  }

  Future<LocationData> getCurrentLocation() async {
    final serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      final result = await location.requestService;
        if (result == true) {
          print('Service has been enabled');
        } else {
             throw Exception('GPS service not enabled');
          }
       }
    final locationData = await location.getLocation();
    return locationData;
  }
}
class AddEntry extends StatefulWidget {
  const AddEntry({super.key});

  @override
  AddEntryState createState() {
    return AddEntryState();
  }

}

class AddEntryState extends State<AddEntry> {

  String text = "Initial Text";

  void _update(locText) {
  setState(() { 
    text = locText;
   });
}
  
  TextEditingController _dateController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
      child: Column(
        
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           SizedBox(height: 50),
           TextFormField(
            decoration: InputDecoration(
              labelText: "Title",
              border: OutlineInputBorder(),
              
            ),
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the title';
              }
              return null;
            },
          ),
          SizedBox(height: 10),
          TextField(
            controller: _dateController,
            decoration: InputDecoration(
              labelText: "Date",
              prefixIcon: Icon(Icons.calendar_today),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey)
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
              ),
            ),
            readOnly: true,
            onTap: (){
              _selectDate();
            }
          ),
           SizedBox(height: 10),
          ElevatedButton(
            child: 
            Text("Provide Location"),

            onPressed: () {
              LocationService locationService = LocationService();
              locationService.requestPermission().then((granted) {
                if (granted) {
                  locationService.getCurrentLocation().then((locationData) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Location: Lat ${locationData.latitude}, Lon ${locationData.longitude}')),
                    );
                    print(locationData); 
                    _update('Lat: ${locationData.latitude}, Lon: ${locationData.longitude}');       

                  }).catchError((error) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error getting location: $error')),
                    );
                  });
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Location permission denied')),
                  );
                }
              });
            },
            ),
            SizedBox(height: 10),
            Text(text),
          
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: ElevatedButton(
              onPressed: () {
                // Validate returns true if the form is valid, or false otherwise.
                if (_formKey.currentState!.validate()) {
                  // If the form is valid, display a snackbar. In the real world,
                  // you'd often call a server or save the information in a database.
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Processing Data')),
                  );
                }
              },
              child: const Text('Submit'),
            ),
          ),
        ],
      ),
    ),
    );
  }

  Future<void> _selectDate() async {
    DateTime? _picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100)
      );

      if (_picked != null) {
        setState(() {
          _dateController.text = _picked.toString().split(" ")[0];
        });
      }
  }
}