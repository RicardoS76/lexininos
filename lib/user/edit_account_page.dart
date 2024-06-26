import 'package:flutter/material.dart';

import '../baseDatos/database_helper.dart';

class EditAccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> user =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    final TextEditingController _usernameController =
        TextEditingController(text: user['nombre_usuario']);
    final TextEditingController _emailController =
        TextEditingController(text: user['correo_electronico']);
    final TextEditingController _passwordController =
        TextEditingController(text: user['contrasena_hash']);
    bool _isObscure = true;

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
                  // Encabezado con icono de cuenta y título
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.edit, color: Colors.purple, size: 40.0),
                      SizedBox(width: 10),
                      Text(
                        'Editar Cuenta',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.purple,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 40),
                  // Contenido para editar la cuenta
                  Expanded(
                    child: Center(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _buildTextField(
                                  _usernameController, 'Nombre de usuario'),
                              SizedBox(height: 20),
                              _buildTextField(
                                  _emailController, 'Correo electrónico'),
                              SizedBox(height: 20),
                              StatefulBuilder(
                                builder: (context, setState) {
                                  return TextField(
                                    controller: _passwordController,
                                    decoration: InputDecoration(
                                      labelText: 'Contraseña',
                                      filled: true,
                                      fillColor: Colors.white.withOpacity(0.3),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                        borderSide: BorderSide.none,
                                      ),
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          _isObscure
                                              ? Icons.visibility_off
                                              : Icons.visibility,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _isObscure = !_isObscure;
                                          });
                                        },
                                      ),
                                    ),
                                    obscureText: _isObscure,
                                  );
                                },
                              ),
                              SizedBox(height: 20),
                              ElevatedButton(
                                onPressed: () async {
                                  final updatedUser = {
                                    'id_usuario': user['id_usuario'],
                                    'nombre_usuario': _usernameController.text,
                                    'correo_electronico': _emailController.text,
                                    'contrasena_hash': _passwordController.text,
                                  };

                                  final DatabaseHelper dbHelper =
                                      DatabaseHelper();
                                  await dbHelper.updateUser(updatedUser);

                                  Navigator.of(context).pop(true);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.pink.shade100,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 50, vertical: 15),
                                  textStyle: TextStyle(fontSize: 20),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                ),
                                child: Text('Guardar'),
                              ),
                            ],
                          ),
                        ),
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

  Widget _buildTextField(TextEditingController controller, String labelText) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        filled: true,
        fillColor: Colors.white.withOpacity(0.3),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
