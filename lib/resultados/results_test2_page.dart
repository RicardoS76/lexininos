import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ResultsTest2Page extends StatelessWidget {
  Future<Map<String, dynamic>> _loadResults() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final results = {
      'Animales': prefs.getInt('animals_errors') ?? 0,
      'Frutas': prefs.getInt('fruits_errors') ?? 0,
      'Objetos': prefs.getInt('objects_errors') ?? 0,
    };
    final totalErrors = results.values.reduce((a, b) => a + b);
    final category = _getCategory(totalErrors);
    final points = _getPoints(category);
    return {
      'results': results,
      'totalErrors': totalErrors,
      'category': category,
      'points': points,
    };
  }

  String _getCategory(int totalErrors) {
    if (totalErrors <= 1) {
      return 'Sin indicios de dislexia';
    } else if (totalErrors <= 3) {
      return 'Leve indicio de dislexia';
    } else if (totalErrors <= 5) {
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
        title: Text('Resultados - Conecta y Aprende'),
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
            final totalErrors = snapshot.data!['totalErrors'] as int;
            final category = snapshot.data!['category'] as String;
            final points = snapshot.data!['points'] as int;

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: results.length,
                    itemBuilder: (context, index) {
                      final subtest = results.keys.elementAt(index);
                      final errors = results[subtest]!;
                      return ListTile(
                        title: Text(subtest),
                        subtitle: Text('Errores: $errors'),
                      );
                    },
                  ),
                ),
                ListTile(
                  title: Text('Errores totales'),
                  subtitle: Text('$totalErrors errores'),
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
