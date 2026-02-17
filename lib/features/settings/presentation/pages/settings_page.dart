import 'package:flutter/material.dart';
import 'package:mortygram/core/common/extensions/context_ext.dart';
import 'package:mortygram/features/settings/presentation/widgets/app_about_tile.dart';
import 'package:mortygram/features/settings/presentation/widgets/theme_toggle_tile.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings', style: context.textTheme.headlineSmall?.copyWith(fontWeight: .w600)),
      ),
      body: SafeArea(
        child: ListView(
          children: const <Widget>[
            ThemeToggleTile(),
            AppAboutTile(),
          ],
        ),
      ),
    );
  }
}
