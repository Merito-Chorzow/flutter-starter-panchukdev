class Entry {
  String? id;
  final String title;
  final String date;
  final String description;
  final String latitude;
  final String longitude;


  //Constructor
  Entry({
    this.id,
    required this.title,
    required this.date,
    required this.description,
    required this.latitude,
    required this.longitude,
  });

  //Method to create Entry from JSON
  factory Entry.fromJson(Map<String, dynamic> json) {
    return Entry(
      id: json['_id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      date: json['date'] ?? '',
      latitude: json['latitude'] ?? '0',
      longitude: json['longitude'] ?? '0',
    );
  }



  //Method to convert Entry to JSON
  Map<String, dynamic> toJson() {
  return {
    '_id': id,
    'title': title,
    'description': description,
    'date': date,
    'latitude': latitude,
    'longitude': longitude,
    
  };
}
}

