import 'package:flutter/material.dart';
import 'package:paivakirja/diary_tab_bar_view.dart';
import 'package:get/get.dart';
import 'models/locales.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'diary'.tr,
      theme: ThemeData(
          appBarTheme: const AppBarTheme(backgroundColor: Colors.orange),
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.green)),
      home: const PaivakirjaTabBarView(),
      translations: Locales(),
      locale: const Locale('en', 'US'),
    );
  }
}
