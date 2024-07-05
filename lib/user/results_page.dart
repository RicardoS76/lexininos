import 'package:flutter/material.dart';
import '../resultados/results_test1_page.dart';
import '../resultados/results_test2_page.dart';
import '../resultados/results_test3_page.dart';
import '../resultados/results_test4_page.dart';
import '../resultados/results_total_page.dart';

class ResultsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Resultados'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Resultados - Rimas'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ResultsTest1Page()),
              );
            },
          ),
          ListTile(
            title: Text('Resultados - Conecta y Aprende'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ResultsTest2Page()),
              );
            },
          ),
          ListTile(
            title: Text('Resultados - Palabras Escondidas'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ResultsTest3Page()),
              );
            },
          ),
          ListTile(
            title: Text('Resultados - Desafío Visual: Figuras'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ResultsTest4Page()),
              );
            },
          ),
          ListTile(
            title: Text('Resultados Totales'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ResultsTotalPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
