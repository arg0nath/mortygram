import 'package:flutter/material.dart';

/// Simple model to hold onboarding page data
class OnBoardingData {
  const OnBoardingData({
    required this.title,
    required this.description,
    this.image,
    this.icon,
    this.gradient,
  }) : assert(icon == null || gradient != null, 'If icon is provided, gradient must also be provided');

  final String title;
  final String description;
  final String? image;
  final IconData? icon;
  final List<Color>? gradient;
}
