import 'package:flutter/material.dart';

class OnBoardingData {
  const OnBoardingData({
    required this.title,
    required this.description,
    this.gradient,
    this.image,
    this.icon,
  }) : assert(icon == null || gradient != null, 'If icon is provided, gradient must also be provided');

  final String title;
  final String description;
  final IconData? icon;
  final String? image;
  final List<Color>? gradient;
}
