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
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: (int index) {
        if (index == widget.navigationShell.currentIndex) {
          widget.navigationShell.goBranch(index, initialLocation: true);
        } else {
          widget.navigationShell.goBranch(index);
        }
      },
      showUnselectedLabels: true,
      currentIndex: widget.navigationShell.currentIndex,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(activeIcon: const Icon(FluentIcons.home_12_filled), icon: const Icon(FluentIcons.home_12_regular), label: 'bottomNavigation.home'.tr()),
        BottomNavigationBarItem(activeIcon: const Icon(FluentIcons.settings_16_filled), icon: const Icon(FluentIcons.settings_16_regular), label: 'bottomNavigation.settings'.tr()),
      ],
    );
  }
}
