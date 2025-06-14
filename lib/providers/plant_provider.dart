import 'package:flutter/material.dart';
import '../models/plant_model.dart';
import '../services/firestore_service.dart';

class PlantProvider with ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();
  List<Plant> _plants = [];
  bool _isLoading = false;

  List<Plant> get plants => _plants;
  bool get isLoading => _isLoading;

  void loadPlants(String userId) {
    _firestoreService.getPlants(userId).listen((plants) {
      _plants = plants;
      notifyListeners();
    });
  }

  Future<void> addPlant(Plant plant) async {
    try {
      _isLoading = true;
      notifyListeners();

      await _firestoreService.addPlant(plant);

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      throw e;
    }
  }

  Future<void> deletePlant(String plantId) async {
    try {
      await _firestoreService.deletePlant(plantId);
    } catch (e) {
      throw e;
    }
  }
}
