import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sunrisescrob/model/artwork.dart';
import 'package:sunrisescrob/model/recent_track/recent_track.dart';
import 'package:sunrisescrob/model/result.dart';
import 'package:sunrisescrob/repository/recent_tracks_repository.dart';
import 'package:sunrisescrob/router/router.dart';
import 'package:sunrisescrob/ui/home/component/recent_track_component.dart';

final scrobbleNotifierProvider = ChangeNotifierProvider((ref) {
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
            final track = tracks[index];
            return RecentTrackComponent(
              recentTrack: track,
              imageKey: "scrobble_$index",
              onTap: () {
                TrackDetailRoute(
                  artist: track.artist.name,
                  track: track.name,
                  imageKey: "scrobble_$index",
                  imageUrl: track.images.imageUrl() ?? '',
                ).go(context);
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
