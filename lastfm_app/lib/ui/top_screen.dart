import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:state_app/ui/common/app_bottom_navigation_bar.dart';

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
      bottomNavigationBar: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: AppBottomNavigationBar(
          navigationShell: widget.navigationShell,
        ),
      ),
    );
  }
}
