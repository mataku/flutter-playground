import 'package:flutter/material.dart';
import 'package:state_app/component/artwork_component.dart';
import 'package:state_app/model/artwork.dart';
import 'package:state_app/model/recent_track.dart';

class RecentTrackComponent extends StatelessWidget {
  final RecentTrack recentTrack;
  final VoidCallback onTap;

  const RecentTrackComponent(
      {super.key, required this.recentTrack, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final imageUrl = recentTrack.images.imageUrl();
    return InkWell(
        onTap: () {},
        child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ArtworkComponent(imageUrl: imageUrl, size: 96),
                const SizedBox(
                  width: 16,
                ),
                RecentTrackTitle(
                  trackName: recentTrack.name,
                  artistName: recentTrack.artist.name,
                )
              ],
            )));
  }
}

class RecentTrackTitle extends StatelessWidget {
  final String trackName;
  final String artistName;

  const RecentTrackTitle(
      {super.key, required this.trackName, required this.artistName});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          trackName,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text(artistName)
      ],
    );
  }
}
