import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ResultsTest1Page extends StatelessWidget {
  Future<Map<String, int>> _loadResults() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return {
      'Nivel 1': prefs.getInt('level1_time') ?? 0,
      'Nivel 2': prefs.getInt('level2_time') ?? 0,
      'Nivel 3': prefs.getInt('level3_time') ?? 0,
      'Nivel 4': prefs.getInt('level4_time') ?? 0,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Resultados - Rimas'),
      ),
      body: FutureBuilder<Map<String, int>>(
        future: _loadResults(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error al cargar los resultados'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No hay resultados disponibles'));
          } else {
            final results = snapshot.data!;
            return ListView.builder(
              itemCount: results.length,
              itemBuilder: (context, index) {
                final level = results.keys.elementAt(index);
                final time = results[level]!;
                return ListTile(
                  title: Text(level),
                  subtitle: Text('Tiempo: $time segundos'),
                );
              },
            );
          }
        },
      ),
    );
  }
}
