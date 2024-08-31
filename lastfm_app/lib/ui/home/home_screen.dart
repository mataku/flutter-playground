import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:state_app/ui/home/scrobble_screen.dart';
import 'package:state_app/ui/home/top_albums_screen.dart';
import 'package:state_app/ui/home/top_artists_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    return SafeArea(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Home'),
            bottom: TabBar(
              labelColor: theme.colorScheme.onSurface,
              unselectedLabelColor: theme.colorScheme.onSecondary,
              indicatorColor: theme.colorScheme.onSurface,
              dividerColor: theme.colorScheme.onSecondary.withAlpha(128),
              tabs: const [
                Tab(text: 'Scrobble'),
                Tab(text: 'Album'),
                Tab(text: 'Artist'),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              ScrobbleScreen(),
              TopAlbumsScreen(),
              TopArtistsScreen(),
            ],
          ),
        ),
      ),
    );
  }
}
