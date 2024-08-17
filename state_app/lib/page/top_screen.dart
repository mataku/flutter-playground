import 'package:flutter/material.dart';
import 'package:state_app/router/router.dart';

enum PageIndex { home, discover }

class TopScreen extends StatefulWidget {
  final Widget child;

  const TopScreen({super.key, required this.child});

  @override
  State<TopScreen> createState() => _TopPageState();
}

class _TopPageState extends State<TopScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    debugPrint("MATAKUDEBUG top!!!!!!!");
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: _bottomNavigationBar(context),
    );
  }

  BottomNavigationBar _bottomNavigationBar(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: "Discover",
        ),
      ],
      onTap: (int index) {
        setState(() {
          _selectedIndex = index;
        });
        if (index == PageIndex.home.index) {
          const HomeRoute().go(context);
        } else if (index == PageIndex.discover.index) {
          const DiscoverRoute().go(context);
        }
      },
    );
  }
}
