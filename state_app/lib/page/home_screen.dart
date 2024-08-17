import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:state_app/component/recent_track/recent_track_component.dart';
import 'package:state_app/model/recent_track.dart';
import 'package:state_app/model/result.dart';
import 'package:state_app/repository/recent_tracks_repository.dart';

final homeNotifierProvider = ChangeNotifierProvider((ref) {
  final HomeNotifier notifier = HomeNotifier(
      recentTracksRepository: ref.read(recentTracksRepositoryProvider));
  notifier.fetchData();
  return notifier;
});

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(homeNotifierProvider);
    final tracks = notifier.tracks;
    return ListView.builder(
      itemBuilder: (context, index) {
        return RecentTrackComponent(recentTrack: tracks[index], onTap: () {});
      },
      itemCount: tracks.length,
    );
  }
}

class HomeNotifier extends ChangeNotifier {
  final RecentTracksRepository recentTracksRepository;

  HomeNotifier({required this.recentTracksRepository});

  List<RecentTrack> tracks = List.empty();

  Future fetchData() async {
    final result = await recentTracksRepository.getRecentTracksSample(1);
    if (result is Success) {
      tracks = result.getOrNull()!;
      notifyListeners();
    }
  }
}
