import 'package:flutter/material.dart';

class DetailedEvaluationPage extends StatelessWidget {
  final int totalTime;
  final int completedTests;

  DetailedEvaluationPage(
      {required this.totalTime, required this.completedTests});

  String getEvaluation() {
    if (completedTests < 4) {
      return 'Faltan pruebas por realizar.';
    }

    if (totalTime < 240) {
      return 'Leve';
    } else if (totalTime < 300) {
      return 'Moderada';
    } else if (totalTime < 420) {
      return 'Severa';
    } else {
      return 'Profunda';
    }
  }

  String getEvaluationMessage() {
    if (completedTests < 4) {
      return 'Faltan pruebas por realizar.';
    }

    if (totalTime < 240) {
      return 'Dificultades menores con la lectura y la escritura. '
          'Errores ocasionales en la ortografía. '
          'Lectura más lenta de lo normal, pero generalmente comprensible. '
          'Capacidad para compensar las dificultades con estrategias de aprendizaje.';
    } else if (totalTime < 300) {
      return 'Problemas más consistentes con la lectura y la escritura. '
          'Errores frecuentes en la ortografía y la gramática. '
          'Lectura significativamente más lenta que la media. '
          'Necesidad de apoyo educativo y estrategias de aprendizaje específicas para manejar el trastorno.';
    } else if (totalTime < 420) {
      return 'Dificultades graves con la lectura y la escritura. '
          'Errores constantes en la ortografía y la gramática. '
          'Lectura extremadamente lenta y con poca comprensión. '
          'Dependencia de ayudas tecnológicas y educativas intensivas. '
          'Problemas con otras habilidades del lenguaje, como la fluidez y la comprensión oral.';
    } else {
      return 'Incapacidad casi total para leer y escribir de manera funcional. '
          'Errores persistentes y graves en la ortografía y la gramática. '
          'Gran dificultad para comprender textos escritos. '
          'Requiere apoyo educativo y tecnológico muy intensivo. '
          'Afecta significativamente otras áreas del aprendizaje y el desarrollo personal.';
    }
  }

  @override
  Widget build(BuildContext context) {
    final evaluation = getEvaluation();
    final evaluationMessage = getEvaluationMessage();

    return Scaffold(
      appBar: AppBar(
        title: Text('Evaluación de Desempeño'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Resultado de Evaluación',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Text(
                evaluation,
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  color: completedTests < 4 ? Colors.red : Colors.black,
                ),
              ),
              SizedBox(height: 20),
              Text(
                evaluationMessage,
                style: TextStyle(
                  fontSize: 18.0,
                  color: completedTests < 4 ? Colors.red : Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              if (completedTests >= 4) ...[
                SizedBox(height: 20),
                Text(
                  'Tiempo Total: $totalTime segundos',
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
              ],
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Volver al Menú'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
