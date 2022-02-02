import 'package:flutter/material.dart';
import 'package:paivakirja/controllers/diary_controller.dart';
import 'views/asetukset_screen.dart';
import 'views/paivakirja_screen.dart';
import 'package:get/get.dart';

class PaivakirjaTabBarView extends StatefulWidget {
  const PaivakirjaTabBarView({Key? key}) : super(key: key);

  @override
  _PaivakirjaTabBarViewState createState() => _PaivakirjaTabBarViewState();
}

class _PaivakirjaTabBarViewState extends State<PaivakirjaTabBarView> {
  final PaivakirjaController _paivakirjaController =
      Get.put(PaivakirjaController(), tag: 'diary_controller');
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text('diary'.tr),
            actions: [
              // Avaa merkinnän lisäystabin
              IconButton(
                  onPressed: () {
                    Get.bottomSheet(BottomSheet(
                        enableDrag: false,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30))),
                        onClosing: () {},
                        builder: (context) {
                          return Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextField(onChanged: (value) {
                                  _paivakirjaController.changeEntryText(value);
                                }),
                                const SizedBox(
                                  height: 8,
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                      _paivakirjaController.addDiaryEntry();
                                      Get.back();
                                    },
                                    child: Text('add'.tr))
                              ],
                            ),
                          );
                        }));
                  },
                  icon: const Icon(
                    Icons.post_add_outlined,
                    size: 30,
                  ))
            ],
            // Tabit asetuksille ja merkinnöille
            bottom: const TabBar(tabs: [
              Tab(
                icon: Icon(Icons.event_note_rounded),
              ),
              Tab(
                icon: Icon(Icons.settings),
              )
            ]),
          ),
          body: TabBarView(
            children: [PaivakirjaScreen(), AsetuksetScreen()],
          ),
        ));
  }
}
