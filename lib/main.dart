import 'package:flutter/material.dart';
import 'view/home_page.dart';

void main() {
  runApp(const CountryApp());
}

class CountryApp extends StatelessWidget {
  const CountryApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Consulta de Países',
      theme: ThemeData(
        fontFamily: 'Roboto',
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white, fontSize: 16),
          bodyMedium: TextStyle(color: Colors.white70),
  ),
),
      home: const HomePage(),
    );
  }
}