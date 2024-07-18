import 'package:flutter/material.dart';

import 'about_us_page.dart'; //importación para AboutUsPage
import 'activities/test1/result_page1.dart'; // Importa la nueva página de resultados
import 'activities/test1/rhyme_game.dart';
import 'activities/test2/connect_learn_page.dart';
import 'activities/test2/fruits_page.dart';
import 'activities/test2/objects_page.dart';
import 'activities/test2/test2.dart';
import 'activities/test3/hidden_words_page.dart';
import 'activities/test4/visual_challenge_page.dart';
import 'centers/atoyatempan_page.dart';
import 'centers/molcaxac_page.dart';
import 'centers/tochtepec_page.dart';
import 'login_page.dart';
import 'main_page.dart';
import 'privacy_policy_page.dart'; // Importa la nueva página de política de privacidad
import 'register_page.dart';
import 'reset_password_page.dart';
import 'settings/contacts_page.dart';
import 'settings/edit_account_page.dart';
import 'settings/manage_accounts_page.dart';
import 'settings_page.dart'; // SettingsPage está directamente en lib
import 'user/help_page.dart';
import 'user/info_page.dart';
import 'user/shared_preferences.dart';
import 'user/user_data_page.dart'; // Nueva importación para UserDataPage
import 'user_page.dart'; // UserPage está directamente en lib
import 'welcome_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final isFirstRun = await SharedPreferencesHelper.isFirstRun();
  final credentials = await SharedPreferencesHelper.getUserCredentials();

  runApp(MyApp(
    isFirstRun: isFirstRun,
    initialRoute:
        isFirstRun ? '/welcome' : (credentials != null ? '/main' : '/register'),
    initialCredentials: credentials,
  ));
}

class MyApp extends StatelessWidget {
  final bool isFirstRun;
  final String initialRoute;
  final Map<String, String>? initialCredentials; // Añadir este parámetro

  MyApp(
      {required this.isFirstRun,
      required this.initialRoute,
      this.initialCredentials});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LEXINIÑOS',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: initialRoute,
      routes: {
        '/main': (context) => MainPage(
              authenticatedUserPassword: initialCredentials?['password'] ?? '',
              name: initialCredentials?['name'] ?? '',
            ),
        '/settings': (context) => SettingsPage(),
        '/user': (context) => UserPage(),
        '/help': (context) => HelpPage(),
        '/info': (context) => InfoPage(),
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/rhyme': (context) => RhymeGame(),
        '/test2': (context) => Test2Page(),
        '/connect_learn': (context) => ConnectLearnPage(),
        '/fruits': (context) => FruitsPage(),
        '/objects': (context) => ObjectsPage(),
        '/hidden_words': (context) => HiddenWordsPage(),
        '/visual_challenge': (context) => VisualChallengePage(),
        '/welcome': (context) => WelcomePage(),
        '/reset_password': (context) => ResetPasswordPage(),
        '/manage_accounts': (context) => ManageAccountsPage(
            authenticatedUserPassword: initialCredentials?['password'] ?? ''),
        '/edit_account': (context) => EditAccountPage(),
        '/contacts': (context) => ContactsPage(),
        '/privacy_policy': (context) => PrivacyPolicyPage(),
        '/about_us': (context) => AboutUsPage(),
        '/user_data': (context) => UserDataPage(),
        '/atoyatempan': (context) => AtoyatempanPage(),
        '/tochtepec': (context) => TochtepecPage(),
        '/molcaxac': (context) => MolcaxacPage(),
        '/results': (context) => ResultsPage(), // Nueva ruta
      },
    );
  }
}
