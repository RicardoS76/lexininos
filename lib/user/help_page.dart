import 'package:flutter/material.dart';

class HelpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Fondo de colores pasteles
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
                  // Encabezado con título
                  Center(
                    child: Text(
                      'Ayuda Especializada',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.purple,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  // Descripción sobre la dislexia
                  Text(
                    'La dislexia es una dificultad de aprendizaje de la lectura que afecta la decodificación, el reconocimiento de palabras y la ortografía. Es importante buscar la ayuda de profesionales para proporcionar el apoyo adecuado y estrategias personalizadas que ayuden a los niños a superar estos desafíos y a alcanzar su máximo potencial académico y personal.',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontStyle: FontStyle.italic,
                      color: Colors.purple.shade700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 40),
                  // Secciones de ayuda
                  Expanded(
                    child: ListView(
                      children: [
                        _buildInfoTile('Centro 1: Dirección 1', Icons.location_on, context),
                        _buildInfoTile('Centro 2: Dirección 2', Icons.location_on, context),
                        _buildInfoTile('Centro 3: Dirección 3', Icons.location_on, context),
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

  Widget _buildInfoTile(String title, IconData icon, BuildContext context, {String? route}) {
    return GestureDetector(
      onTap: route != null
          ? () {
              Navigator.pushNamed(context, route);
            }
          : null,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10.0),
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
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
            Icon(icon, color: Colors.purple, size: 30.0),
            SizedBox(width: 20),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple,
                ),
              ),
            ),
            Icon(Icons.arrow_forward_ios, color: Colors.purple, size: 20.0),
          ],
        ),
      ),
    );
  }
}
