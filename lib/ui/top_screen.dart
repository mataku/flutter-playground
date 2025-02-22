import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TopScreen extends StatefulWidget {
  final StatefulNavigationShell navigationShell;

  const TopScreen({super.key, required this.navigationShell});

  @override
  State<TopScreen> createState() => _TopPageState();
}

class _TopPageState extends State<TopScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: widget.navigationShell,
      bottomNavigationBar: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: Container(
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(
                color: Colors.black,
                width: 0.1,
              ),
            ),
          ),
          child: BottomNavigationBar(
            currentIndex: widget.navigationShell.currentIndex,
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
              widget.navigationShell.goBranch(
                index,
                initialLocation: index == widget.navigationShell.currentIndex,
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
        ),
      ),
    );
  }
}
