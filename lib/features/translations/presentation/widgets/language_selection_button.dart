import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mortygram/core/common/constants/app_const.dart';
import 'package:mortygram/core/common/extensions/context_ext.dart';
import 'package:mortygram/features/translations/presentation/cubit/translations_cubit.dart';

// Language display names in their native form

class LanguageSelectionButton extends StatefulWidget {
  const LanguageSelectionButton({super.key});

  @override
  State<LanguageSelectionButton> createState() => _LanguageSelectionButtonState();
}

class _LanguageSelectionButtonState extends State<LanguageSelectionButton> {
  final GlobalKey _buttonKey = GlobalKey();

  // Supported locales for the app

  void _showLanguageMenu(BuildContext context, Locale currentLocale) async {
    final RenderBox? button = _buttonKey.currentContext?.findRenderObject() as RenderBox?;
    if (button == null) return;

    final Offset position = button.localToGlobal(Offset.zero);
    final Size size = button.size;

    final Locale? selected = await showMenu<Locale>(
      context: context,
      position: RelativeRect.fromLTRB(
        position.dx,
        position.dy + size.height,
        position.dx + size.width,
        position.dy,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      items: AppConst.supportedLocales.map((Locale locale) {
        final String langCode = locale.languageCode;
        final bool isSelected = locale.languageCode == currentLocale.languageCode;
        final String displayName = AppConst.languageNames[langCode] ?? langCode.toUpperCase();

        return PopupMenuItem<Locale>(
          value: locale,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                displayName,
                style: TextStyle(
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected ? context.colorScheme.primary : null,
                ),
              ),
              if (isSelected) Icon(Icons.check_rounded, color: context.colorScheme.primary, size: 20),
            ],
          ),
        );
      }).toList(),
    );

    if (selected != null && selected != currentLocale && context.mounted) {
      // Change locale using easy_localization
      await context.setLocale(selected);

      // Cache the selected language using the translations cubit
      if (context.mounted) {
        context.read<TranslationsCubit>().cacheSelectedLanguage(selected.languageCode);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final Locale currentLocale = context.locale;

    return IconButton(
      key: _buttonKey,

      onPressed: () => _showLanguageMenu(context, currentLocale),

      icon: Icon(
        Icons.translate_rounded,
        color: context.theme.appBarTheme.foregroundColor,
      ),
    );
  }
}
