import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paivakirja/controllers/user_controller.dart';

class VaihdaKayttajaTunnus extends StatefulWidget {
  const VaihdaKayttajaTunnus({Key? key}) : super(key: key);

  @override
  _VaihdaKayttajaTunnusState createState() => _VaihdaKayttajaTunnusState();
}

class _VaihdaKayttajaTunnusState extends State<VaihdaKayttajaTunnus> {
  final UserController _userController = Get.find(tag: 'user_controller');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(onChanged: (value) {
                if (value != '') {
                  _userController.changeUsername(value);
                }
              }),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text('change_username'.tr))
            ],
          ),
        ),
      ),
    );
  }
}
