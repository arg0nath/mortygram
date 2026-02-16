import 'package:flutter/material.dart';
import 'package:mortygram/core/common/constants/app_const.dart';
import 'package:mortygram/core/common/extensions/context_ext.dart';
import 'package:url_launcher/url_launcher.dart';

void openGitHub(BuildContext context) async {
  final Uri githubUri = Uri.parse(AppConst.githubUrl);

  try {
    await launchUrl(githubUri, mode: LaunchMode.externalApplication);
  } catch (e) {
    context.showSnackBar('Could not open GitHub');
  }
}
