import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../models/plant_model.dart';
import '../providers/plant_provider.dart';

class PlantCard extends StatelessWidget {
  final Plant plant;

  const PlantCard({Key? key, required this.plant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 12),
      elevation: 2,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.green,
          child: Icon(Icons.local_florist, color: Colors.white),
        ),
        title: Text(plant.name, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(
          'Added: ${DateFormat('MMM dd, yyyy').format(plant.dateAcquired)}',
        ),
        trailing: IconButton(
          icon: Icon(Icons.delete, color: Colors.red),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text('Delete Plant'),
                content: Text('Are you sure you want to delete ${plant.name}?'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () async {
                      try {
                        await Provider.of<PlantProvider>(
                          context,
                          listen: false,
                        ).deletePlant(plant.id);
                        Navigator.of(context).pop();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Plant deleted successfully!'),
                          ),
                        );
                      } catch (e) {
                        Navigator.of(context).pop();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Error deleting plant: ${e.toString()}',
                            ),
                          ),
                        );
                      }
                    },
                    child: Text('Delete', style: TextStyle(color: Colors.red)),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
