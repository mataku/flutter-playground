import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:state_app/component/chart/chart_artists_component.dart';
import 'package:state_app/component/chart/chart_tags_component.dart';
import 'package:state_app/component/chart/chart_tracks_component.dart';
import 'package:state_app/model/chart_artist.dart';
import 'package:state_app/model/chart_track.dart';
import 'package:state_app/model/result.dart';
import 'package:state_app/model/tag.dart';
import 'package:state_app/repository/chart_repository.dart';

final discoverNotifierProvider = ChangeNotifierProvider.autoDispose((ref) {
  final _DiscoverNotifier notifier =
      _DiscoverNotifier(chartRepository: ref.read(chartRepositoryProvider));
  notifier.fetchCharts();
  return notifier;
});

class DiscoverScreen extends ConsumerWidget {
  const DiscoverScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(discoverNotifierProvider);
    final tracks = notifier.tracks;
    final artists = notifier.artists;
    final tags = notifier.tags;
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: ChartTracksComponent(tracks: tracks),
          ),
          const SliverPadding(padding: EdgeInsets.only(top: 8, bottom: 8)),
          SliverToBoxAdapter(
            child: ChartArtistsComponent(artists: artists),
          ),
          const SliverPadding(padding: EdgeInsets.only(top: 8, bottom: 8)),
          SliverToBoxAdapter(
            child: ChartTagsComponent(tags: tags),
          ),
        ],
      ),
    );
  }
}

class _DiscoverNotifier extends ChangeNotifier {
  final ChartRepository chartRepository;

  _DiscoverNotifier({required this.chartRepository});

  List<ChartTrack> tracks = List.empty();
  List<ChartArtist> artists = List.empty();
  List<Tag> tags = List.empty();

  Future fetchCharts() async {
    // TODO: request in parallel
    final trackResult = await chartRepository.getChartTracksSample(1);
    if (trackResult is Success) {
      tracks = trackResult.getOrNull()!;
    }

    final artistResult = await chartRepository.getChartArtistsSample(1);
    if (artistResult is Success) {
      artists = artistResult.getOrNull()!;
    }

    final tagResult = await chartRepository.getChartTagsSample(1);
    if (tagResult is Success) {
      tags = tagResult.getOrNull()!;
    }
    debugPrint("MATAKUDEBUG $tracks");
    // debugPrint("MATAKUDEBUG $artists");
    // debugPrint("MATAKUDEBUG $tags");

    notifyListeners();
  }
}
