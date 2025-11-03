import 'dart:convert';

import 'package:http/http.dart' as http;

import 'entry.dart';

class Services {

  String baseUrl = "http://localhost:50764/api/entries";

//Get Entries
  Future<List<Entry>> getEntries() async{
    try {

      final response = await  http.get(Uri.parse('$baseUrl/get'));

      if(response.statusCode == 200 || response.statusCode == 201) {
        var data = jsonDecode(response.body) as List<dynamic>;

        List<Entry> list = data.map((data) => Entry.fromJson(data)).toList();

        return list;
      } else {
        print(jsonDecode(response.body));
        return [];
      }
    } catch(err) {
        print(err);
        return [];
    }
  }

//Add Entry
    Future<String> addEntry(Entry entry) async{
    try {

      final response = await http.post(
        Uri.parse('$baseUrl/add'),
      headers: {
        "Content-Type": "application/json"
      },
      body: jsonEncode(entry.toJson())
      );

      if(response.statusCode == 200 || response.statusCode == 201) {
        return "Data Added";
      } else {
        return "Error: ${jsonDecode(response.body)}";
      }
    } catch(err) {
        print(err);
        return "Error: $err";
    }
  }
  
}


