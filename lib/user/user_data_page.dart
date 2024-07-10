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
    String? username = await SharedPreferencesHelper.getUserUsername();
    if (username != null) {
      DatabaseHelper dbHelper = DatabaseHelper();
      Map<String, dynamic>? userData = await dbHelper.getUser(username);
      String? avatar = await SharedPreferencesHelper.getUserAvatar();
      if (userData != null) {
        setState(() {
          emailController.text = userData['correo_electronico'];
          nameController.text = userData['nombre'];
          usernameController.text = userData['nombre_usuario'];
          selectedAvatar = avatar ?? 'assets/avatares/avatar1.png';
        });
      }
    }
  }

  Future<void> saveUserData() async {
    String? username = await SharedPreferencesHelper.getUserUsername();
    if (username != null) {
      DatabaseHelper dbHelper = DatabaseHelper();
      Map<String, dynamic> userData = {
        'nombre_usuario': usernameController.text,
        'nombre': nameController.text,
        'correo_electronico': emailController.text,
        'avatar': selectedAvatar,
      };
      Map<String, dynamic>? existingUserData = await dbHelper.getUser(username);
      if (existingUserData != null) {
        userData['id_usuario'] = existingUserData['id_usuario'];
        await dbHelper.updateUser(userData);
        await SharedPreferencesHelper.saveUserAvatar(selectedAvatar);
        print('Usuario actualizado');
        Navigator.pushReplacementNamed(context, '/main');
      }
    }
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
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back,
                            color: Colors.deepPurple, size: 30.0),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      SizedBox(width: 10),
                      Flexible(
                        child: Text(
                          'Datos de usuario',
                          style: TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple,
                            fontFamily: 'Cocogoose',
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    child: Center(
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        elevation: 10,
                        child: Container(
                          width: screenWidth * 0.8,
                          padding: const EdgeInsets.all(24.0),
                          child: ListView(
                            shrinkWrap: true,
                            children: [
                              Center(
                                child: Column(
                                  children: [
                                    CircleAvatar(
                                      backgroundImage:
                                          AssetImage(selectedAvatar),
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
                                leading:
                                    Icon(Icons.person, color: Colors.purple),
                                title: TextField(
                                  controller: nameController,
                                  decoration: InputDecoration(
                                    labelText: 'Nombre',
                                    suffixIcon:
                                        Icon(Icons.edit, color: Colors.purple),
                                  ),
                                ),
                              ),
                              ListTile(
                                leading:
                                    Icon(Icons.email, color: Colors.purple),
                                title: TextField(
                                  controller: emailController,
                                  decoration: InputDecoration(
                                    labelText: 'Correo Electrónico',
                                    suffixIcon:
                                        Icon(Icons.edit, color: Colors.purple),
                                  ),
                                ),
                              ),
                              ListTile(
                                leading: Icon(Icons.account_circle,
                                    color: Colors.purple),
                                title: TextField(
                                  controller: usernameController,
                                  decoration: InputDecoration(
                                    labelText: 'Nombre de Usuario',
                                    suffixIcon:
                                        Icon(Icons.edit, color: Colors.purple),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              Text(
                                'Selecciona un Avatar',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.purple),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
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
                                          ? Icon(Icons.check,
                                              color: Colors.white)
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
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 50, vertical: 15),
                                    textStyle: TextStyle(fontSize: 18),
                                  ),
                                  child: Text('Guardar',
                                      style: TextStyle(color: Colors.white)),
                                ),
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
}
