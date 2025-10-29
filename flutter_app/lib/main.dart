import 'package:flutter/material.dart';
import 'package:flutter_app/pages/list_of_entries.dart';
import 'package:flutter_app/pages/add_entry.dart';
import 'package:flutter_app/pages/settings.dart';


void main() { 
    runApp(const LocationApp());
  }

class LocationApp extends StatelessWidget {
  const LocationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Navigation(),
    );
  }
  
}

class Navigation extends StatefulWidget {
  const Navigation({super.key});
  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: const Color.fromARGB(255, 4, 169, 145),
        selectedIndex: currentPageIndex,

        destinations: const <Widget>[

          // List of cards page
          NavigationDestination(
            selectedIcon: Icon(Icons.list_outlined),
            icon: Icon(Icons.list),
            label: 'List',
            
          ),

          // Add entry page
          NavigationDestination(
            selectedIcon: Icon(Icons.add_outlined),
            icon: Icon(Icons.add),
            label: 'Add',
          ),

          // Settings page
          NavigationDestination(
            selectedIcon: (Icon(Icons.settings_outlined)),
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),

      body: <Widget>[

        /// List of cards page
        const ListOfEntries(),
        /// Add entry page
        const AddEntry(),
        /// Settings page
        const Settings(),

      ][currentPageIndex],
    );


  }
}