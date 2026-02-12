import 'package:flutter/material.dart';
import 'package:mortygram/config/theme/app_palette.dart';
import 'package:mortygram/features/on_boarding/domain/entities/on_boarding_data.dart';

const List<OnBoardingData> onBoardingPages = <OnBoardingData>[
  OnBoardingData(title: 'Welcome to\nMortygram', description: 'Your Rick and Morty wiki', icon: Icons.science_outlined, gradient: AppPalette.blueGradient),
  OnBoardingData(title: 'Discover\n Characters', description: 'Search characters, view details of them', icon: Icons.search_rounded, gradient: AppPalette.purpleGradient),
  OnBoardingData(
    title: 'Share &\nConnect',
    description: 'Share your favorite character and insights with friends. Join the crypto community today!',
    icon: Icons.share_rounded,
    gradient: AppPalette.greenGradient,
  ),
];
