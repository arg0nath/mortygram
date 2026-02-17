import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class ShareCharacterButton extends StatelessWidget {
  const ShareCharacterButton({
    required this.characterName,
    super.key,
  });

  final String characterName;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        SharePlus.instance.share(ShareParams(text: 'characterDetails.shareMessage'.tr(namedArgs: <String, String>{'name': characterName})));
      },
      icon: const Icon(Icons.share_rounded),
    );
  }
}
