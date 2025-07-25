import 'package:flutter/material.dart';

class BuildSettingsOption extends StatelessWidget {
  const BuildSettingsOption({
    super.key,
    required this.icon,
    required this.text,
    this.iconColor = Colors.black,
    required this.onPressed,
  });
  final IconData icon;
  final String text;
  final Color iconColor;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
      child: InkWell(
        onTap: onPressed,
        child: Row(
          children: [
            Icon(icon, color: iconColor),
            SizedBox(width: 10),
            Text(
              text,
              style: TextStyle(
                fontSize: 18,
                color: iconColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            Icon(Icons.arrow_forward_ios, size: 16, color: iconColor),
          ],
        ),
      ),
    );
  }
}