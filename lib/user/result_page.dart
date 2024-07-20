import 'package:flutter/material.dart';
import 'package:lexininos/activities/test1/result_page1.dart';
import 'package:lexininos/activities/test2/result_page2.dart';
import 'package:lexininos/activities/test3/results_page3.dart';
import 'package:lexininos/activities/test4/results_page4.dart'; // Agrega esta línea

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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.menu, color: Colors.teal.shade700, size: 40.0),
                      SizedBox(width: 10),
                      Text(
                        'Menú de Resultados',
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal.shade700,
                          fontFamily: 'Cocogoose',
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 40),
                  Expanded(
                    child: ListView(
                      children: [
                        _buildInfoTile(
                          'Ver Resultados de Prueba 1',
                          Icons.assessment,
                          context,
                          route: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ResultsPage1()),
                          ),
                          textColor: Colors.purple,
                        ),
                        _buildInfoTile(
                          'Ver Resultados de Prueba 2',
                          Icons.assessment,
                          context,
                          route: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ResultsPage2()),
                          ),
                          textColor: Colors.blue,
                        ),
                        _buildInfoTile(
                          'Ver Resultados de Prueba 3',
                          Icons.assessment,
                          context,
                          route: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ResultsPage3()),
                          ),
                          textColor: Colors.green,
                        ),
                        _buildInfoTile(
                          'Ver Resultados de Prueba 4',
                          Icons.assessment,
                          context,
                          route: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ResultsPage4()),
                          ),
                          textColor: Colors.orange,
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

  Widget _buildInfoTile(String title, IconData icon, BuildContext context,
      {required Function route, required Color textColor}) {
    return GestureDetector(
      onTap: () {
        route();
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10.0),
        padding: EdgeInsets.all(16.0),
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
            Icon(icon, color: textColor, size: 30.0),
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
            Icon(Icons.arrow_forward_ios, color: textColor, size: 20.0),
          ],
        ),
      ),
    );
  }
}
