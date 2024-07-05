import 'package:flutter/material.dart';

import 'activities/rhyme_game.dart';
import 'activities/connect_learn_page.dart'; // Nueva página
import 'activities/hidden_words_page.dart'; // Nueva página
import 'activities/visual_challenge_page.dart'; // Nueva página
import 'main_page.dart';
import 'login_page.dart';
import 'register_page.dart';
import 'reset_password_page.dart';
import 'settings_page.dart';
import 'user/account_info_page.dart';
import 'user/edit_account_page.dart';
import 'user/help_page.dart';
import 'user/info_page.dart';
import 'user/manage_accounts_page.dart';
import 'user/results_page.dart';
import 'user/shared_preferences.dart';
import 'user/user_data_page.dart';
import 'user/contacts_page.dart';
import 'user_page.dart';
import 'welcome_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final credentials = await SharedPreferencesHelper.getUserCredentials();
  final isFirstRun = await SharedPreferencesHelper.isFirstRun();
  runApp(MyApp(
      isLoggedIn: credentials != null,
      isFirstRun: isFirstRun,
      password: credentials?['password'],
      name: credentials?['name']));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  final bool isFirstRun;
  final String? password;
  final String? name;

  MyApp(
      {required this.isLoggedIn,
      required this.isFirstRun,
      this.password,
      this.name});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LEXINIÑOS',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: isFirstRun
          ? WelcomePage()
          : (isLoggedIn && password != null && name != null
              ? MainPage(
                  authenticatedUserPassword: password!,
                  name: name!,
                )
              : LoginPage()),
      routes: {
        '/main': (context) => MainPage(
              authenticatedUserPassword: password!,
              name: name!,
            ),
        '/settings': (context) => SettingsPage(),
        '/user': (context) => UserPage(),
        '/account_info': (context) => AccountInfoPage(),
        '/user_data': (context) => UserDataPage(),
        '/help': (context) => HelpPage(),
        '/info': (context) => InfoPage(),
        '/results': (context) => ResultsPage(),
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/rhyme': (context) => RhymeGame(),
        '/connect_learn': (context) => ConnectLearnPage(),
        '/hidden_words': (context) => HiddenWordsPage(),
        '/visual_challenge': (context) => VisualChallengePage(),
        '/welcome': (context) => WelcomePage(),
        '/reset_password': (context) => ResetPasswordPage(),
        '/manage_accounts': (context) =>
            ManageAccountsPage(authenticatedUserPassword: password ?? ''),
        '/edit_account': (context) => EditAccountPage(),
        '/contacts': (context) => ContactsPage(),
      },
    );
  }
}
