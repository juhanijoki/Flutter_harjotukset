import 'package:shared_preferences/shared_preferences.dart';

// Luodaan asetukset ja tarkistetaan onko asetuksissa haluttua
// käyttäjää, palauttaa true mikäli käyttäjä on tuttu.
class Kayttajatiedot {
  tuttuKayttaja() async {
    SharedPreferences asetukset = await SharedPreferences.getInstance();
    var tuttuKayttaja = asetukset.containsKey('TUTTU_KAYTTAJA');
    asetukset.setString('TUTTU_KAYTTAJA', 'KYLLA');
    return tuttuKayttaja;
  }

// Tarkistaa onko käyttäjätunnusta olemassa.
  onTunnus() async {
    SharedPreferences asetukset = await SharedPreferences.getInstance();
    return asetukset.containsKey('KAYTTAJATUNNUS');
  }

// Luo uuden käyttäjätunnuksen annetun parametrin nimellä.
  asetaTunnus(tunnus) async {
    SharedPreferences asetukset = await SharedPreferences.getInstance();
    asetukset.setString('KAYTTAJATUNNUS', tunnus);
  }

// Hakee käyttäjätunnuksen.
  haeTunnus() async {
    SharedPreferences asetukset = await SharedPreferences.getInstance();
    return asetukset.getString('KAYTTAJATUNNUS');
  }
}
