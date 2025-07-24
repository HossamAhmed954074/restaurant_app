import 'package:flutter/material.dart';

class TextFieldCustomWidget extends StatefulWidget {
  const TextFieldCustomWidget({
    super.key,
    required this.hintText,
    required this.controller,
  });
  final String hintText;
  final TextEditingController controller;
  @override
  State<TextFieldCustomWidget> createState() => _TextFieldCustomWidgetState();
}

class _TextFieldCustomWidgetState extends State<TextFieldCustomWidget> {
  bool obscureText = true;



  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'This field is required';
        }
        if (widget.hintText == 'Email' && !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
          return 'Please enter a valid email';
        }
        if (widget.hintText == 'Password' && value.length < 6) {
          return 'Password must be at least 6 characters';
        }
        if (widget.hintText == 'Confirm Password' && value != widget.controller.text) {
          return 'Passwords do not match';
        }
        return null;
       
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: widget.controller,
      obscureText: widget.hintText == 'Password' ? obscureText : false,
      cursorColor: Colors.brown,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        suffixIcon: widget.hintText == 'Password' ||
                widget.hintText == 'Confirm Password' ||
                widget.hintText == 'Old Password' ||
                widget.hintText == 'New Password'
            ? obscureText == true
                  ? IconButton(
                      onPressed: () {
                        setState(() {
                          obscureText = !obscureText;
                        });
                      },
                      icon: Icon(Icons.visibility, color: Colors.white),
                    )
                  : IconButton(
                      onPressed: () {
                        setState(() {
                        obscureText = !obscureText;
                        });
                      },
                      icon: Icon(Icons.visibility_off, color: Colors.white),
                    )
            : SizedBox.shrink(),
        hintText: widget.hintText,
        hintStyle: TextStyle(color: Colors.white),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
    );
  }
}