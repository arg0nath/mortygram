import 'package:easy_localization/easy_localization.dart';
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
      aboutBoxChildren: <Widget>[
        Text('about.description'.tr()),
        Text('about.credits'.tr()),
        const SizedBox(height: 16),
        Text('about.developer'.tr()),
        const SizedBox(height: 8),
        const GithubButton(),
      ],
    );
  }
}
