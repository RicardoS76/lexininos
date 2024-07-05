import 'package:flutter/material.dart';

import 'activities/test1/rhyme_game.dart';
import 'activities/test2/test2.dart';
import 'activities/test2/connect_learn_page.dart';
import 'activities/test2/fruits_page.dart';
import 'activities/test2/objects_page.dart';
import 'activities/test3/hidden_words_page.dart';
import 'activities/test4/visual_challenge_page.dart';
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
import 'resultados/results_test1_page.dart';
import 'resultados/results_test2_page.dart';
import 'resultados/results_test3_page.dart';
import 'resultados/results_test4_page.dart';
import 'resultados/results_total_page.dart';

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
        '/results/test1': (context) => ResultsTest1Page(),
        '/results/test2': (context) => ResultsTest2Page(),
        '/results/test3': (context) => ResultsTest3Page(),
        '/results/test4': (context) => ResultsTest4Page(),
        '/results/total': (context) => ResultsTotalPage(),
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
        '/manage_accounts': (context) =>
            ManageAccountsPage(authenticatedUserPassword: password ?? ''),
        '/edit_account': (context) => EditAccountPage(),
        '/contacts': (context) => ContactsPage(),
      },
    );
  }
}
