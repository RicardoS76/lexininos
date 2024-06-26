import 'package:flutter/material.dart';
import 'security_dialog.dart';

class MainPage extends StatelessWidget {
  final String authenticatedUserPassword;

  MainPage({required this.authenticatedUserPassword});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Fondo difuminado
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
          // Contenido
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40.0), // Espacio desde la parte superior
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(Icons.settings,
                          size: 40.0,
                          color: Colors.white), // Icono de configuración
                      onPressed: () => _showSecurityDialog(context, 'Ajuste',
                          '/settings', authenticatedUserPassword),
                    ),
                    IconButton(
                      icon: Icon(Icons.person,
                          size: 40.0,
                          color: Colors.white), // Icono más grande y blanco
                      onPressed: () => _showSecurityDialog(context, 'Usuario',
                          '/user', authenticatedUserPassword),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 36.0, // Aumentar tamaño de fuente
                      fontFamily: 'Cocogoose',
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          offset: Offset(2.0, 2.0),
                          blurRadius: 3.0,
                          color: Colors.black,
                        ),
                      ],
                    ),
                    children: [
                      TextSpan(
                          text: 'HOLA, BIENVENIDO(A)',
                          style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
              ),
              SizedBox(
                  height: 60.0), // Espacio adicional para bajar los elementos
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 28.0,
                      fontFamily: 'Cocogoose',
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          offset: Offset(2.0, 2.0),
                          blurRadius: 3.0,
                          color: Colors.black,
                        ),
                      ],
                    ),
                    children: [
                      TextSpan(
                          text: 'ACTIVIDADES',
                          style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              // Carrusel de actividades
              Container(
                height: 220.0,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildActivityCard(
                        context, 'Rimas', 'assets/icon1.jpg', '/rhyme'),
                    _buildActivityCard(context, 'Sonidos', 'assets/icon2.jpg',
                        '/initial_final_sounds'),
                    _buildActivityCard(context, 'Memoria Visual',
                        'assets/icon3.jpg', '/word_memory'),
                    _buildActivityCard(context, 'Secuencias',
                        'assets/icon4.jpg', '/sound_sequence'),
                    _buildActivityCard(
                        context, 'Trazado', '', '/letter_tracing'),
                    _buildActivityCard(context, 'Letras', '', '/letter_puzzle'),
                    _buildActivityCard(
                        context, 'Caza Palabras', '', '/word_hunt'),
                    _buildActivityCard(
                        context, 'Palabras Ocultas', '', '/word_search'),
                    _buildActivityCard(
                        context, 'Vocabulario', '', '/image_word_match'),
                    _buildActivityCard(
                        context, 'Historias', '', '/interactive_story'),
                  ],
                ),
              ),
              SizedBox(height: 20.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Ejercicios',
                  style: TextStyle(
                    fontSize: 24.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              // Carrusel de ejercicios
              Container(
                height: 200.0,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildExerciseCard(context,
                        icon: Icons.book,
                        color: Colors.red,
                        text: 'Ejercicio 1'),
                    _buildExerciseCard(context,
                        icon: Icons.book,
                        color: Colors.blue,
                        text: 'Ejercicio 2'),
                    _buildExerciseCard(context,
                        icon: Icons.book,
                        color: Colors.teal,
                        text: 'Ejercicio 3'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showSecurityDialog(BuildContext context, String title, String route,
      String currentPassword) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SecurityDialog(
          title: title,
          currentPassword: currentPassword,
          onPasswordAccepted: () {
            Navigator.pushNamed(context, route);
          },
        );
      },
    );
  }

  Widget _buildActivityCard(
      BuildContext context, String text, String assetPath, String route) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, route);
      },
      child: Container(
        width: 160.0,
        margin: EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            Container(
              height: 150.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 5.0,
                    spreadRadius: 1.0,
                  ),
                ],
                image: DecorationImage(
                  image: assetPath.isNotEmpty
                      ? AssetImage(assetPath)
                      : AssetImage('assets/placeholder.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 10),
            Text(
              text,
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExerciseCard(BuildContext context,
      {required IconData icon, required Color color, required String text}) {
    return Container(
      width: 160.0,
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 5.0,
            spreadRadius: 1.0,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 64, color: Colors.white),
          SizedBox(height: 10.0),
          Text(
            text,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
