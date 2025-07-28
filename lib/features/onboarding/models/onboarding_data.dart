import 'package:flutter/material.dart';

class OnboardingData {
  final String imagePath;
  final String title;
  final String subtitle;
  final String description;
  final Color primaryColor;
  final Color secondaryColor;

  OnboardingData({
    required this.imagePath,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.primaryColor,
    required this.secondaryColor,
  });
}
