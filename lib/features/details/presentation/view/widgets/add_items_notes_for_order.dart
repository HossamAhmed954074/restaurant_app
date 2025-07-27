import 'package:flutter/material.dart';
import 'package:resturant_app/core/utils/styles/app_text_style.dart';

/// Improved notes input widget
class AddItemNotesForOrder extends StatelessWidget {
  const AddItemNotesForOrder({super.key, required this.notesController});

  final TextEditingController notesController;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: notesController,
        maxLines: 3,
        maxLength: 200,
        decoration: InputDecoration(
          labelText: 'Special Instructions (Optional)',
          labelStyle: const TextStyle(color: Colors.grey, fontSize: 14),
          hintText: 'e.g., Extra spicy, no onions, etc.',
          hintStyle: AppTextStyle.caption.copyWith(color: Colors.grey[500]),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey[300]!),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.blue, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey[300]!),
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.all(16),
          counterStyle: AppTextStyle.caption.copyWith(color: Colors.grey[500]),
        ),
        style: const TextStyle(fontSize: 16),
        textInputAction: TextInputAction.done,
      ),
    );
  }
}
