import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mortygram/core/common/extensions/context_ext.dart';
import 'package:mortygram/core/common/res/app_assets.dart';
import 'package:mortygram/core/common/utils/general/open_github.dart';

class GithubButton extends StatelessWidget {
  const GithubButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
      label: const Text('GitHub'),
      icon: SvgPicture.asset(
        AppAssets.githubLogoSvg,
        colorFilter: ColorFilter.mode(
          context.colorScheme.onPrimary,
          BlendMode.srcIn,
        ),
        width: 24,
        height: 24,
      ),
      onPressed: () async => openGitHub(context),
    );
  }
}
