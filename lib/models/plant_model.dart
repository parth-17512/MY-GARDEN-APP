import 'package:cloud_firestore/cloud_firestore.dart';

class Plant {
  final String id;
  final String name;
  final DateTime dateAcquired;
  final String userId;

  Plant({
    required this.id,
    required this.name,
    required this.dateAcquired,
    required this.userId,
  });

  factory Plant.fromMap(Map<String, dynamic> map, String id) {
    return Plant(
      id: id,
      name: map['name'] ?? '',
      dateAcquired: (map['dateAcquired'] as Timestamp).toDate(),
      userId: map['userId'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'dateAcquired': Timestamp.fromDate(dateAcquired),
      'userId': userId,
    };
  }
}
