import 'package:flutter/material.dart';

class Vastausvaihtoehto extends StatelessWidget {
  final String vastausteksti;
  final VoidCallback vastaaFunktio;
  Vastausvaihtoehto(this.vastausteksti, this.vastaaFunktio);

  @override
  Widget build(BuildContext context) {
    return ListTile(title: Text(vastausteksti), onTap: vastaaFunktio);
  }
}
