import 'dart:convert';
import 'package:http/http.dart';
import '../storage/kayttajatiedot.dart';

class KyselyApi {
  // Luo uuden tunnuksen get-pyynnöllä rajapintaan
  luoTunnus() async {
    var response =
        await get(Uri.parse('https://deno-quiz-api.herokuapp.com/users/new'));
    var sanakirja = jsonDecode(response.body);
    return sanakirja['userId'];
  }

// Hakee kysymyksen tietylle käyttäjälle rajapinnasta
  haeKysymys() async {
    var tunnus = await haeTunnus();
    var response = await get(Uri.parse(
        'https://deno-quiz-api.herokuapp.com/questions?userId=$tunnus'));
    return jsonDecode(response.body);
  }

// Tarkistaa onko tunnusta ja luo tarvittaessa uuden.
// Palauttaa halutun tunnuksen.
  haeTunnus() async {
    var onTunnus = await Kayttajatiedot().onTunnus();
    if (!onTunnus) {
      var tunnus = await luoTunnus();
      await Kayttajatiedot().asetaTunnus(tunnus);
    }

    return await Kayttajatiedot().haeTunnus();
  }

// Saa parametrina kysymyksen ja vastauksen tunnuksen.
// Hakee käyttäjän ja kyselystä rajapintaan saatu sanakirja
// palauttaa totuusarvon sanakirjan correct-arvon mukaan.
  lahetaVastaus(questionId, answerOptionId) async {
    var tunnus = await haeTunnus();
    var data = {
      "userId": tunnus,
      "questionId": questionId,
      "answerOptionId": answerOptionId
    };

    var response = await post(
        Uri.parse('https://deno-quiz-api.herokuapp.com/answers'),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode(data));

    var sanakirja = jsonDecode(response.body);

    return sanakirja['correct'];
  }
}
