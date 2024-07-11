import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ResultsTest1Page extends StatelessWidget {
  Future<Map<String, dynamic>> _loadResults() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final results = {
      'Nivel 1': prefs.getInt('level1_time') ?? 0,
      'Nivel 2': prefs.getInt('level2_time') ?? 0,
      'Nivel 3': prefs.getInt('level3_time') ?? 0,
      'Nivel 4': prefs.getInt('level4_time') ?? 0,
    };
    final totalTime = results.values.reduce((a, b) => a + b);
    final category = _getCategory(totalTime);
    final points = _getPoints(category);
    return {
      'results': results,
      'totalTime': totalTime,
      'category': category,
      'points': points,
    };
  }

  String _getCategory(int totalTime) {
    if (totalTime <= 15 * 60) {
      return 'Sin indicios de dislexia';
    } else if (totalTime <= 20 * 60) {
      return 'Leve indicio de dislexia';
    } else if (totalTime <= 25 * 60) {
      return 'Moderado indicio de dislexia';
    } else {
      return 'Fuerte indicio de dislexia';
    }
  }

  int _getPoints(String category) {
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
        title: Text('Resultados - Rimas'),
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
            final results = snapshot.data!['results'] as Map<String, int>;
            final totalTime = snapshot.data!['totalTime'] as int;
            final category = snapshot.data!['category'] as String;
            final points = snapshot.data!['points'] as int;

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: results.length,
                    itemBuilder: (context, index) {
                      final level = results.keys.elementAt(index);
                      final time = results[level]!;
                      return ListTile(
                        title: Text(level),
                        subtitle: Text('Tiempo: ${time ~/ 60} minutos ${time % 60} segundos'),
                      );
                    },
                  ),
                ),
                ListTile(
                  title: Text('Tiempo total'),
                  subtitle: Text('${totalTime ~/ 60} minutos ${totalTime % 60} segundos'),
                ),
                ListTile(
                  title: Text('Categoría'),
                  subtitle: Text(category),
                ),
                ListTile(
                  title: Text('Puntos obtenidos'),
                  subtitle: Text('$points puntos'),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
