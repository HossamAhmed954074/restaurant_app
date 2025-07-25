import 'package:flutter/material.dart';

class IntroComponent extends StatelessWidget {
  const IntroComponent({super.key, required this.imagePath});

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: Image.asset(imagePath, fit: BoxFit.contain)),
      ],
    );
  }
}