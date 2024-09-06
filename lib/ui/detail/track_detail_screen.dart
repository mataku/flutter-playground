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
  return trackNotifier;
});

class TrackDetailScreen extends ConsumerStatefulWidget {
  final String artist;
  final String track;
  final String imageKey;
  final String imageUrl;

  const TrackDetailScreen({
    super.key,
    required this.artist,
    required this.track,
    required this.imageKey,
    required this.imageUrl,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TrackDetailState();
}

class _TrackDetailState extends ConsumerState<TrackDetailScreen> {
  _TrackDetailState();

  @override
  void initState() {
    ref.read(trackNotifierProvider).fetchTrack(
          artist: widget.artist,
          track: widget.track,
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.watch(trackNotifierProvider);
    final track = notifier.trackDetail;
    final theme = Theme.of(context);
    EdgeInsets padding = MediaQuery.paddingOf(context);

    return SafeArea(
      top: false,
      child: Stack(
        children: [
          TrackContentComponent(
            imageKey: widget.imageKey,
            track: track,
            imageUrl: widget.imageUrl,
          ),
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

  Track? trackDetail;

  Future fetchTrack({
    required String artist,
    required String track,
  }) async {
    Result<Track> result = await trackRepository.getTrack(
      track: track,
      artist: artist,
    );
    if (result is Success) {
      trackDetail = result.getOrNull()!;
      notifyListeners();
    }
  }
}
