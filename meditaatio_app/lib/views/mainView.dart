import 'dart:io';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import '../models/item.dart';
import 'package:bordered_text/bordered_text.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  MainViewState createState() => MainViewState();
}

class MainViewState extends State<MainView> {
  final AudioPlayer audioPlayer = AudioPlayer();
  int? _playingIndex;

  final List<Item> items = [
    Item(
        imagePath: 'images/forest.jpeg',
        audioPath: 'audios/forest.mp3',
        name: 'Forest'),
    Item(
        imagePath: 'images/night.jpeg',
        audioPath: 'audios/night.mp3',
        name: 'Night'),
    Item(
        imagePath: 'images/ocean.jpeg',
        audioPath: 'audios/ocean.mp3',
        name: 'Ocean'),
    Item(
        imagePath: 'images/waterfall.jpeg',
        audioPath: 'audios/waterfall.mp3',
        name: 'Waterfall'),
    Item(
        imagePath: 'images/wind.jpeg',
        audioPath: 'audios/wind.mp3',
        name: 'Wind'),
  ];

  // Widget getIcon(int index) {
  //   if (index == _playingIndex) {
  //     return const Icon(
  //       Icons.stop,
  //       size: 34,
  //     );
  //   } else {
  //     return const Icon(
  //       Icons.play_arrow,
  //       size: 34,
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              height: 100,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(items[index].imagePath))),
              child: ListTile(
                leading: BorderedText(
                  child: Text(items[index].name,
                      style: GoogleFonts.anton(
                          fontSize: 34, fontWeight: FontWeight.bold)),
                  strokeWidth: 5,
                  strokeColor: Colors.black,
                ),
                trailing: IconButton(
                  icon: _playingIndex == index
                      ? const FaIcon(
                          Icons.stop_circle_outlined,
                          size: 34,
                        )
                      : const FaIcon(
                          Icons.play_circle_fill_outlined,
                          size: 34,
                        ),
                  onPressed: () async {
                    if (_playingIndex == index) {
                      setState(() {
                        _playingIndex = null;
                      });
                      audioPlayer.stop();
                    } else {
                      try {
                        await audioPlayer.setAsset(items[index].audioPath);
                        audioPlayer.play();
                        setState(() {
                          _playingIndex = index;
                        });
                      } on SocketException {
                        // ignore: avoid_print
                        print('No internet here');
                      } catch (error) {
                        // ignore: avoid_print
                        print(error);
                      }
                    }
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
