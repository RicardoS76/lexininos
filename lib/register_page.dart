import 'package:flutter/material.dart';

import 'baseDatos/database_helper.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final DatabaseHelper _dbHelper = DatabaseHelper();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/logo.png', height: 200.0),
                    SizedBox(height: 20.0),
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
                          TextSpan(
                              text: 'L',
                              style: TextStyle(
                                  color: Color(0xFFF7941E),
                                  shadows: _createShadows())),
                          TextSpan(
                              text: 'E',
                              style: TextStyle(
                                  color: Color(0xFF19B5FE),
                                  shadows: _createShadows())),
                          TextSpan(
                              text: 'X',
                              style: TextStyle(
                                  color: Color(0xFF34C759),
                                  shadows: _createShadows())),
                          TextSpan(
                              text: 'I',
                              style: TextStyle(
                                  color: Color(0xFFFF3B30),
                                  shadows: _createShadows())),
                          TextSpan(
                              text: 'N',
                              style: TextStyle(
                                  color: Color(0xFF5856D6),
                                  shadows: _createShadows())),
                          TextSpan(
                              text: 'I',
                              style: TextStyle(
                                  color: Color(0xFFFFCC00),
                                  shadows: _createShadows())),
                          TextSpan(
                              text: 'Ñ',
                              style: TextStyle(
                                  color: Color(0xFF5AC8FA),
                                  shadows: _createShadows())),
                          TextSpan(
                              text: 'O',
                              style: TextStyle(
                                  color: Color(0xFF34C759),
                                  shadows: _createShadows())),
                          TextSpan(
                              text: 'S',
                              style: TextStyle(
                                  color: Color(0xFFF7941E),
                                  shadows: _createShadows())),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        hintText: 'Nombre de usuario',
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.3),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingresa un nombre de usuario';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        hintText: 'Correo electrónico',
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.3),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingresa un correo electrónico';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Contraseña',
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.3),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide.none,
                        ),
                        suffixIcon: Icon(Icons.visibility_off),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingresa una contraseña';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      controller: _confirmPasswordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Confirmar contraseña',
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.3),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide.none,
                        ),
                        suffixIcon: Icon(Icons.visibility_off),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor confirma tu contraseña';
                        }
                        if (value != _passwordController.text) {
                          return 'Las contraseñas no coinciden';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20.0),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          Map<String, dynamic> row = {
                            'nombre_usuario': _usernameController.text,
                            'contrasena_hash': _passwordController
                                .text, // En producción, asegura de hacer hashing de la contraseña
                            'correo_electronico': _emailController.text,
                          };
                          final id = await _dbHelper.insertUser(row);
                          print('Registro exitoso. ID: $id. Datos: $row');
                          Navigator.pushReplacementNamed(context, '/main');
                        } else {
                          print('Por favor llena todos los campos');
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pink.shade100,
                        padding:
                            EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                        textStyle: TextStyle(fontSize: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      child: Text('Registrarse'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
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
