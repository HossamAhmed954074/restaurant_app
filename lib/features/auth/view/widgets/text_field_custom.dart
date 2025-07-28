import 'package:flutter/material.dart';

class TextFieldCustomWidget extends StatefulWidget {
  const TextFieldCustomWidget({
    super.key,
    required this.hintText,
    required this.controller,
    this.isPassword = false,
    this.textInputType = TextInputType.text,
    this.prefixIcon,
    this.enabled = true,
    this.onChanged,
    this.validator,
  });

  final String hintText;
  final TextEditingController controller;
  final bool isPassword;
  final TextInputType textInputType;
  final IconData? prefixIcon;
  final bool enabled;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;

  @override
  State<TextFieldCustomWidget> createState() => _TextFieldCustomWidgetState();
}

class _TextFieldCustomWidgetState extends State<TextFieldCustomWidget> {
  bool _obscureText = true;
  bool _hasFocus = false;

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (hasFocus) {
        setState(() {
          _hasFocus = hasFocus;
        });
      },
      child: TextFormField(
        controller: widget.controller,
        keyboardType: widget.textInputType,
        obscureText: widget.isPassword ? _obscureText : false,
        enabled: widget.enabled,
        onChanged: widget.onChanged,
        validator: widget.validator ?? _defaultValidator,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        style: TextStyle(
          color: widget.enabled ? Colors.white : Colors.white.withValues(alpha: 0.5),
          fontSize: 16,
        ),
        cursorColor: Colors.white,
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: TextStyle(
            color: Colors.white.withValues(alpha: 0.6),
            fontSize: 14,
          ),

          // Prefix icon
          prefixIcon: widget.prefixIcon != null
              ? Icon(
                  widget.prefixIcon,
                  color: _hasFocus
                      ? Colors.white
                      : Colors.white.withValues(alpha: 0.6),
                  size: 20,
                )
              : null,

          // Suffix icon for password fields
          suffixIcon: widget.isPassword
              ? IconButton(
                  onPressed: widget.enabled
                      ? () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        }
                      : null,
                  icon: Icon(
                    _obscureText
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    color: widget.enabled
                        ? Colors.white.withValues(alpha: 0.7)
                        : Colors.white.withValues(alpha: 0.3),
                    size: 20,
                  ),
                )
              : null,

          // Content padding
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),

          // Border styling
          border: _buildBorder(Colors.white.withValues(alpha: 0.3)),
          enabledBorder: _buildBorder(Colors.white.withValues(alpha: 0.3)),
          focusedBorder: _buildBorder(Colors.white),
          errorBorder: _buildBorder(Colors.red.withValues(alpha: 0.7)),
          focusedErrorBorder: _buildBorder(Colors.red),
          disabledBorder: _buildBorder(Colors.white.withValues(alpha: 0.1)),

          // Error styling
          errorStyle: TextStyle(color: Colors.red.shade300, fontSize: 12),

          // Fill color
          filled: true,
          fillColor: Colors.white.withValues(alpha: 0.1),
        ),
      ),
    );
  }

  OutlineInputBorder _buildBorder(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: color, width: 1.5),
    );
  }

  String? _defaultValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'This field is required';
    }

    // Email validation
    if (widget.hintText.toLowerCase().contains('email')) {
      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
        return 'Please enter a valid email address';
      }
    }

    // Password validation
    if (widget.hintText.toLowerCase().contains('password')) {
      if (value.length < 6) {
        return 'Password must be at least 6 characters';
      }
    }

    // Name validation
    if (widget.hintText.toLowerCase().contains('name')) {
      if (value.trim().length < 2) {
        return 'Name must be at least 2 characters';
      }
    }

    return null;
  }
}
