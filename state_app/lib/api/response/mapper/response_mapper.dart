import 'package:state_app/api/response/common_text_response.dart';
import 'package:state_app/api/response/image_response.dart';
import 'package:state_app/api/response/recent_tracks_api_response.dart';
import 'package:state_app/model/common_name.dart';
import 'package:state_app/model/artwork.dart';
import 'package:state_app/model/recent_track.dart';

extension RecentTracksApiResponseExt on RecentTracksApiResponse {
  List<RecentTrack> toRecentTrackList() {
    return response.tracks
        .map((trackResponse) => trackResponse.toRecentTrack())
        .toList();
  }
}

extension RecentTrackResponseExt on RecentTrackResponse {
  RecentTrack toRecentTrack() {
    return RecentTrack(
      artist: artist.toCommonName(),
      album: album.toCommonName(),
      images: images.toImageList(),
      name: name,
      url: url,
    );
  }
}

extension CommonTextResponseExt on CommonTextResponse {
  CommonName toCommonName() {
    return CommonName(name: name);
  }
}

extension ImageResponseListExt on List<ImageResponse> {
  List<Artwork> toImageList() {
    return map((imageResponse) => imageResponse.toImage()).toList();
  }
}

extension ImageResponseExt on ImageResponse {
  Artwork toImage() {
    return Artwork(size: size, url: url);
  }
}
