import 'package:flutter/material.dart';
import 'package:mortygram/config/theme/presentation/app_palette.dart';
import 'package:mortygram/core/common/res/app_assets.dart';
import 'package:mortygram/features/on_boarding/domain/entities/on_boarding_data.dart';

const List<OnBoardingData> onBoardingPages = <OnBoardingData>[
  OnBoardingData(
    title: 'Wubba Lubba,\nMortygram',
    description: 'Your portal to the Rick and Morty universe.',
    image: AppAssets.mortygramLogoPng,
  ),
  OnBoardingData(
    title: 'Explore the\nMultiverse',
    description: 'Search, filter, and dive into character details across every dimension.',
    icon: Icons.search_rounded,
    gradient: AppPalette.greenGradient,
  ),
  OnBoardingData(
    title: 'Share the\nMadness',
    description: 'Show off your favorite characters and spread the interdimensional chaos.',
    icon: Icons.share_rounded,
    gradient: AppPalette.blueGradient,
  ),
];
