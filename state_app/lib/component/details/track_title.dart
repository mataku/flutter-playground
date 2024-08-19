import 'package:flutter/material.dart';

class TrackTitle extends StatelessWidget {
  final String track;
  final String artist;

  const TrackTitle({
    super.key,
    required this.track,
    required this.artist,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Column(
        children: [
          Text(
            track,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Text(artist),
        ],
      ),
    );
  }
}
