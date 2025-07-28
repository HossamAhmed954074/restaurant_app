import 'package:flutter/material.dart';

class BuildSettingsOption extends StatelessWidget {
  const BuildSettingsOption({
    super.key,
    required this.icon,
    required this.text,
    this.iconColor = Colors.black,
    required this.onPressed,
    this.trailing,
    this.subtitle,
  });

  final IconData icon;
  final String text;
  final Color iconColor;
  final VoidCallback onPressed;
  final Widget? trailing;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey.withValues(alpha: 0.05),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(12),
          splashColor: iconColor.withValues(alpha: 0.1),
          highlightColor: iconColor.withValues(alpha: 0.05),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: Row(
              children: [
                // Icon with background
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: iconColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: iconColor, size: 20),
                ),

                const SizedBox(width: 16),

                // Text content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        text,
                        style: TextStyle(
                          fontSize: 16,
                          color: iconColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      if (subtitle != null) ...[
                        const SizedBox(height: 2),
                        Text(
                          subtitle!,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),

                // Trailing widget or default arrow
                trailing ??
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: iconColor.withValues(alpha: 0.7),
                    ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
