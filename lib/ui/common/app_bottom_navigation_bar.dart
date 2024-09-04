import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sunrisescrob/ui/theme/app_colors.dart';

class AppBottomNavigationBar extends StatelessWidget {
  final StatefulNavigationShell _navigationShell;

  const AppBottomNavigationBar({
    super.key,
    required StatefulNavigationShell navigationShell,
  }) : _navigationShell = navigationShell;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            color: AppColors.grey800,
            width: 0.1,
          ),
        ),
      ),
      child: BottomNavigationBar(
        currentIndex: _navigationShell.currentIndex,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "Discover",
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: "Account",
          ),
        ],
        onTap: (int index) {
          _navigationShell.goBranch(
            index,
            initialLocation: index == _navigationShell.currentIndex,
          );
        },
        selectedItemColor: theme.colorScheme.onSurface,
        unselectedItemColor: theme.colorScheme.onSecondary.withAlpha(128),
        useLegacyColorScheme: false,
        backgroundColor: theme.colorScheme.surface,
        selectedFontSize: 12,
        unselectedFontSize: 11,
        iconSize: 28,
      ),
    );
  }
}
