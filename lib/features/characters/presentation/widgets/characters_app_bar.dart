import 'package:flutter/material.dart';
import 'package:mortygram/core/common/constants/app_const.dart';
import 'package:mortygram/core/common/extensions/context_ext.dart';

class CharactersAppBar extends StatelessWidget {
  const CharactersAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar.medium(
      title: const Text(AppConst.appName),
      titleTextStyle: context.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
      scrolledUnderElevation: 0.0,
    );
  }
}
