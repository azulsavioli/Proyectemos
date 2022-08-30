import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyectemos/app/modules/agenda/agenda_page.dart';
import 'package:proyectemos/app/modules/home/home_page.dart';
import 'package:proyectemos/app/modules/login/login_page.dart';
import 'package:proyectemos/app/modules/onboarding/onboarding_page.dart';
import 'package:proyectemos/app/modules/profile/profile_page.dart';
import 'package:proyectemos/app/modules/tarefas_cumpridas/tarefas_cumpridas_page.dart';
import 'package:proyectemos/app/modules/tarefas_incompletas/tarefas_incompletas_page.dart';
import 'package:proyectemos/app/modules/tutorial/tutorial_page.dart';
import 'package:proyectemos/commons/auth_check.dart';
import 'package:proyectemos/commons/google_sign_in.dart';
import 'package:proyectemos/commons/styles.dart';

class Proyectemos extends StatelessWidget {
  const Proyectemos({Key? key}) : super(key: key);
  static const String title = '¡Proyectemos!';

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
      create: (context) => GoogleSignInProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        theme: ThemeData(
            primaryColor: ThemeColors.blue,
            secondaryHeaderColor: ThemeColors.yellow),
        initialRoute: '/',
        routes: {
          '/': (context) => const AuthCheck(),
          '/home': (context) => const HomePage(),
          '/login': (context) => const LoginPage(),
          '/onboarding': (context) => const OnboardingPage(),
          '/profile': (context) => const ProfilePage(),
          '/tarefas_cumplidas': (context) => const TarefasCompletasPage(),
          '/tarefas_pendientes': (context) => const TarefasIncompletasPage(),
          '/agenda': (context) => const AgendaPage(),
          '/tutorial': (context) => const TutorialPage(),
        },
      ));
}
