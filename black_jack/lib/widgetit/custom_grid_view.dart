import 'package:flutter/material.dart';

class CardGridView extends StatelessWidget {
  const CardGridView({
    Key? key,
    required this.kortit,
  }) : super(key: key);

  final List<Image> kortit;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: GridView.builder(
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemCount: kortit.length,
        itemBuilder: (context, index) {
          // Näyttää jakajan kortit
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 13.0),
            child: kortit[index],
          );
        },
      ),
    );
  }
}
