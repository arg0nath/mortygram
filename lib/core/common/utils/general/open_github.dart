import 'package:flutter/material.dart';
import 'package:mortygram/core/common/extensions/context_ext.dart';
import 'package:url_launcher/url_launcher.dart';

void openGitHub(BuildContext context) async {
  final Uri githubUri = Uri.parse('https://github.com/arg0nath');

  if (await canLaunchUrl(githubUri)) {
    await launchUrl(githubUri, mode: LaunchMode.externalApplication);
  } else {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text('Could not open GitHub'), backgroundColor: context.colorScheme.error));
  }
}
