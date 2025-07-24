import 'package:flutter/material.dart';

class IconButtonCustomWidget extends StatelessWidget {
  const IconButtonCustomWidget({
    super.key,
    required this.icon,
    required this.onPressed,
  });

  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(0),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        shape: BoxShape.circle,
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon, size: 24, color: Colors.white),
      ),
    );
  }
}