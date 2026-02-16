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
        SharePlus.instance.share(ShareParams(text: 'Wubba lubba dub dub! Check out $characterName on Mortygram!'));
      },
      icon: const Icon(Icons.share_rounded),
    );
  }
}
