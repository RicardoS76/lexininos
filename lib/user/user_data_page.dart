import 'package:flutter/material.dart';

import '../baseDatos/database_helper.dart';
import '../user/shared_preferences.dart';

class UserDataPage extends StatefulWidget {
  @override
  _UserDataPageState createState() => _UserDataPageState();
}

class _UserDataPageState extends State<UserDataPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  String selectedAvatar = 'assets/avatares/avatar1.png';

  final List<String> avatars = [
    'assets/avatares/avatar1.png',
    'assets/avatares/avatar2.png',
    'assets/avatares/avatar3.png',
    'assets/avatares/avatar4.png',
  ];

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  Future<void> loadUserData() async {
    String? username = await SharedPreferencesHelper
        .getUserUsername(); // Obtén el nombre de usuario del usuario actual

    if (username != null) {
      DatabaseHelper dbHelper = DatabaseHelper();
      Map<String, dynamic>? userData = await dbHelper.getUser(username);

      if (userData != null) {
        setState(() {
          emailController.text = userData['correo_electronico'];
          nameController.text = userData['nombre'];
          usernameController.text = userData['nombre_usuario'];
          // Si el avatar se guarda en la base de datos, asignar aquí
          selectedAvatar = userData['avatar'] ?? 'assets/avatares/avatar1.png';
        });
      }
    }
  }

  Future<void> saveUserData() async {
    String? username = await SharedPreferencesHelper
        .getUserUsername(); // Obtén el nombre de usuario del usuario actual

    if (username != null) {
      DatabaseHelper dbHelper = DatabaseHelper();
      Map<String, dynamic> userData = {
        'nombre_usuario': usernameController.text,
        'nombre': nameController.text,
        'correo_electronico': emailController.text,
        // Guarda el avatar seleccionado
        'avatar': selectedAvatar,
      };

      // Obtén el id_usuario del usuario actual
      Map<String, dynamic>? existingUserData = await dbHelper.getUser(username);
      if (existingUserData != null) {
        userData['id_usuario'] = existingUserData['id_usuario'];
        await dbHelper.updateUser(userData);
        print('Usuario actualizado');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Datos de usuario'),
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage(selectedAvatar),
                    radius: 60,
                  ),
                  SizedBox(height: 10),
                  Text(
                    usernameController.text,
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    nameController.text,
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    emailController.text,
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            ListTile(
              leading: Icon(Icons.person, color: Colors.purple),
              title: TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Nombre',
                  suffixIcon: Icon(Icons.edit, color: Colors.purple),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.email, color: Colors.purple),
              title: TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Correo Electrónico',
                  suffixIcon: Icon(Icons.edit, color: Colors.purple),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.account_circle, color: Colors.purple),
              title: TextField(
                controller: usernameController,
                decoration: InputDecoration(
                  labelText: 'Nombre de Usuario',
                  suffixIcon: Icon(Icons.edit, color: Colors.purple),
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Selecciona un Avatar',
              style: TextStyle(fontSize: 18, color: Colors.purple),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: avatars.map((avatar) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedAvatar = avatar;
                    });
                  },
                  child: CircleAvatar(
                    backgroundImage: AssetImage(avatar),
                    radius: 30,
                    child: selectedAvatar == avatar
                        ? Icon(Icons.check, color: Colors.white)
                        : null,
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: saveUserData,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  textStyle: TextStyle(fontSize: 18),
                ),
                child: Text('Guardar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
