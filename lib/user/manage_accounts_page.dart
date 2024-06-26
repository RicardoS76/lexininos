import 'package:flutter/material.dart';
import '../baseDatos/database_helper.dart';
import '../security_dialog.dart';

class ManageAccountsPage extends StatefulWidget {
  final String authenticatedUserPassword;

  ManageAccountsPage({required this.authenticatedUserPassword});

  @override
  _ManageAccountsPageState createState() => _ManageAccountsPageState();
}

class _ManageAccountsPageState extends State<ManageAccountsPage> {
  late Future<List<Map<String, dynamic>>> _usersFuture;

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  void _loadUsers() {
    final DatabaseHelper dbHelper = DatabaseHelper();
    setState(() {
      _usersFuture = dbHelper.getAllUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
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
                  // Encabezado con icono de cuentas y título
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.manage_accounts,
                          color: Colors.purple, size: 40.0),
                      SizedBox(width: 10),
                      Text(
                        'Cuentas del dispositivo',
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.purple,
                          fontFamily: 'Cocogoose',
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 40),
                  // Lista de cuentas
                  Expanded(
                    child: FutureBuilder<List<Map<String, dynamic>>>(
                      future: _usersFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text('Error al cargar las cuentas'));
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return Center(
                              child: Text('No hay cuentas registradas'));
                        } else {
                          return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              final user = snapshot.data![index];
                              return Container(
                                margin: EdgeInsets.symmetric(vertical: 10.0),
                                padding: EdgeInsets.all(16.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 5.0,
                                      spreadRadius: 1.0,
                                    ),
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            user['nombre_usuario'],
                                            style: TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.purple,
                                              fontFamily: 'Cocogoose',
                                            ),
                                          ),
                                          Text(
                                            user['correo_electronico'],
                                            style: TextStyle(
                                              fontSize: 16.0,
                                              color: Colors.purple.shade700,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.edit,
                                          color: Colors.purple),
                                      onPressed: () {
                                        _showSecurityDialog(
                                          context,
                                          'Editar cuenta',
                                          widget.authenticatedUserPassword,
                                          () async {
                                            final result =
                                                await Navigator.pushNamed(
                                              context,
                                              '/edit_account',
                                              arguments: user,
                                            );
                                            if (result == true) {
                                              _loadUsers();
                                            }
                                          },
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        }
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

  void _showSecurityDialog(BuildContext context, String title,
      String currentPassword, Function onPasswordAccepted) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SecurityDialog(
          title: title,
          currentPassword: currentPassword,
          onPasswordAccepted: () {
            onPasswordAccepted();
          },
        );
      },
    );
  }
}
