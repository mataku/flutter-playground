import 'package:state_app/api/response/chart_top_artists_api_response.dart';
import 'package:state_app/api/response/chart_top_tags_api_response.dart';
import 'package:state_app/api/response/chart_top_tracks_api_response.dart';
import 'package:state_app/api/response/common_text_response.dart';
import 'package:state_app/api/response/image_response.dart';
import 'package:state_app/api/response/recent_tracks_api_response.dart';
import 'package:state_app/model/artwork.dart';
import 'package:state_app/model/chart_artist.dart';
import 'package:state_app/model/chart_track.dart';
import 'package:state_app/model/common_name.dart';
import 'package:state_app/model/recent_track.dart';
import 'package:state_app/model/tag.dart';

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

extension ChartArtistResponseExt on ChartArtistResponse {
  ChartArtist toChartArtist() {
    return ChartArtist(
      name: name,
      url: url,
      playCount: playCount,
      listeners: listeners,
      images: images.toImageList(),
    );
  }
}

extension ChartTopArtistsApiResponseExt on ChartTopArtistsApiResponse {
  List<ChartArtist> toChartArtistList() {
    return body.artists.map((artist) => artist.toChartArtist()).toList();
  }
}

extension ChartTopTagResponseExt on ChartTopTagResponse {
  Tag toTag() {
    return Tag(
      name: name,
      url: url,
    );
  }
}

extension ChartTopTagsApiResponseExt on ChartTopTagsApiResponse {
  List<Tag> toTagList() {
    return body.tags.map((tag) => tag.toTag()).toList();
  }
}

extension ChartTrackArtistResponseExt on ChartTrackArtistResponse {
  ChartTrackArtist toChartTrackArtist() {
    return ChartTrackArtist(
      name: name,
      url: url,
    );
  }
}

extension ChartTrackResponseExt on ChartTrackResponse {
  ChartTrack toChartTrack() {
    return ChartTrack(
      name: name,
      url: url,
      playCount: playCount,
      listeners: listeners,
      artist: artist.toChartTrackArtist(),
      images: images.toImageList(),
    );
  }
}

extension ChartTopTracksApiResponseExt on ChartTopTracksApiResponse {
  List<ChartTrack> toChartTrackList() {
    return body.tracks.map((track) => track.toChartTrack()).toList();
  }
}
