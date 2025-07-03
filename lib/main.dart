import 'package:flutter/material.dart';
import 'package:myapp/screens/exercises.dart';
import 'package:myapp/screens/home.dart';
import 'package:myapp/screens/myProfile.dart';
import 'package:myapp/screens/tips.dart';
import 'screens/login.dart';
import 'screens/register.dart';
import 'screens/questionnaire.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "My app",
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/questionnaire': (context) => const QuestionnairePage(),
        '/home': (context) => const Home(),
        '/tips': (context) => const TipsPage(),
        '/exercise': (context) => const OfficeExercisesPage(),
        '/profile': (context) => const ProfilePage(),
      },
    );
  }
}
