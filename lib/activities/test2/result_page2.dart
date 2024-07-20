import 'package:flutter/material.dart';
import 'package:lexininos/user/shared_preferences.dart';

import '/baseDatos/database_helper.dart';

class ResultsPage2 extends StatefulWidget {
  @override
  _ResultsPage2State createState() => _ResultsPage2State();
}

class _ResultsPage2State extends State<ResultsPage2> {
  Future<List<Map<String, dynamic>>> _fetchResults() async {
    final dbHelper = DatabaseHelper();
    final userId = await SharedPreferencesHelper.getUserId() ?? 0;
    List<Map<String, dynamic>> results =
        await dbHelper.getResultsByUser(userId);

    // Filtra resultados para las pruebas 2, 3 y 4
    results = results.where((result) {
      return result['prueba'] == 2 ||
          result['prueba'] == 3 ||
          result['prueba'] == 4;
    }).toList();

    return results;
  }

  Future<void> _deleteAllResults() async {
    final dbHelper = DatabaseHelper();
    final userId = await SharedPreferencesHelper.getUserId() ?? 0;
    await dbHelper.deleteResultsByUser(userId);
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

  Widget _buildResultCard(Map<String, dynamic> result) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Prueba ${result['prueba']}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text('Tiempo: ${result['tiempo']} segundos'),
            Text('Errores: ${result['errores']}'),
          ],
        ),
      ),
    );
  }

  Widget _buildResultsSection(
      List<Map<String, dynamic>> results, int pruebaNumber, String title) {
    final filteredResults =
        results.where((result) => result['prueba'] == pruebaNumber).toList();

    if (filteredResults.isEmpty) return SizedBox.shrink();

    return ExpansionTile(
      title: Text(title),
      children: filteredResults.map(_buildResultCard).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Resultados'),
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
            return ListView(
              children: [
                _buildResultsSection(results, 2, 'Animales'),
                _buildResultsSection(results, 3, 'Frutas'),
                _buildResultsSection(results, 4, 'Objetos'),
              ],
            );
          }
        },
      ),
    );
  }
}
