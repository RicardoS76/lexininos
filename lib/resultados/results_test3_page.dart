import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ResultsTest3Page extends StatelessWidget {
  Future<Map<String, dynamic>> _loadResults() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final totalTime = prefs.getInt('hidden_words_time') ?? 0;
    final category = _getCategory(totalTime);
    final points = _getPoints(category);
    return {
      'totalTime': totalTime,
      'category': category,
      'points': points,
    };
  }

  String _getCategory(int totalTime) {
    if (totalTime <= 15 * 60) {
      return 'Sin indicios de dislexia';
    } else if (totalTime <= 18 * 60) {
      return 'Leve indicio de dislexia';
    } else if (totalTime <= 21 * 60) {
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
        title: Text('Resultados - Palabras Escondidas'),
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
            final totalTime = snapshot.data!['totalTime'] as int;
            final category = snapshot.data!['category'] as String;
            final points = snapshot.data!['points'] as int;

            return Column(
              children: [
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
