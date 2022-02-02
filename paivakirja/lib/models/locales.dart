import 'package:get/get.dart';

class Locales extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        "en_US": {
          'change_username': 'Change Username',
          'diary': 'Diary',
          'add': 'Add',
          'username': 'Username'
        },
        'fi_FI': {
          'change_username': 'Vaihda käyttäjätunnus',
          'diary': 'Päiväkirja',
          'add': 'Lisää',
          'username': 'Käyttäjätunnus'
        },
        'sve_SE': {'change_username': 'Andra ID', 'username': 'Användare'},
      };
}
