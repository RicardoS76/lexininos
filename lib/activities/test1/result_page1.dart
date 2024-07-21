import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '/baseDatos/database_helper.dart';

class ResultsPage1 extends StatefulWidget {
  @override
  _ResultsPage1State createState() => _ResultsPage1State();
}

class _ResultsPage1State extends State<ResultsPage1> {
  Future<List<Map<String, dynamic>>> _fetchResults() async {
    final dbHelper = DatabaseHelper();
    final userId = await _getCurrentUserId();
    List<Map<String, dynamic>> results =
        await dbHelper.getResultsByUser(userId);

    // Filtra resultados para la prueba 1
    results = results.where((result) {
      return result['prueba'] == 1;
    }).toList();

    // Agrupa resultados por intento
    Map<int, Map<String, dynamic>> groupedResults = {};
    for (var result in results) {
      int attempt = result['intento'];
      if (!groupedResults.containsKey(attempt)) {
        groupedResults[attempt] = {'tiempo': 0, 'errores': 0, 'intento': attempt};
      }
      groupedResults[attempt]!['tiempo'] += result['tiempo'];
      groupedResults[attempt]!['errores'] += result['errores'];
    }

    return groupedResults.values.toList();
  }

  Future<int> _getCurrentUserId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('user_id') ?? 0;
  }

  Future<void> _deleteAllResults() async {
    final dbHelper = DatabaseHelper();
    final userId = await _getCurrentUserId(); // Obtén el ID del usuario actual
    await dbHelper.deleteResultsByUser(userId); // Elimina solo los resultados del usuario actual
    setState(() {});
  }

  void _showDeleteConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmar'),
          content: Text(
              '¿Estás seguro de que deseas eliminar todos los resultados?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Eliminar'),
              onPressed: () {
                _deleteAllResults();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildResultCard(Map<String, dynamic> result, int index) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Intento ${result['intento']}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text('Tiempo Total: ${result['tiempo']} segundos'),
            SizedBox(height: 8.0),
            Text('Errores Totales: ${result['errores']}'),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Resultados de Prueba 1'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: _showDeleteConfirmationDialog,
          ),
        ],
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _fetchResults(),
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
                return _buildResultCard(results[index], index);
              },
            );
          }
        },
      ),
    );
  }
}
