import 'package:state_app/api/response/chart/chart_top_artists_api_response.dart';
import 'package:state_app/api/response/chart/chart_top_tags_api_response.dart';
import 'package:state_app/api/response/chart/chart_top_tracks_api_response.dart';
import 'package:state_app/api/response/common_text_response.dart';
import 'package:state_app/api/response/image_response.dart';
import 'package:state_app/api/response/recent_track/recent_tracks_api_response.dart';
import 'package:state_app/api/response/top_tags_response.dart';
import 'package:state_app/api/response/track/track_info_api_response.dart';
import 'package:state_app/api/response/user/top_albums_api_response.dart';
import 'package:state_app/model/artwork.dart';
import 'package:state_app/model/chart/chart_artist.dart';
import 'package:state_app/model/chart/chart_track.dart';
import 'package:state_app/model/common_name.dart';
import 'package:state_app/model/common_name_and_url.dart';
import 'package:state_app/model/recent_track/recent_track.dart';
import 'package:state_app/model/tag.dart';
import 'package:state_app/model/track.dart';
import 'package:state_app/model/user/top_album.dart';
import 'package:state_app/model/wiki.dart';

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

extension TagResponseExt on TagResponse {
  Tag toTag() {
    return Tag(name: name, url: url);
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

extension TrackInfoArtistExt on TrackInfoArtist {
  CommonNameAndUrl toTrackArtist() {
    return CommonNameAndUrl(
      name: name,
      url: url,
    );
  }
}

extension WikiResponseExt on WikiResponse {
  Wiki toWiki() {
    return Wiki(
      published: published,
      summary: summary,
      content: content,
    );
  }
}

extension TrackAlbumResponseExt on TrackAlbumResponse {
  TrackAlbum toTrackAlbum() {
    return TrackAlbum(
      artist: artist,
      title: title,
      mbid: mbid,
      url: url,
      images: images.toImageList(),
    );
  }
}

extension TrackInfoResponseExt on TrackInfoResponse {
  Track toTrack() {
    return Track(
      name: name,
      mbid: mbid,
      url: url,
      duration: duration,
      listeners: listeners,
      playcount: playcount,
      artist: artist.toTrackArtist(),
      album: album.toTrackAlbum(),
      tags: tags.tagsResponse.map((tag) => tag.toTag()).toList(),
      wiki: wiki.toWiki(),
    );
  }
}

extension TrackInfoApiResponseExt on TrackInfoApiResponse {
  Track toTrack() {
    return response.toTrack();
  }
}

extension AlbumResponseExt on AlbumResponse {
  TopAlbum toTopAlbum() {
    return TopAlbum(
        name: name,
        playcount: playcount,
        mbid: mbid,
        url: url,
        artist: artist.toTrackArtist(),
        images: images.toImageList());
  }
}

extension TopAlbumsApiResponseExt on TopAlbumsApiResponse {
  List<TopAlbum> toTopAlbumList() {
    return response.albums.map((album) => album.toTopAlbum()).toList();
  }
}
