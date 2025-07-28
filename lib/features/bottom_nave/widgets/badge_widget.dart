import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BadgeWidget extends StatelessWidget {
  const BadgeWidget({
    super.key,
    required this.count,
    this.backgroundColor,
    this.textColor,
    this.maxCount = 99,
  });

  final int count;
  final Color? backgroundColor;
  final Color? textColor;
  final int maxCount;

  @override
  Widget build(BuildContext context) {
    if (count <= 0) return const SizedBox.shrink();

    return Container(
      constraints: const BoxConstraints(minWidth: 18, minHeight: 18),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.red,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: (backgroundColor ?? Colors.red).withValues(alpha: 0.3),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        count > maxCount ? '$maxCount+' : count.toString(),
        style: GoogleFonts.poppins(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: textColor ?? Colors.white,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class DotBadgeWidget extends StatelessWidget {
  const DotBadgeWidget({super.key, this.color, this.size = 8.0});

  final Color? color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color ?? Colors.red,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: (color ?? Colors.red).withValues(alpha: 0.3),
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
    );
  }
}
