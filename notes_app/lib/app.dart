import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/notes_screen.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QuickNote',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      initialRoute: '/',
      routes: {
        '/': (_) => LoginScreen(),
        '/notes': (_) => NotesScreen(),
      },
    );
  }
}
