import 'package:flutter/material.dart';
import 'package:sunrisescrob/ui/common/value_description.dart';

class TrackMetadata extends StatelessWidget {
  final String listeners;
  final String playcount;
  final String userPlaycount;

  const TrackMetadata({
    super.key,
    required this.listeners,
    required this.playcount,
    required this.userPlaycount,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
        top: 8,
        bottom: 8,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ValueDescription(
            value: listeners,
            label: 'Listeners',
          ),
          const Padding(padding: EdgeInsets.only(left: 6, right: 6)),
          ValueDescription(
            value: playcount,
            label: 'Playcount',
          ),
          if (userPlaycount != '0')
            const Padding(padding: EdgeInsets.only(left: 6, right: 6)),
          if (userPlaycount != '0')
            ValueDescription(
              value: userPlaycount,
              label: 'Yours',
            ),
        ],
      ),
    );
  }
}
