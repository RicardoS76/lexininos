import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../resultados/results_test1_page.dart';
import '../resultados/results_test2_page.dart';
import '../resultados/results_test3_page.dart';
import '../resultados/results_test4_page.dart';
import '../resultados/results_total_page.dart';

class ResultsPage extends StatefulWidget {
  @override
  _ResultsPageState createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  bool _resultsMode = false;

  @override
  void initState() {
    super.initState();
    _loadResultsMode();
  }

  Future<void> _loadResultsMode() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _resultsMode = prefs.getBool('resultsMode') ?? false;
    });
  }

  Future<void> _setResultsMode(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _resultsMode = value;
      prefs.setBool('resultsMode', value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Resultados'),
        actions: [
          IconButton(
            icon: Icon(_resultsMode ? Icons.cancel : Icons.check),
            onPressed: () {
              _setResultsMode(!_resultsMode);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16.0),
            color: _resultsMode ? Colors.greenAccent : Colors.redAccent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _resultsMode
                      ? 'Modo de Resultados Activado'
                      : 'Modo de Resultados Desactivado',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    _setResultsMode(false);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                  ),
                  child: Text(
                    'Cancelar',
                    style: TextStyle(color: Colors.redAccent),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
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
          ),
        ],
      ),
    );
  }
}
