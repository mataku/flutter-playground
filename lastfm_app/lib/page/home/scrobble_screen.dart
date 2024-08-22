import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:state_app/component/recent_track/recent_track_component.dart';
import 'package:state_app/model/recent_track.dart';
import 'package:state_app/model/result.dart';
import 'package:state_app/repository/recent_tracks_repository.dart';
import 'package:state_app/router/router.dart';

final scrobbleNotifierProvider = ChangeNotifierProvider.autoDispose((ref) {
  final ScrobbleNotifier notifier = ScrobbleNotifier(
      recentTracksRepository: ref.read(recentTracksRepositoryProvider));
  notifier.fetchData();
  return notifier;
});

class ScrobbleScreen extends ConsumerWidget {
  const ScrobbleScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(scrobbleNotifierProvider);
    final tracks = notifier.tracks;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 8),
        child: ListView.builder(
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return RecentTrackComponent(
              recentTrack: tracks[index],
              onTap: () {
                const TrackDetailRoute().go(context);
              },
            );
          },
          itemCount: tracks.length,
        ),
      ),
    );
  }
}

class ScrobbleNotifier extends ChangeNotifier {
  final RecentTracksRepository recentTracksRepository;

  ScrobbleNotifier({required this.recentTracksRepository});

  List<RecentTrack> tracks = List.empty();

  Future fetchData() async {
    final result = await recentTracksRepository.getRecentTracksSample(1);
    if (result is Success) {
      tracks = result.getOrNull()!;
      notifyListeners();
    }
  }
}
