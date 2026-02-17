import 'package:flutter/material.dart';
import 'package:mortygram/core/common/constants/app_const.dart';
import 'package:mortygram/core/common/res/app_assets.dart';
import 'package:mortygram/core/common/widgets/github_button.dart';

class AppAboutTile extends StatelessWidget {
  const AppAboutTile({super.key});

  @override
  Widget build(BuildContext context) {
    return AboutListTile(
      applicationName: AppConst.appName,
      icon: const Icon(Icons.info_outline_rounded),
      applicationIcon: Image.asset(AppAssets.mortygramLogoPng, width: 50, height: 50),
      aboutBoxChildren: const <Widget>[
        Text('Mortygram is a Rick and Morty fan app built with Flutter.'),
        Text('Data provided by the Rick and Morty API. App icon by Google Gemini. Lottie animations by LottieFiles.'),
        SizedBox(height: 16),
        Text('Developed by arg0nath'),
        SizedBox(height: 8),
        GithubButton(),
      ],
    );
  }
}
