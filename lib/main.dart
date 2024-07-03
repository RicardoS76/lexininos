import 'package:flutter/material.dart';

import 'activities/image_word_match_game.dart';
import 'activities/initial_final_sounds_game.dart';
import 'activities/interactive_story_game.dart';
import 'activities/letter_puzzle_game.dart';
import 'activities/letter_tracing_game.dart';
import 'activities/rhyme_game.dart';
import 'activities/sound_sequence_game.dart';
import 'activities/word_hunt_game.dart';
import 'activities/word_memory_game.dart';
import 'activities/word_search_game.dart';
import 'centers/atoyatempan_page.dart';
import 'centers/molcaxac_page.dart';
import 'centers/tochtepec_page.dart';
import 'login_page.dart';
import 'main_page.dart';
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
        '/initial_final_sounds': (context) => InitialFinalSoundsGame(),
        '/word_memory': (context) => WordMemoryGame(),
        '/sound_sequence': (context) => SoundSequenceGame(),
        '/letter_tracing': (context) => LetterTracingGame(),
        '/letter_puzzle': (context) => LetterPuzzleGame(),
        '/word_hunt': (context) => WordHuntGame(),
        '/word_search': (context) => WordSearchGame(),
        '/image_word_match': (context) => ImageWordMatchGame(),
        '/interactive_story': (context) => InteractiveStoryGame(),
        '/welcome': (context) => WelcomePage(),
        '/reset_password': (context) => ResetPasswordPage(),
        '/manage_accounts': (context) =>
            ManageAccountsPage(authenticatedUserPassword: password ?? ''),
        '/edit_account': (context) => EditAccountPage(),
        '/atoyatempan': (context) => ZacapalaPage(),
        '/tochtepec': (context) => TochtepecPage(),
        '/molcaxac': (context) => MolcaxacPage(),
        '/contacts': (context) => ContactsPage(),
      },
    );
  }
}
