import 'package:flutter/material.dart';

class AuthButtonCustomWidget extends StatelessWidget {
  const AuthButtonCustomWidget({super.key, required this.text, required this.onPressed});
  final String text;
  final VoidCallback onPressed;


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          gradient: LinearGradient(colors: [Colors.red, Colors.orange]),
      
        ),
        child: Center(child: Text(text,)),
      ),
    );
  }
}