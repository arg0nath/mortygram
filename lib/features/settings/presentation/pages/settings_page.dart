import 'package:flutter/material.dart';
import 'package:mortygram/features/settings/presentation/widgets/app_about_tile.dart';
import 'package:mortygram/features/settings/presentation/widgets/theme_toggle_tile.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
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
