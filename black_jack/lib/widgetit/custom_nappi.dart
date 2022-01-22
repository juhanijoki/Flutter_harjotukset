import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final void Function() onPressed;
  final String label;
  CustomButton({required this.onPressed, required this.label});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: Colors.yellow,
      onPressed: onPressed,
      child: Text(label),
    );
  }
}
