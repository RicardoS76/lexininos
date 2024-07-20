import 'package:flutter/material.dart';
import 'package:lexininos/activities/test1/result_page1.dart';
import 'package:lexininos/activities/test2/result_page2.dart';
import 'package:lexininos/activities/test3/results_page3.dart';
import 'package:lexininos/activities/test4/results_page4.dart';
import 'package:lexininos/user/evaluation_page.dart'; // Importa la nueva pantalla
import 'package:shared_preferences/shared_preferences.dart';

import '/baseDatos/database_helper.dart';

class MenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Center(
                    child: Text(
                      'Resultados de las Pruebas',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal.shade700,
                        fontFamily: 'Cocogoose',
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'De clic en "Ver Detalles" para saber individualmente el desempeño en cada prueba y en "Evaluar Desempeño" para un pre-diagnóstico.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.teal.shade500,
                      fontFamily: 'Cocogoose',
                    ),
                  ),
                  SizedBox(height: 40),
                  Expanded(
                    child: ListView(
                      children: [
                        _buildInfoTile(
                          'Rimas',
                          'assets/rima.jpg',
                          context,
                          route: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ResultsPage1()),
                          ),
                          textColor: Colors.purple,
                        ),
                        _buildInfoTile(
                          'Conecta y Aprende',
                          'assets/palabras.jpg',
                          context,
                          route: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ResultsPage2()),
                          ),
                          textColor: Colors.blue,
                        ),
                        _buildInfoTile(
                          'Palabras Escondidas',
                          'assets/sopa.png',
                          context,
                          route: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ResultsPage3()),
                          ),
                          textColor: Colors.green,
                        ),
                        _buildInfoTile(
                          'Desafío Visual',
                          'assets/figuras.jpg',
                          context,
                          route: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ResultsPage4()),
                          ),
                          textColor: Colors.orange,
                        ),
                        _buildInfoTileNoIcon(
                          'Evaluar Desempeño',
                          context,
                          route: () => _evaluatePerformance(context),
                          textColor: Colors.red,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _evaluatePerformance(BuildContext context) async {
    final dbHelper = DatabaseHelper();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int userId = prefs.getInt('user_id') ?? 0;
    int totalTime = await dbHelper.getTotalTimeByUser(userId);
    int completedTests = await dbHelper.getCompletedTestsCountByUser(userId);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailedEvaluationPage(
          totalTime: totalTime,
          completedTests: completedTests,
        ),
      ),
    );
  }

  Widget _buildInfoTile(String title, String iconPath, BuildContext context,
      {required Function route, required Color textColor}) {
    return GestureDetector(
      onTap: () {
        route();
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10.0),
        padding: EdgeInsets.all(20.0), // Aumenta el padding para mayor altura
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 5.0,
              spreadRadius: 1.0,
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.0), // Esquinas redondeadas
              child: Image.asset(
                iconPath,
                width: 70.0, // Aumenta el tamaño del logo
                height: 70.0, // Aumenta el tamaño del logo
              ),
            ),
            SizedBox(width: 20),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                  fontFamily: 'Cocogoose',
                ),
              ),
            ),
            Text(
              'Ver Detalles',
              style: TextStyle(
                fontSize: 16.0,
                color: textColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            Icon(Icons.arrow_forward_ios, color: textColor, size: 20.0),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoTileNoIcon(String title, BuildContext context,
      {required Function route, required Color textColor}) {
    return GestureDetector(
      onTap: () {
        route();
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10.0),
        padding: EdgeInsets.all(20.0), // Aumenta el padding para mayor altura
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 5.0,
              spreadRadius: 1.0,
            ),
          ],
        ),
        child: Row(
          children: [
            SizedBox(width: 20),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                  fontFamily: 'Cocogoose',
                ),
              ),
            ),
            Text(
              'Evaluar',
              style: TextStyle(
                fontSize: 16.0,
                color: textColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            Icon(Icons.arrow_forward_ios, color: textColor, size: 20.0),
          ],
        ),
      ),
    );
  }
}
