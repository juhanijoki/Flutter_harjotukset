// Toteuta tänne luokka Tervehdysteksti
import 'package:flutter/material.dart';
import '../storage/kayttajatiedot.dart';
import 'tyylitelty_teksti.dart';

// Tarkistaa onko tuttu käyttäjä ja palauttaa
// sen mukaisen tekstin
class Tervehdysteksti extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Kayttajatiedot().tuttuKayttaja(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data) {
              return TyyliteltyTeksti('Heippa taas!');
            } else {
              return TyyliteltyTeksti('Tervetuloa!');
            }
          } else if (snapshot.hasError) {
            return const Text('Virhe käyttäjätietojen hakemisessa.');
          } else {
            return const Text('Haetaan käyttäjätietoja..');
          }
        });
  }
}
