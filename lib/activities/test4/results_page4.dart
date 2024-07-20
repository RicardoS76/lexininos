import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/baseDatos/database_helper.dart';

class ResultsPage4 extends StatefulWidget {
  @override
  _ResultsPage4State createState() => _ResultsPage4State();
}

class _ResultsPage4State extends State<ResultsPage4> {
  Future<List<Map<String, dynamic>>> _fetchResults() async {
    final dbHelper = DatabaseHelper();
    final userId = await _getCurrentUserId();
    List<Map<String, dynamic>> results =
        await dbHelper.getResultsByUser(userId);

    // Filtra resultados para la prueba 6
    results = results.where((result) {
      return result['prueba'] == 6;
    }).toList();

    return results;
  }

  Future<int> _getCurrentUserId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('user_id') ?? 0;
  }

  Future<void> _deleteAllResults() async {
    final dbHelper = DatabaseHelper();
    final userId = await _getCurrentUserId(); // Obtén el ID del usuario actual
    await dbHelper.deleteResultsByUser(
        userId); // Elimina solo los resultados del usuario actual
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
              'Resultado ${index + 1}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text('Tiempo: ${result['tiempo']} segundos'),
            SizedBox(height: 8.0),
            Text('Errores: ${result['errores']}'),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Resultados de Prueba 6'),
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
