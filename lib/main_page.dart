import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import 'security_dialog.dart'; // Asegúrate de que la ruta sea correcta

class MainPage extends StatelessWidget {
  final String authenticatedUserPassword;
  final String name;

  MainPage({required this.authenticatedUserPassword, required this.name});

  final PageController _pageController = PageController(viewportFraction: 0.8);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final containerWidth = screenWidth * 0.7; // Ajusta el ancho
    final containerHeight = containerWidth * 1.2; // Ajusta la altura

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
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center, // Centra los elementos
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
                          onPressed: () => _showSecurityDialog(context,
                              'Ajuste', '/settings', authenticatedUserPassword),
                        ),
                        IconButton(
                          icon: Icon(Icons.person,
                              size: 40.0,
                              color: Colors.white), // Icono más grande y blanco
                          onPressed: () => _showSecurityDialog(context,
                              'Usuario', '/user', authenticatedUserPassword),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Center(
                    child: AutoSizeText(
                      'HOLA $name',
                      style: TextStyle(
                        fontSize: 36.0,
                        fontFamily: 'Cocogoose',
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            offset: Offset(2.0, 2.0),
                            blurRadius: 3.0,
                            color: Colors.black,
                          ),
                        ],
                      ),
                      maxLines: 1,
                      minFontSize: 10.0,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(height: 20.0), // Espacio adicional
                  Center(
                    child: ShaderMask(
                      shaderCallback: (bounds) => LinearGradient(
                        colors: [Colors.red, Colors.green, Colors.blue, Colors.yellow],
                      ).createShader(bounds),
                      child: Text(
                        '¡¡A JUGAR!!',
                        style: TextStyle(
                          fontSize: 40.0, // Tamaño de fuente más grande
                          fontFamily: 'Cocogoose',
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              offset: Offset(2.0, 2.0),
                              blurRadius: 3.0,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 40.0), // Espacio adicional para bajar los elementos
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: SizedBox(
                      height: containerHeight + 60, // Ajusta el tamaño del carrusel
                      child: PageView(
                        controller: _pageController,
                        children: [
                          _buildFeatureContainer(context, 'Rimas', '/rhyme', 'assets/rima.jpg', containerWidth, containerHeight),
                          _buildFeatureContainer(context, 'Conecta y Aprende', '/connect_learn', 'assets/sopa.png', containerWidth, containerHeight),
                          _buildFeatureContainer(context, 'Palabras Escondidas', '/hidden_words', 'assets/palabras.jpg', containerWidth, containerHeight),
                          _buildFeatureContainer(context, 'Desafío Visual: Figuras', '/visual_challenge', 'assets/figuras.jpg', containerWidth, containerHeight),
                        ],
                      ),
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

  Widget _buildFeatureContainer(
      BuildContext context, String title, String route, String imagePath, double width, double height) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, route);
      },
      child: Column(
        children: [
          Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.8),
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 5.0,
                  spreadRadius: 1.0,
                ),
              ],
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 10.0),
          Text(
            title,
            style: TextStyle(
              fontSize: 22.0, // Tamaño de fuente más grande
              fontWeight: FontWeight.bold,
              color: Colors.purple,
              fontFamily: 'Cocogoose', // Aplicar la fuente Cocogoose
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
