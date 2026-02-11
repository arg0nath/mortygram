import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mortygram/core/common/res/app_assets.dart';

class CustomLoadingIndicator extends StatelessWidget {
  const CustomLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return LottieBuilder.asset(
      AppAssets.loadingAnimation,
      repeat: true,
      height: 200,
      width: 200,
    );
  }
}
