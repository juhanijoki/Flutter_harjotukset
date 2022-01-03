import 'package:flutter/material.dart';
import 'views/aloitusnakyma.dart';
import 'views/kyselynakyma.dart';

main() {
  final sovellus = MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => Aloitusnakyma(),
      '/kysely': (context) => Kyselynakyma()
    },
  );

  runApp(sovellus);
}
