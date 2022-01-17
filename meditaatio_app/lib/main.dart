import 'package:flutter/material.dart';
import 'views/mainView.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meditaatio app',
      theme: ThemeData.dark().copyWith(
          appBarTheme: const AppBarTheme(backgroundColor: Colors.indigo)),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Meditaatiosovellus'),
        ),
        body: const MainView(),
      ),
    );
  }
}
