import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paivakirja/controllers/diary_controller.dart';

class PaivakirjaScreen extends StatelessWidget {
  PaivakirjaScreen({Key? key}) : super(key: key);

  final PaivakirjaController _diaryController =
      Get.find(tag: 'diary_controller');

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Obx(
        () => _diaryController.diaryEntries.isEmpty
            ? const Text('Mitäs kuuluu...')
            : ListView.separated(
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  _diaryController
                                      .diaryEntries[index].dateString,
                                  style: Get.textTheme.headline6),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                _diaryController.diaryEntries[index].content,
                                style: Get.textTheme.headline6,
                              ),
                            ]),
                        IconButton(
                            onPressed: () {
                              _diaryController.deleteDiaryEntry(index);
                            },
                            icon: const Icon(
                              Icons.remove_circle_outline,
                              color: Colors.redAccent,
                              size: 30,
                            ))
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) => const Divider(
                      height: 5,
                    ),
                itemCount: _diaryController.diaryEntries.length),
      ),
    );
  }
}
