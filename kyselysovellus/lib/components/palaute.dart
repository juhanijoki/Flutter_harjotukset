import 'package:flutter/material.dart';
import 'tyylitelty_teksti.dart';

// Palauttaa parametrina annetun oikein totuusarvon perusteella
// palautteen ja näyttää seuraava-napin.
class Palaute extends StatelessWidget {
  final bool oikein;
  final VoidCallback haeKysymysFunktio;
  Palaute(this.oikein, this.haeKysymysFunktio);

  @override
  Widget build(BuildContext context) {
    String teksti = 'Oikein meni!';
    if (!oikein) {
      teksti = 'Väärin meni, hups!';
    }

    return Column(children: [
      TyyliteltyTeksti(teksti),
      ElevatedButton(
        child: const Text('Seuraava!'),
        onPressed: haeKysymysFunktio,
      )
    ]);
  }
}
