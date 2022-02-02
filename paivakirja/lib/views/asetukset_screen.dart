import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paivakirja/controllers/user_controller.dart';
import 'package:paivakirja/views/vaihda_ktunnus.dart';

class AsetuksetScreen extends StatelessWidget {
  AsetuksetScreen({Key? key}) : super(key: key);

  final UserController _userController =
      Get.put(UserController(), tag: 'user_controller');

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const SizedBox(
            height: 12,
          ),
          _userController.username == 'Unknown user'
              ? Obx(() => Text(
                    _userController.username,
                    style: Get.textTheme.headline5,
                  ))
              : Text(
                  'username'.tr,
                  style: Get.textTheme.headline5,
                ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  onPressed: () {
                    Get.updateLocale(const Locale('fi_FI'));
                  },
                  child: const Text('Suomi')),
              ElevatedButton(
                  onPressed: () {
                    Get.updateLocale(const Locale('sve_SE'));
                  },
                  child: const Text('Svenska')),
              ElevatedButton(
                  onPressed: () {
                    Get.updateLocale(const Locale('en_US'));
                  },
                  child: const Text('English')),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
              onPressed: () {
                Get.to(() => const VaihdaKayttajaTunnus());
              },
              child: Text("change_username".tr)),
        ],
      ),
    );
  }
}
