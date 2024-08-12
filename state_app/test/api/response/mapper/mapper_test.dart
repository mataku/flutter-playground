import 'package:flutter_test/flutter_test.dart';
import 'package:state_app/api/response/mapper/Mapper.dart';
import 'package:state_app/model/artwork.dart';
import 'package:state_app/model/common_name.dart';
import 'package:state_app/model/recent_track.dart';

import '../../../fixtures/test_data.dart';

void main() {
  group('recent_tracks', () {
    test('image', () {
      expect(
        testImageResponse.toImage(),
        Artwork(
          size: testImageResponse.size,
          url: testImageResponse.url,
        ),
      );
    });

    test('album', () {
      expect(
        testRecentTrackAlbum.toCommonName(),
        CommonName(
          name: testRecentTrackAlbum.name,
        ),
      );
    });

    test('artist', () {
      expect(
        testRecentTrackArtist.toCommonName(),
        CommonName(
          name: testRecentTrackArtist.name,
        ),
      );
    });
    test('recent_track_response', () {
      final target = testRecentTrackResponse;
      expect(
        target.toRecentTrack(),
        RecentTrack(
          artist: target.artist.toCommonName(),
          album: target.album.toCommonName(),
          images: target.images.toImageList(),
          name: target.name,
          url: target.url,
        ),
      );
    });

    test('recent_track_api_response', () {
      final target = testRecentTrackApiResponse;
      expect(
        target.toRecentTrackList(),
        [
          RecentTrack(
            artist: target.response.tracks.first.artist.toCommonName(),
            album: target.response.tracks.first.album.toCommonName(),
            images: target.response.tracks.first.images.toImageList(),
            name: target.response.tracks.first.name,
            url: target.response.tracks.first.url,
          ),
        ],
      );
    });
  });
}
