import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mortygram/core/common/constants/app_const.dart';
import 'package:mortygram/features/settings/presentation/widgets/language_selection_sheet.dart';

class LanguageSelectionTile extends StatelessWidget {
  const LanguageSelectionTile({super.key});

  void _showLanguageSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) => const LanguageSelectionSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final String currentLanguageCode = context.locale.languageCode;
    final String displayName = AppConst.languageNames[currentLanguageCode] ?? currentLanguageCode.toUpperCase();

    return ListTile(
      leading: const Icon(Icons.translate_rounded),
      title: Text('settings.language'.tr()),
      subtitle: Text(displayName),
      trailing: const Icon(Icons.chevron_right_rounded),
      onTap: () => _showLanguageSheet(context),
    );
  }
}
