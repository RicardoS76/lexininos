import 'package:flutter/material.dart';

class SoundSequenceGame extends StatefulWidget {
  @override
  _SoundSequenceGameState createState() => _SoundSequenceGameState();
}

class _SoundSequenceGameState extends State<SoundSequenceGame> {
  List<String> sounds = ['Beep', 'Boop', 'Bop'];
  List<String> sequence = [];
  List<String> userSequence = [];

  void _playSequence() {
    sequence = List.from(sounds)..shuffle();
    userSequence.clear();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Secuencia reproducida')));
  }

  void _addUserSound(String sound) {
    userSequence.add(sound);
    if (userSequence.length == sequence.length) {
      if (userSequence.toString() == sequence.toString()) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('¡Correcto!')));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Inténtalo de nuevo')));
      }
      userSequence.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Secuencias de Sonidos'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Recuerda y repite la secuencia de sonidos',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _playSequence,
              child: Text('Reproducir Secuencia'),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: sounds.map((sound) {
                return ElevatedButton(
                  onPressed: () => _addUserSound(sound),
                  child: Text(sound),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
