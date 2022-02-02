import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:paivakirja/models/diary_entry_model.dart';
import 'package:intl/intl.dart';

class PaivakirjaController extends GetxController {
  final RxList<PaivakirjaEntry> _diaryEntries = <PaivakirjaEntry>[].obs;

  List<PaivakirjaEntry> get diaryEntries => [..._diaryEntries].toList();

  String _entryText = '';

  final GetStorage _getStorage = GetStorage();

  @override
  void onInit() {
    final List<dynamic> list = _getStorage.read('diary_entries') ?? [];

    List<PaivakirjaEntry> data = [];

    for (var element in list) {
      final String date = element['dateTime'];
      final String content = element['content'];

      data.add(PaivakirjaEntry(dateString: date, content: content));
    }

    _diaryEntries.value = data;
    super.onInit();
  }

  void addDiaryEntry() {
    if (_entryText != '') {
      initializeDateFormatting();

      DateFormat format = DateFormat.yMMMMEEEEd(Get.locale.toString());

      String dateString = format.format(DateTime.now());
      _diaryEntries
          .add(PaivakirjaEntry(dateString: dateString, content: _entryText));

      List data = [];

      for (var element in _diaryEntries) {
        data.add({
          'dateTime': element.dateString,
          'content': element.content,
        });
      }

      _getStorage.write('diary_entries', data);
    }

    _entryText = '';
  }

  void changeEntryText(String text) {
    _entryText = text;
  }

  void deleteDiaryEntry(int index) {
    _diaryEntries.removeAt(index);

    List data = [];

    for (var element in _diaryEntries) {
      data.add({
        'dateTime': element.dateString,
        'content': element.content,
      });
    }

    _getStorage.write('diary_entries', data);
  }
}
