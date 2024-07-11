import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ResultsTest4Page extends StatelessWidget {
  Future<Map<String, dynamic>> _loadResults() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final points = prefs.getDouble('visual_challenge_points') ?? 0.0;
    final category = _getCategory(points);
    final weightedPoints = _getWeightedPoints(category);
    return {
      'points': points,
      'category': category,
      'weightedPoints': weightedPoints,
    };
  }

  String _getCategory(double points) {
    if (points >= 4.5) {
      return 'Sin indicios de dislexia';
    } else if (points >= 3.0) {
      return 'Leve indicio de dislexia';
    } else if (points >= 1.5) {
      return 'Moderado indicio de dislexia';
    } else {
      return 'Fuerte indicio de dislexia';
    }
  }

  int _getWeightedPoints(String category) {
    switch (category) {
      case 'Sin indicios de dislexia':
        return 3;
      case 'Leve indicio de dislexia':
        return 2;
      case 'Moderado indicio de dislexia':
        return 1;
      case 'Fuerte indicio de dislexia':
      default:
        return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Resultados - Desafío Visual: Figuras'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _loadResults(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error al cargar los resultados'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No hay resultados disponibles'));
          } else {
            final points = snapshot.data!['points'] as double;
            final category = snapshot.data!['category'] as String;
            final weightedPoints = snapshot.data!['weightedPoints'] as int;

            return Column(
              children: [
                ListTile(
                  title: Text('Puntos obtenidos'),
                  subtitle: Text('$points puntos'),
                ),
                ListTile(
                  title: Text('Categoría'),
                  subtitle: Text(category),
                ),
                ListTile(
                  title: Text('Puntos ponderados'),
                  subtitle: Text('$weightedPoints puntos'),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
