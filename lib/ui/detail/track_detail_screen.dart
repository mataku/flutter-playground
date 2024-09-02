import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
  const TrackDetailScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(trackNotifierProvider);
    final track = notifier.track;
    if (track == null) {
      return const Text('Wait!');
    } else {
      return TrackContentComponent(track: track);
    }
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
