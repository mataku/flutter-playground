import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:state_app/ui/common/app_checkbox.dart';
import 'package:state_app/ui/common/theme_notifier.dart';
import 'package:state_app/ui/theme/app_theme.dart';

class ThemeSelectionScreen extends ConsumerWidget {
  const ThemeSelectionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeNotifier = ref.watch(themeNotifierProvider);
    final currentTheme = themeNotifier.appTheme ?? AppTheme.dark;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Theme'),
        ),
        body: _ThemeSelectionContent(
          currentTheme: currentTheme,
          onTap: (theme) {
            themeNotifier.setCurrentTheme(theme);
          },
        ),
      ),
    );
  }
}

class _ThemeSelectionContent extends StatelessWidget {
  final AppTheme currentTheme;
  final void Function(AppTheme) onTap;

  const _ThemeSelectionContent({
    required this.currentTheme,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: AppTheme.values
          .map(
            (theme) => Padding(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                top: 8,
                bottom: 8,
              ),
              child: _ThemeSelection(
                appTheme: theme,
                selected: currentTheme == theme,
                onTap: () {
                  if (currentTheme == theme) {
                    return;
                  }
                  onTap(theme);
                },
              ),
            ),
          )
          .toList(),
    );
  }
}

class _ThemeSelection extends StatelessWidget {
  final AppTheme appTheme;
  final bool selected;
  final VoidCallback onTap;

  const _ThemeSelection({
    required this.appTheme,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(appTheme.name),
        AppCheckbox(
          checked: selected,
          onTap: onTap,
        )
      ],
    );
  }
}
