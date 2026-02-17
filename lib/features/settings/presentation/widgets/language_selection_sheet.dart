import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mortygram/core/common/constants/app_const.dart';
import 'package:mortygram/core/common/extensions/context_ext.dart';
import 'package:mortygram/features/translations/presentation/cubit/translations_cubit.dart';

class LanguageSelectionSheet extends StatefulWidget {
  const LanguageSelectionSheet({super.key});

  @override
  State<LanguageSelectionSheet> createState() => _LanguageSelectionSheetState();
}

class _LanguageSelectionSheetState extends State<LanguageSelectionSheet> {
  late String _selectedLanguageCode;

  // Supported locales for the app

  // Language display names in their native form

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _selectedLanguageCode = context.locale.languageCode;
  }

  void _applyLanguage() async {
    final Locale newLocale = AppConst.supportedLocales.firstWhere(
      (Locale locale) => locale.languageCode == _selectedLanguageCode,
      orElse: () => const Locale('en', 'US'),
    );

    // Change locale using easy_localization
    await context.setLocale(newLocale);

    // Cache the selected language using the translations cubit
    if (mounted) {
      context.read<TranslationsCubit>().cacheSelectedLanguage(_selectedLanguageCode);

      // Close the bottom sheet
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const .all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'settings.language'.tr(),
                style: context.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: const Icon(Icons.close_rounded),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...AppConst.supportedLocales.map((Locale locale) {
            final String langCode = locale.languageCode;
            final String displayName = AppConst.languageNames[langCode] ?? langCode.toUpperCase();
            final bool isSelected = langCode == _selectedLanguageCode;

            return RadioListTile<String>(
              value: langCode,
              groupValue: _selectedLanguageCode,
              onChanged: (String? value) {
                if (value != null) {
                  setState(() {
                    _selectedLanguageCode = value;
                  });
                }
              },
              title: Text(
                displayName,
                style: TextStyle(
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
              activeColor: context.colorScheme.primary,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            );
          }),
          const SizedBox(height: 24),
          FilledButton(
            onPressed: _applyLanguage,
            style: FilledButton.styleFrom(padding: const .symmetric(vertical: 16)),
            child: Text('filters.applyFilters'.tr()),
          ),
        ],
      ),
    );
  }
}
