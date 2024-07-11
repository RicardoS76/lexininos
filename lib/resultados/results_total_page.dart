import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ResultsTotalPage extends StatelessWidget {
  Future<Map<String, dynamic>> _loadTotalResults() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final rhymePoints = prefs.getInt('rhyme_points') ?? 0;
    final connectLearnPoints = prefs.getInt('connect_learn_points') ?? 0;
    final hiddenWordsPoints = prefs.getInt('hidden_words_points') ?? 0;
    final visualChallengePoints = prefs.getInt('visual_challenge_points') ?? 0;

    final totalPoints = rhymePoints + connectLearnPoints + hiddenWordsPoints + visualChallengePoints;
    final category = _getCategory(totalPoints);

    return {
      'rhymePoints': rhymePoints,
      'connectLearnPoints': connectLearnPoints,
      'hiddenWordsPoints': hiddenWordsPoints,
      'visualChallengePoints': visualChallengePoints,
      'totalPoints': totalPoints,
      'category': category,
    };
  }

  String _getCategory(int totalPoints) {
    if (totalPoints >= 11) {
      return 'Sin indicios de dislexia';
    } else if (totalPoints >= 8) {
      return 'Leve indicio de dislexia';
    } else if (totalPoints >= 5) {
      return 'Moderado indicio de dislexia';
    } else {
      return 'Fuerte indicio de dislexia';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Resultados Totales'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _loadTotalResults(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error al cargar los resultados'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No hay resultados disponibles'));
          } else {
            final rhymePoints = snapshot.data!['rhymePoints'] as int;
            final connectLearnPoints = snapshot.data!['connectLearnPoints'] as int;
            final hiddenWordsPoints = snapshot.data!['hiddenWordsPoints'] as int;
            final visualChallengePoints = snapshot.data!['visualChallengePoints'] as int;
            final totalPoints = snapshot.data!['totalPoints'] as int;
            final category = snapshot.data!['category'] as String;

            return Column(
              children: [
                ListTile(
                  title: Text('Rimas'),
                  subtitle: Text('Puntos: $rhymePoints'),
                ),
                ListTile(
                  title: Text('Conecta y Aprende'),
                  subtitle: Text('Puntos: $connectLearnPoints'),
                ),
                ListTile(
                  title: Text('Palabras Escondidas'),
                  subtitle: Text('Puntos: $hiddenWordsPoints'),
                ),
                ListTile(
                  title: Text('Desafío Visual: Figuras'),
                  subtitle: Text('Puntos: $visualChallengePoints'),
                ),
                ListTile(
                  title: Text('Puntos Totales'),
                  subtitle: Text('$totalPoints puntos'),
                ),
                ListTile(
                  title: Text('Categoría'),
                  subtitle: Text(category),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
