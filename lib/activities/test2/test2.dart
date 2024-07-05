import 'package:flutter/material.dart';

class Test2Page extends StatelessWidget {
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
          SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Conecta y Aprende',
                      style: TextStyle(
                        fontSize: 36.0,
                        fontFamily: 'Cocogoose',
                        fontWeight: FontWeight.bold,
                        color: Colors.purple,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      'Elige lo que quieras jugar hoy',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontFamily: 'Cocogoose',
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 40.0),
                    Expanded(
                      child: ListView(
                        children: [
                          _buildOptionCard(
                            context,
                            title: 'Animales',
                            imagePath: 'assets/animales.jpg',
                            route: '/connect_learn',
                          ),
                          SizedBox(height: 20.0),
                          _buildOptionCard(
                            context,
                            title: 'Frutas',
                            imagePath: 'assets/frutas.jpg',
                            route: '/fruits',
                          ),
                          SizedBox(height: 20.0),
                          _buildOptionCard(
                            context,
                            title: 'Objetos',
                            imagePath: 'assets/objetos.jpg',
                            route: '/objects',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOptionCard(BuildContext context, {required String title, required String imagePath, required String route}) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double containerSize = screenWidth * 0.8; // Ajusta el tamaño del contenedor

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, route);
      },
      child: Column(
        children: [
          Container(
            width: containerSize,
            height: containerSize, // Altura para hacer el contenedor cuadrado
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  spreadRadius: 5,
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
              fontSize: 24.0,
              fontFamily: 'Cocogoose',
              fontWeight: FontWeight.bold,
              color: Colors.purple,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
