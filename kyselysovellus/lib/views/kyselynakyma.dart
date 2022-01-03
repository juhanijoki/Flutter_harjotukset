import 'package:flutter/material.dart';
import '../components/palaute.dart';
import '../api/kysely_api.dart';
import '../components/kysymys.dart';

class Kyselynakyma extends StatefulWidget {
  @override
  KyselynakymaState createState() => KyselynakymaState();
}

class KyselynakymaState extends State {
  var kysymysSanakirja;
  var vastattu = false;
  var vastausOikein = false;

  @override
  initState() {
    super.initState();
    haeKysymys();
  }

// Hakee rajapinnasta uuden kysymyksen.
  haeKysymys() async {
    kysymysSanakirja = await KyselyApi().haeKysymys();
    vastattu = false;

    paivita();
  }

  vastaaKysymykseen(kysymysTunnus, vastausTunnus) async {
    vastausOikein =
        await KyselyApi().lahetaVastaus(kysymysTunnus, vastausTunnus);
    vastattu = true;

    paivita();
  }

  paivita() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (kysymysSanakirja == null) {
      return const Scaffold(body: Text('Kysymystä haetaan'));
    }

    Widget sisalto;
    if (!vastattu) {
      sisalto = Kysymys(kysymysSanakirja, vastaaKysymykseen);
    } else {
      sisalto = Palaute(vastausOikein, haeKysymys);
    }

    return Scaffold(body: SafeArea(child: Center(child: sisalto)));
  }
}
