import 'package:flutter/material.dart';

class AuthButtonCustomWidget extends StatelessWidget {
  const AuthButtonCustomWidget({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.backgroundColor,
    this.textColor,
    this.height = 56,
  });

  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final Color? backgroundColor;
  final Color? textColor;
  final double height;

  @override
  Widget build(BuildContext context) {
    final isEnabled = onPressed != null && !isLoading;

    return Container(
      width: double.infinity,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: isEnabled
            ? LinearGradient(
                colors: backgroundColor != null
                    ? [backgroundColor!, backgroundColor!.withValues(alpha: 0.8)]
                    : [const Color(0xFF6C63FF), const Color(0xFF4834D4)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            : null,
        color: !isEnabled ? Colors.white.withValues(alpha: 0.2) : null,
        boxShadow: isEnabled
            ? [
                BoxShadow(
                  color: (backgroundColor ?? const Color(0xFF6C63FF))
                      .withValues(alpha: 0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ]
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: isEnabled ? onPressed : null,
          borderRadius: BorderRadius.circular(16),
          splashColor: Colors.white.withValues(alpha: 0.2),
          highlightColor: Colors.white.withValues(alpha: 0.1),
          child: Center(
            child: isLoading ? _buildLoadingIndicator() : _buildButtonText(),
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(
              textColor ?? Colors.white,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Text(
          'Please wait...',
          style: TextStyle(
            color: textColor ?? Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildButtonText() {
    return Text(
      text,
      style: TextStyle(
        color: onPressed != null
            ? (textColor ?? Colors.white)
            : Colors.white.withValues(alpha: 0.5),
        fontSize: 16,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
      ),
    );
  }
}
