import 'package:flutter/material.dart';
import 'package:lexininos/user/shared_preferences.dart';

import '/baseDatos/database_helper.dart';

class ResultsPage3 extends StatefulWidget {
  @override
  _ResultsPage3State createState() => _ResultsPage3State();
}

class _ResultsPage3State extends State<ResultsPage3> {
  Future<List<Map<String, dynamic>>> _fetchResults() async {
    final dbHelper = DatabaseHelper();
    final userId = await SharedPreferencesHelper.getUserId() ?? 0;
    List<Map<String, dynamic>> results =
        await dbHelper.getResultsByUser(userId);

    results = results.where((result) {
      return result['prueba'] == 5;
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
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text('Confirmar', style: TextStyle(fontWeight: FontWeight.bold)),
          content: Text('¿Estás seguro de que deseas eliminar todos los resultados?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Eliminar', style: TextStyle(color: Colors.red)),
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

  Widget _buildResultCard(Map<String, dynamic> result, int index, double padding, double fontSize) {
    return Card(
      color: Colors.white.withOpacity(0.9),
      elevation: 6.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: padding),
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Resultado ${index + 1}',
              style: TextStyle(fontSize: fontSize * 1.2, fontWeight: FontWeight.bold, color: Colors.blueAccent),
            ),
            SizedBox(height: 8.0),
            Text('Tiempo: ${result['tiempo']} segundos', style: TextStyle(fontSize: fontSize)),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double padding = screenWidth * 0.05; // Ajuste de padding responsivo
    double fontSize = screenWidth * 0.04; // Ajuste de tamaño de fuente responsivo

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.pink.shade100,
                  Colors.blue.shade100,
                  Colors.green.shade100,
                  Colors.yellow.shade100,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: padding),
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back, color: Colors.blueAccent),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      SizedBox(width: 8.0),
                      Expanded(
                        child: Text(
                          'Resultados de Palabras Escondidas',
                          style: TextStyle(fontSize: fontSize * 1.5, fontWeight: FontWeight.bold, color: Colors.teal.shade700, fontFamily: 'Cocogoose'),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: padding),
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.red,
                      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    icon: Icon(Icons.delete),
                    label: Text('Eliminar Todo'),
                    onPressed: _showDeleteConfirmationDialog,
                  ),
                ),
                SizedBox(height: 20),
                Expanded(
                  child: FutureBuilder<List<Map<String, dynamic>>>(
                    future: _fetchResults(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error al cargar los resultados', style: TextStyle(color: Colors.red, fontSize: fontSize)));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Center(child: Text('No hay resultados disponibles', style: TextStyle(fontSize: fontSize)));
                      } else {
                        final results = snapshot.data!;
                        return ListView.builder(
                          itemCount: results.length,
                          itemBuilder: (context, index) {
                            return _buildResultCard(results[index], index, padding, fontSize);
                          },
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
