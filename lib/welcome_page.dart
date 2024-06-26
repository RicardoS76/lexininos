import 'package:flutter/material.dart';
import 'dart:ui';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Imagen de fondo
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/background.jpg'), 
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Efecto de difuminado superior
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 300,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 4, 237, 241).withOpacity(0.85),
                    Color.fromARGB(255, 4, 112, 235).withOpacity(0.0),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
          // Efecto de difuminado inferior
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 300,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 1, 187, 243).withOpacity(0.85),
                    Colors.white.withOpacity(0.0),
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),
          ),
          // Contenido sobre la imagen de fondo
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(height: 80.0), // Espacio desde la parte superior
              RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontSize: 50.0,
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
                    TextSpan(text: 'L', style: TextStyle(color: Colors.orangeAccent, shadows: _createShadows())),
                    TextSpan(text: 'E', style: TextStyle(color: Colors.blueAccent, shadows: _createShadows())),
                    TextSpan(text: 'X', style: TextStyle(color: Colors.greenAccent, shadows: _createShadows())),
                    TextSpan(text: 'I', style: TextStyle(color: Colors.redAccent, shadows: _createShadows())),
                    TextSpan(text: 'N', style: TextStyle(color: Colors.purpleAccent, shadows: _createShadows())),
                    TextSpan(text: 'I', style: TextStyle(color: Colors.yellowAccent, shadows: _createShadows())),
                    TextSpan(text: 'Ñ', style: TextStyle(color: Colors.lightBlueAccent, shadows: _createShadows())),
                    TextSpan(text: 'O', style: TextStyle(color: Colors.orangeAccent, shadows: _createShadows())),
                    TextSpan(text: 'S', style: TextStyle(color: Colors.blueAccent, shadows: _createShadows())),
                  ],
                ),
              ),
              Spacer(),
              Column(
                children: [
                  Text(
                    'Aprender jugando. La aventura más divertida.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Column(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/register');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.pink.shade100,
                            padding: EdgeInsets.symmetric(vertical: 15.0),
                            textStyle: TextStyle(fontSize: 20),
                          ),
                          child: Center(child: Text('Soy nuevo en Lexiniños')),
                        ),
                        SizedBox(height: 10.0),
                        OutlinedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/login');
                          },
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: Colors.white),
                            padding: EdgeInsets.symmetric(vertical: 15.0),
                            textStyle: TextStyle(fontSize: 20),
                          ),
                          child: Center(child: Text('Ya tengo una cuenta', style: TextStyle(color: Colors.white))),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30.0), // Espacio desde la parte inferior
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<Shadow> _createShadows() {
    return [
      Shadow(
        offset: Offset(1.0, 1.0),
        blurRadius: 2.0,
        color: Colors.black,
      ),
    ];
  }
}
