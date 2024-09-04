import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sunrisescrob/model/result.dart';
import 'package:sunrisescrob/model/track.dart';
import 'package:sunrisescrob/repository/track_repository.dart';
import 'package:sunrisescrob/ui/detail/component/track_content_component.dart';

final trackNotifierProvider = ChangeNotifierProvider.autoDispose((ref) {
  final trackNotifier =
      TrackNotifier(trackRepository: ref.read(trackRepositoryProvider));
  trackNotifier.fetchTrack();
  return trackNotifier;
});

class TrackDetailScreen extends ConsumerWidget {
  // TODO: fetch with artist and track instead of sample use
  final String _artist;
  final String _track;
  const TrackDetailScreen({
    super.key,
    required String artist,
    required String track,
  })  : _artist = artist,
        _track = track;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(trackNotifierProvider);
    final track = notifier.track;
    final theme = Theme.of(context);
    EdgeInsets padding = MediaQuery.paddingOf(context);

    return SafeArea(
      top: false,
      child: Stack(
        children: [
          if (track == null) const SizedBox(),
          if (track != null) TrackContentComponent(track: track),
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: 100,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withAlpha(128),
                    Colors.white.withAlpha(2)
                  ],
                  stops: const [0.0, 1.0],
                )),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: padding.top,
                  left: 16,
                ),
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: theme.colorScheme.surface.withAlpha(192),
                  ),
                  child: GestureDetector(
                    child: Center(
                      child: Icon(
                        Icons.arrow_back_ios_new_outlined,
                        color: theme.colorScheme.onSurface,
                        size: 20,
                      ),
                    ),
                    onTap: () {
                      context.pop();
                    },
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class TrackNotifier extends ChangeNotifier {
  final TrackRepository trackRepository;

  TrackNotifier({required this.trackRepository});

  Track? track;

  Future fetchTrack() async {
    final result = await trackRepository.getTrackSample('Supernova', 'aespa');
    if (result is Success) {
      track = result.getOrNull()!;
      notifyListeners();
    }
  }
}
