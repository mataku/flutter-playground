import 'package:flutter/widgets.dart';
import 'package:state_app/component/artwork_component.dart';
import 'package:state_app/model/track.dart';

class TrackMetadataComponent extends StatelessWidget {
  final Track track;

  const TrackMetadataComponent({
    super.key,
    required this.track,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: ArtworkComponent(
                imageUrl: null,
                size: 360,
              ),
            )
          ],
        ),
      ),
    );
  }
}
