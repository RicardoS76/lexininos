import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import 'security_dialog.dart';
import 'user/shared_preferences.dart';

class MainPage extends StatefulWidget {
  final String authenticatedUserPassword;
  final String name;
  final String avatarPath;

  MainPage({
    required this.authenticatedUserPassword,
    required this.name,
    required this.avatarPath,
  });

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late String avatarPath;

  @override
  void initState() {
    super.initState();
    avatarPath = widget.avatarPath;
    loadAvatar();
  }

  Future<void> loadAvatar() async {
    String? avatar = await SharedPreferencesHelper.getUserAvatar();
    setState(() {
      avatarPath = avatar ?? 'assets/avatares/avatar1.png';
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
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
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 40.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: Icon(Icons.settings,
                              size: 40.0, color: Colors.white),
                          onPressed: () => _showSecurityDialog(
                              context,
                              'Ajuste',
                              '/settings',
                              widget.authenticatedUserPassword),
                        ),
                        GestureDetector(
                          onTap: () async {
                            await Navigator.pushNamed(context, '/user_data');
                            loadAvatar(); // Cargar avatar después de regresar de UserDataPage
                          },
                          child: CircleAvatar(
                            backgroundImage: AssetImage(avatarPath),
                            radius: 40.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Center(
                    child: AutoSizeText(
                      'HOLA ${widget.name}',
                      style: TextStyle(
                        fontSize: screenWidth * 0.09,
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
                  SizedBox(height: 20.0),
                  Center(
                    child: ShaderMask(
                      shaderCallback: (bounds) => LinearGradient(
                        colors: [
                          Colors.red,
                          Colors.green,
                          Colors.blue,
                          Colors.yellow
                        ],
                      ).createShader(bounds),
                      child: Text(
                        '¡¡A JUGAR!!',
                        style: TextStyle(
                          fontSize: screenWidth * 0.1,
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
                  SizedBox(height: 40.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        final containerWidth = constraints.maxWidth * 0.7;
                        final containerHeight = containerWidth * 1.2;

                        return SizedBox(
                          height: containerHeight + 60,
                          child: PageView(
                            controller: PageController(viewportFraction: 0.8),
                            children: [
                              _buildFeatureContainer(
                                  context,
                                  'Rimas',
                                  '/rhyme',
                                  'assets/rima.jpg',
                                  containerWidth,
                                  containerHeight),
                              _buildFeatureContainer(
                                  context,
                                  'Conecta y Aprende',
                                  '/test2',
                                  'assets/palabras.jpg',
                                  containerWidth,
                                  containerHeight),
                              _buildFeatureContainer(
                                  context,
                                  'Palabras Escondidas',
                                  '/hidden_words',
                                  'assets/sopa.png',
                                  containerWidth,
                                  containerHeight),
                              _buildFeatureContainer(
                                  context,
                                  'Desafío Visual: Figuras',
                                  '/visual_challenge',
                                  'assets/figuras.jpg',
                                  containerWidth,
                                  containerHeight),
                            ],
                          ),
                        );
                      },
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
            Navigator.pushNamed(context, route).then((_) => loadAvatar());
          },
        );
      },
    );
  }

  Widget _buildFeatureContainer(BuildContext context, String title,
      String route, String imagePath, double width, double height) {
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
                  blurRadius: 10.0,
                  spreadRadius: 2.0,
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
              fontSize: width * 0.06,
              fontWeight: FontWeight.bold,
              color: Colors.purple,
              fontFamily: 'Cocogoose',
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
