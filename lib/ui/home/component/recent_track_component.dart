import 'package:flutter/material.dart';
import 'package:state_app/model/artwork.dart';
import 'package:state_app/model/recent_track/recent_track.dart';
import 'package:state_app/ui/common/artwork_component.dart';

class RecentTrackComponent extends StatelessWidget {
  final RecentTrack recentTrack;
  final VoidCallback onTap;

  const RecentTrackComponent(
      {super.key, required this.recentTrack, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final imageUrl = recentTrack.images.imageUrl();
    return Material(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.only(
            left: 16,
            right: 16,
            top: 8,
            bottom: 8,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ArtworkComponent(
                imageUrl: imageUrl,
                size: 56,
              ),
              const SizedBox(
                width: 16,
              ),
              RecentTrackTitle(
                trackName: recentTrack.name,
                artistName: recentTrack.artist.name,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RecentTrackTitle extends StatelessWidget {
  final String trackName;
  final String artistName;

  const RecentTrackTitle(
      {super.key, required this.trackName, required this.artistName});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            trackName,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            artistName,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 12),
          )
        ],
      ),
    );
  }
}
