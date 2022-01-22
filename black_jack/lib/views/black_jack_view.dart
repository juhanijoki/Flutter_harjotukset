import 'dart:math';
import 'package:flutter/material.dart';
import '../widgetit/custom_nappi.dart';
import '../widgetit/custom_grid_view.dart';

class BlackJackView extends StatefulWidget {
  const BlackJackView({Key? key}) : super(key: key);

  @override
  State<BlackJackView> createState() => BlackJackViewState();
}

class BlackJackViewState extends State<BlackJackView> {
  bool _isGameStarted = false;

// Korttikuvat
  List<Image> pelaajaKortit = [];
  List<Image> jakajaKortit = [];

// Kortit
  String? jakajaEkaKortti;
  String? jakajaTokaKortti;

  String? pelaajaEkaKortti;
  String? pelaajaTokaKortti;
// Pisteet
  int jakajaPisteet = 0;
  int pelaajaPisteet = 0;
// Korttipakka
  final Map<String, int> korttiPakka = {
    "cards/2.1.png": 2,
    "cards/2.2.png": 2,
    "cards/2.3.png": 2,
    "cards/2.4.png": 2,
    "cards/3.1.png": 3,
    "cards/3.2.png": 3,
    "cards/3.3.png": 3,
    "cards/3.4.png": 3,
    "cards/4.1.png": 4,
    "cards/4.2.png": 4,
    "cards/4.3.png": 4,
    "cards/4.4.png": 4,
    "cards/5.1.png": 5,
    "cards/5.2.png": 5,
    "cards/5.3.png": 5,
    "cards/5.4.png": 5,
    "cards/6.1.png": 6,
    "cards/6.2.png": 6,
    "cards/6.3.png": 6,
    "cards/6.4.png": 6,
    "cards/7.1.png": 7,
    "cards/7.2.png": 7,
    "cards/7.3.png": 7,
    "cards/7.4.png": 7,
    "cards/8.1.png": 8,
    "cards/8.2.png": 8,
    "cards/8.3.png": 8,
    "cards/8.4.png": 8,
    "cards/9.1.png": 9,
    "cards/9.2.png": 9,
    "cards/9.3.png": 9,
    "cards/9.4.png": 9,
    "cards/10.1.png": 10,
    "cards/10.2.png": 10,
    "cards/10.3.png": 10,
    "cards/10.4.png": 10,
    "cards/J1.png": 10,
    "cards/J2.png": 10,
    "cards/J3.png": 10,
    "cards/J4.png": 10,
    "cards/Q1.png": 10,
    "cards/Q2.png": 10,
    "cards/Q3.png": 10,
    "cards/Q4.png": 10,
    "cards/K1.png": 10,
    "cards/K2.png": 10,
    "cards/K3.png": 10,
    "cards/K4.png": 10,
    "cards/A1.png": 11,
    "cards/A2.png": 11,
    "cards/A3.png": 11,
    "cards/A4.png": 11,
  };

  Map<String, int> peliKortit = {};

  @override
  void initState() {
    super.initState();
    peliKortit.addAll(korttiPakka);
  }

// Aloittaa uuden pelin täydellä korttipakalla
  void aloitaUusiPeli() {
    _isGameStarted = true;
    peliKortit = {};
    peliKortit.addAll(korttiPakka);
    pelaajaKortit = [];
    jakajaKortit = [];

    Random random = Random();

    String kortinEkaKey =
        peliKortit.keys.elementAt(random.nextInt(peliKortit.keys.length));

    peliKortit.removeWhere((key, value) => key == kortinEkaKey);

    String kortinTokaKey =
        peliKortit.keys.elementAt(random.nextInt(peliKortit.keys.length));

    peliKortit.removeWhere((key, value) => key == kortinTokaKey);
    // Random kortti 1 pelaajalle
    String korttiKolmeKey =
        peliKortit.keys.elementAt(random.nextInt(peliKortit.keys.length));

    peliKortit.removeWhere((key, value) => key == korttiKolmeKey);

    // Random kortti 2 pelaajalle
    String korttiNeljaKey =
        peliKortit.keys.elementAt(random.nextInt(peliKortit.keys.length));

    peliKortit.removeWhere((key, value) => key == korttiNeljaKey);

    jakajaEkaKortti = kortinEkaKey;
    jakajaTokaKortti = kortinTokaKey;

    pelaajaEkaKortti = korttiKolmeKey;
    pelaajaTokaKortti = korttiNeljaKey;

    // jakajan korttien kuvat
    jakajaKortit.add(Image.asset(jakajaEkaKortti!));
    jakajaKortit.add(Image.asset(jakajaTokaKortti!));

    // Jakajan korttien yhteenlaskettu arvo
    jakajaPisteet =
        korttiPakka[jakajaEkaKortti]! + korttiPakka[jakajaTokaKortti]!;

    // Pelaajan korttien kuvat
    pelaajaKortit.add(Image.asset(pelaajaEkaKortti!));
    pelaajaKortit.add(Image.asset(pelaajaTokaKortti!));

    // Pelaajan korttien yhteenlaskettu arvo
    pelaajaPisteet =
        korttiPakka[pelaajaEkaKortti]! + korttiPakka[pelaajaTokaKortti]!;

    if (jakajaPisteet <= 14) {
      String kolmasJakajanKortti =
          peliKortit.keys.elementAt(random.nextInt(peliKortit.length));

      jakajaKortit.add(Image.asset(kolmasJakajanKortti));

      jakajaPisteet = jakajaPisteet + korttiPakka[kolmasJakajanKortti]!;
    }

    // Päivittää tilanteen UI:ssa
    setState(() {});
  }

// lisää pelaajalla uuden kortin
  void lisaaKortti() {
    Random random = Random();
    if (peliKortit.isNotEmpty) {
      String korttiKey =
          peliKortit.keys.elementAt(random.nextInt(peliKortit.length));

      peliKortit.removeWhere((key, value) => key == korttiKey);

      pelaajaKortit.add(Image.asset(korttiKey));

      pelaajaPisteet = pelaajaPisteet + korttiPakka[korttiKey]!;

      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isGameStarted
        ? SafeArea(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                Column(
                  children: [
                    Text(
                      'Jakajan pisteet: $jakajaPisteet',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: jakajaPisteet <= 21
                            ? Colors.green[900]
                            : Colors.red[900],
                      ),
                    ),
                    // Jakajan kortit
                    CardGridView(kortit: jakajaKortit),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      'Pelaajan pisteet: $pelaajaPisteet',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: pelaajaPisteet <= 21
                              ? Colors.green[900]
                              : Colors.red[900]),
                    ),
                    CardGridView(kortit: pelaajaKortit),
                  ],
                ),
                IntrinsicWidth(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      CustomButton(
                          onPressed: () {
                            lisaaKortti();
                          },
                          label: 'Uusi kortti'),
                      CustomButton(
                          onPressed: () {
                            aloitaUusiPeli();
                          },
                          label: 'Seuraava rundi')
                    ],
                  ),
                )
              ]))
        : Center(
            child: CustomButton(
            onPressed: () => {
              setState(() {
                aloitaUusiPeli();
              })
            },
            label: 'Aloita peli',
          ));
  }
}
