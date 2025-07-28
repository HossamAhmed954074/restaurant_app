
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TapBarCustomWidget extends StatelessWidget {
  const TapBarCustomWidget({
    super.key,
    required this.onTap,
    required this.title, required this.isTap,
  });
  final Function onTap;
  final String title;
  final bool isTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () {
        onTap();
      },
      child: Container(
        margin: const EdgeInsets.all(16.0),
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: isTap ?  Colors.orange : Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4.0,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Center(child: Text(title, style: GoogleFonts.poppins(fontSize: 12))),
      ),
    );
  }
}
