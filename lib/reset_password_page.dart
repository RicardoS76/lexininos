import 'package:flutter/material.dart';

import 'baseDatos/database_helper.dart';

class ResetPasswordPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final DatabaseHelper _dbHelper = DatabaseHelper();

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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/logo.png', height: 200.0),
                  SizedBox(height: 20.0),
                  Text(
                    'Recuperar Contraseña',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  TextField(
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
                  ),
                  SizedBox(height: 20.0),
                  TextField(
                    controller: _newPasswordController,
                    decoration: InputDecoration(
                      hintText: 'Nueva contraseña',
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.3),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    obscureText: true,
                  ),
                  SizedBox(height: 20.0),
                  TextField(
                    controller: _confirmPasswordController,
                    decoration: InputDecoration(
                      hintText: 'Confirmar nueva contraseña',
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.3),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    obscureText: true,
                  ),
                  SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () async {
                      String email = _emailController.text;
                      String newPassword = _newPasswordController.text;
                      String confirmPassword = _confirmPasswordController.text;

                      if (email.isNotEmpty &&
                          newPassword.isNotEmpty &&
                          confirmPassword.isNotEmpty) {
                        if (newPassword == confirmPassword) {
                          Map<String, dynamic>? user =
                              await _dbHelper.getUserByEmail(email);
                          if (user != null) {
                            user['contrasena_hash'] = newPassword;
                            await _dbHelper.updateUser(user);
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Contraseña Actualizada'),
                                  content: Text(
                                      'Tu contraseña ha sido actualizada correctamente.'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        Navigator.of(context)
                                            .pushReplacementNamed('/login');
                                      },
                                      child: Text('Cerrar'),
                                    ),
                                  ],
                                );
                              },
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content:
                                    Text('Correo electrónico no encontrado.'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Las contraseñas no coinciden.'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
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
                    child: Text('Actualizar Contraseña'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
