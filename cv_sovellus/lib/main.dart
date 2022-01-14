import 'package:flutter/material.dart';
import 'views/cv_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CV app',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: const CV_page(),
    );
  }
}
