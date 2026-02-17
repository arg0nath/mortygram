import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mortygram/features/settings/presentation/widgets/language_selection_sheet.dart';

class LanguageSelectionTile extends StatelessWidget {
  const LanguageSelectionTile({super.key});

  // Language display names in their native form
  static const Map<String, String> _languageNames = <String, String>{
    'en': 'English',
    'el': 'Ελληνικά',
  };

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
    final String displayName = _languageNames[currentLanguageCode] ?? currentLanguageCode.toUpperCase();

    return ListTile(
      leading: const Icon(Icons.translate_rounded),
      title: Text('settings.language'.tr()),
      subtitle: Text(displayName),
      trailing: const Icon(Icons.chevron_right_rounded),
      onTap: () => _showLanguageSheet(context),
    );
  }
}
