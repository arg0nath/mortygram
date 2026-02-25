import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mortygram/config/theme/presentation/app_palette.dart';
import 'package:mortygram/core/common/res/app_assets.dart';
import 'package:mortygram/features/on_boarding/presentation/models/on_boarding_data.dart';

List<OnBoardingData> onBoardingPages() => <OnBoardingData>[
  OnBoardingData(
    title: 'onboarding.page1.title'.tr(),
    description: 'onboarding.page1.description'.tr(),
    image: AppAssets.mortygramLogoPng,
  ),
  OnBoardingData(
    title: 'onboarding.page2.title'.tr(),
    description: 'onboarding.page2.description'.tr(),
    icon: Icons.search_rounded,
    gradient: AppPalette.greenGradient,
  ),
  OnBoardingData(
    title: 'onboarding.page3.title'.tr(),
    description: 'onboarding.page3.description'.tr(),
    icon: Icons.share_rounded,
    gradient: AppPalette.blueGradient,
  ),
];
