import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/plant_model.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Get plants for a specific user
  Stream<List<Plant>> getPlants(String userId) {
    print('Getting plants for user: $userId'); // Debug print
    return _db
        .collection('plants')
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map((snapshot) {
          print(
            'Received ${snapshot.docs.length} plants from Firestore',
          ); // Debug print
          return snapshot.docs.map((doc) {
            print('Plant data: ${doc.data()}'); // Debug print
            return Plant.fromMap(doc.data(), doc.id);
          }).toList();
        });
  }

  // Add a new plant
  Future<void> addPlant(Plant plant) async {
    try {
      print(
        'Adding plant: ${plant.name} for user: ${plant.userId}',
      ); // Debug print
      await _db.collection('plants').add(plant.toMap());
      print('Plant added successfully'); // Debug print
    } catch (e) {
      print('Error adding plant: $e');
      throw e;
    }
  }

  // Delete a plant
  Future<void> deletePlant(String plantId) async {
    try {
      await _db.collection('plants').doc(plantId).delete();
    } catch (e) {
      print('Error deleting plant: $e');
      throw e;
    }
  }
}
