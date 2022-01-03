import 'package:flutter/material.dart';
import '../components/tervehdysteksti.dart';

// Näyttää tekstin ja napin josta siirrytään kyselynäkymään
class Aloitusnakyma extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final nappi = ElevatedButton(
        child: const Text('Kysy kysymys'),
        onPressed: () => Navigator.pushNamed(context, '/kysely'));
    final teksti = Tervehdysteksti();

    final sarake = Column(
      children: [teksti, nappi],
    );

    return Scaffold(
        appBar: AppBar(title: const Text('Kyselysovellus')),
        body: SafeArea(child: Center(child: Container(child: sarake))));
  }
}
