class Location {
  final String id;
  final String name;
  final String description;
  final String address;
  final double latitude;
  final double longitude;

  Location({
    required this.id,
    required this.name,
    required this.description,
    required this.address,
    required this.latitude,
    required this.longitude,
  });

  factory Location.fromMap(Map<String, dynamic> map, String id) {
    return Location(
      id: id,
      name: map['name'],
      description: map['description'],
      address: map['address'],
      latitude: map['latitude'],
      longitude: map['longitude'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
