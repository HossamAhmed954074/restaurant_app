import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class EnhancedActionButton extends StatefulWidget {
  const EnhancedActionButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.icon,
    this.backgroundColor,
    this.foregroundColor,
    this.isTablet = false,
  });

  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final IconData? icon;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final bool isTablet;

  @override
  State<EnhancedActionButton> createState() => _EnhancedActionButtonState();
}

class _EnhancedActionButtonState extends State<EnhancedActionButton>
    with TickerProviderStateMixin {
  late AnimationController _pressController;
  late AnimationController _shimmerController;
  late Animation<double> _pressAnimation;
  late Animation<double> _shimmerAnimation;

  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    _pressController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );

    _shimmerController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _pressAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _pressController, curve: Curves.easeInOut),
    );

    _shimmerAnimation = Tween<double>(begin: -2.0, end: 2.0).animate(
      CurvedAnimation(parent: _shimmerController, curve: Curves.easeInOut),
    );

    _shimmerController.repeat();
  }

  void _handleTapDown(TapDownDetails details) {
    setState(() {
      _isPressed = true;
    });
    _pressController.forward();
    HapticFeedback.lightImpact();
  }

  void _handleTapUp(TapUpDetails details) {
    setState(() {
      _isPressed = false;
    });
    _pressController.reverse();
  }

  void _handleTapCancel() {
    setState(() {
      _isPressed = false;
    });
    _pressController.reverse();
  }

  @override
  void dispose() {
    _pressController.dispose();
    _shimmerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = widget.backgroundColor ?? Colors.brown.shade600;
    final foregroundColor = widget.foregroundColor ?? Colors.white;

    return AnimatedBuilder(
      animation: _pressAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _pressAnimation.value,
          child: GestureDetector(
            onTapDown: widget.onPressed != null ? _handleTapDown : null,
            onTapUp: widget.onPressed != null ? _handleTapUp : null,
            onTapCancel: _handleTapCancel,
            onTap: widget.onPressed,
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: backgroundColor.withValues(alpha: 0.3),
                    blurRadius: _isPressed ? 8 : 12,
                    offset: Offset(0, _isPressed ? 2 : 6),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Stack(
                  children: [
                    // Main button container
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: widget.isTablet ? 20 : 16,
                        horizontal: 32,
                      ),
                      decoration: BoxDecoration(
                        color: backgroundColor,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: _buildButtonContent(foregroundColor),
                    ),

                    // Shimmer effect
                    if (!widget.isLoading)
                      AnimatedBuilder(
                        animation: _shimmerAnimation,
                        builder: (context, child) {
                          return Positioned.fill(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Transform.translate(
                                offset: Offset(
                                  _shimmerAnimation.value * 200,
                                  0,
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.transparent,
                                        Colors.white.withValues(alpha: 0.2),
                                        Colors.transparent,
                                      ],
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildButtonContent(Color foregroundColor) {
    if (widget.isLoading) {
      return Center(
        child: SizedBox(
          height: 24,
          width: 24,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(foregroundColor),
          ),
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          widget.text,
          style: GoogleFonts.poppins(
            fontSize: widget.isTablet ? 18 : 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
            color: foregroundColor,
          ),
        ),
        if (widget.icon != null) ...[
          const SizedBox(width: 8),
          Icon(
            widget.icon,
            size: widget.isTablet ? 24 : 20,
            color: foregroundColor,
          ),
        ],
      ],
    );
  }
}
