import 'package:cloud_firestore/cloud_firestore.dart';

class Trip {
  final String id;
  final String name;
  final DateTime startDate;
  final DateTime endDate;

  Trip({required this.id, required this.name, required this.startDate, required this.endDate});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'startDate': startDate,
      'endDate': endDate,
    };
  }

  factory Trip.fromMap(String id, Map<String, dynamic> map) {
    return Trip(
      id: id,
      name: map['name'],
      startDate: (map['startDate'] as Timestamp).toDate(),
      endDate: (map['endDate'] as Timestamp).toDate(),
    );
  }
}
