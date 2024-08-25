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
    return Scaffold(
      body: widget.navigationShell,
      bottomNavigationBar: _bottomNavigationBar(context),
    );
  }

  // tapping area
  BottomNavigationBar _bottomNavigationBar(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: widget.navigationShell.currentIndex,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: "Discover",
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
    );
    // NavigationBar
    // return NavigationBar(
    //   selectedIndex: widget.navigationShell.currentIndex,
    //   destinations: const [
    //     NavigationDestination(
    //       icon: Icon(Icons.home),
    //       label: 'Home',
    //     ),
    //     NavigationDestination(
    //       icon: Icon(Icons.search),
    //       label: 'Discover',
    //     ),
    //   ],
    //   onDestinationSelected: (index) {
    //     widget.navigationShell.goBranch(
    //       index,
    //       initialLocation: index == widget.navigationShell.currentIndex,
    //     );
    //   },
    // );
  }
}
