import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainAppBottomBar extends StatefulWidget {
  const MainAppBottomBar({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  @override
  State<MainAppBottomBar> createState() => _MainAppBottomBarState();
}

class _MainAppBottomBarState extends State<MainAppBottomBar> {
  static const List<({IconData active, IconData inactive, String labelKey})> _items = [
    (active: FluentIcons.home_12_filled, inactive: FluentIcons.home_12_regular, labelKey: 'bottomNavigation.home'),
    (active: FluentIcons.settings_16_filled, inactive: FluentIcons.settings_16_regular, labelKey: 'bottomNavigation.settings'),
  ];

  void _onTap(int index) {
    if (index == widget.navigationShell.currentIndex) {
      widget.navigationShell.goBranch(index, initialLocation: true);
    } else {
      widget.navigationShell.goBranch(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    final currentIndex = widget.navigationShell.currentIndex;

    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: ColoredBox(
          color: colorScheme.surface.withAlpha(160),
          child: Padding(
            padding: EdgeInsets.only(bottom: bottomPadding),
            child: SizedBox(
              height: kBottomNavigationBarHeight,
              child: Row(
                children: List.generate(_items.length, (index) {
                  final item = _items[index];
                  final isSelected = index == currentIndex;
                  final color = isSelected ? colorScheme.primary : colorScheme.onSurface.withAlpha(140);

                  return Expanded(
                    child: InkWell(
                      onTap: () => _onTap(index),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(isSelected ? item.active : item.inactive, color: color),
                          const SizedBox(height: 4),
                          Text(
                            item.labelKey.tr(),
                            style: TextStyle(fontSize: 12, color: color),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
