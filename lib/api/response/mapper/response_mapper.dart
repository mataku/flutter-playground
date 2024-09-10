import 'package:sunrisescrob/api/response/album/album_info_api_response.dart';
import 'package:sunrisescrob/api/response/artist/artist_info_api_response.dart';
import 'package:sunrisescrob/api/response/auth/auth_mobile_session_api_response.dart';
import 'package:sunrisescrob/api/response/chart/chart_top_artists_api_response.dart';
import 'package:sunrisescrob/api/response/chart/chart_top_tags_api_response.dart';
import 'package:sunrisescrob/api/response/chart/chart_top_tracks_api_response.dart';
import 'package:sunrisescrob/api/response/common_text_response.dart';
import 'package:sunrisescrob/api/response/image_response.dart';
import 'package:sunrisescrob/api/response/profile/user_get_info_api_response.dart';
import 'package:sunrisescrob/api/response/recent_track/recent_tracks_api_response.dart';
import 'package:sunrisescrob/api/response/top_tags_response.dart';
import 'package:sunrisescrob/api/response/track/track_info_api_response.dart';
import 'package:sunrisescrob/api/response/user/top_albums_api_response.dart';
import 'package:sunrisescrob/api/response/user/top_artists_api_response.dart';
import 'package:sunrisescrob/api/response/wiki_response.dart';
import 'package:sunrisescrob/model/album/album.dart';
import 'package:sunrisescrob/model/artist/artist.dart';
import 'package:sunrisescrob/model/artwork.dart';
import 'package:sunrisescrob/model/auth/mobile_session.dart';
import 'package:sunrisescrob/model/chart/chart_artist.dart';
import 'package:sunrisescrob/model/chart/chart_track.dart';
import 'package:sunrisescrob/model/common_name.dart';
import 'package:sunrisescrob/model/common_name_and_url.dart';
import 'package:sunrisescrob/model/profile/user_info.dart';
import 'package:sunrisescrob/model/recent_track/recent_track.dart';
import 'package:sunrisescrob/model/similar_content.dart';
import 'package:sunrisescrob/model/tag.dart';
import 'package:sunrisescrob/model/track.dart';
import 'package:sunrisescrob/model/user/top_album.dart';
import 'package:sunrisescrob/model/user/top_artist.dart';
import 'package:sunrisescrob/model/wiki.dart';

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
      url: url,
      images: images.toImageList(),
    );
  }
}

extension TopTagsResponseExt on TopTagsResponse {
  List<Tag> toTagList() {
    return tagsResponse.map((tag) => tag.toTag()).toList();
  }
}

extension TrackInfoResponseExt on TrackInfoResponse {
  Track toTrack() {
    return Track(
      name: name,
      url: url,
      duration: duration,
      listeners: listeners,
      playcount: playcount,
      artist: artist.toTrackArtist(),
      album: album?.toTrackAlbum(),
      tags: tags.toTagList(),
      wiki: wiki?.toWiki(),
      userPlayCount: userplaycount ?? '0',
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
        images: images.toImageList(),);
  }
}

extension TopAlbumsApiResponseExt on TopAlbumsApiResponse {
  List<TopAlbum> toTopAlbumList() {
    return response.albums.map((album) => album.toTopAlbum()).toList();
  }
}

extension ArtistResponseExt on ArtistResponse {
  TopArtist toTopArtist() {
    return TopArtist(
      name: name,
      url: url,
      playcount: playcount,
      images: images.toImageList(),
    );
  }
}

extension TopArtistsApiResponseExt on TopArtistsApiResponse {
  List<TopArtist> toTopArtistList() {
    return response.artists.map((artist) => artist.toTopArtist()).toList();
  }
}

extension UserGetInfoResponseExt on UserGetInfoResponse {
  UserInfo toUserInfo() {
    return UserInfo(
      name: name,
      isSubscriber: subscriber == '1',
      playcount: playcount,
      artistCount: artistCount,
      trackCount: trackCount,
      albumCount: albumCount,
      images: images.toImageList(),
      url: url,
    );
  }
}

extension AuthMobileSessionApiResponseExt on AuthMobileSessionApiResponse {
  MobileSession toMobileSession() {
    return MobileSession(
      name: sessionBody.name,
      key: sessionBody.key,
    );
  }
}

extension AlbumTrackApiBodyExt on AlbumTrackApiBody {
  AlbumTrack toAlbumTrack() {
    return AlbumTrack(
      duration: duration,
      url: url,
      name: name,
      artist: artist.toTrackArtist(),
      position: rankBody.rank,
    );
  }
}

extension AlbumTrackListApiBodyExt on AlbumTrackListApiBody {
  List<AlbumTrack> toAlbumTrackList() {
    return tracks.map((track) => track.toAlbumTrack()).toList();
  }
}

extension AlbumInfoApiResponseExt on AlbumInfoApiResponse {
  Album toAlbum() {
    final apiResponse = response;
    return Album(
      artist: apiResponse.artist,
      tags: apiResponse.tags?.toTagList() ?? List.empty(),
      name: apiResponse.name,
      images: apiResponse.images.toImageList(),
      tracks: apiResponse.tracks.toAlbumTrackList(),
      listeners: apiResponse.listeners,
      playcount: apiResponse.playcount,
      userplaycount: apiResponse.userplaycount ?? 0,
      url: apiResponse.url,
      wiki: apiResponse.wikiResponse?.toWiki(),
    );
  }
}

extension SimilarArtistsBodyExt on SimilarArtistsBody {
  List<SimilarContent> toSimilarArtists() {
    return artists
        .map((artist) => SimilarContent(
              name: artist.name,
              url: artist.url,
              images: artist.images.toImageList(),
            ),)
        .toList();
  }
}

extension ArtistInfoApiResponseExt on ArtistInfoApiResponse {
  Artist toArtist() {
    final response = body;
    return Artist(
      name: response.name,
      url: response.url,
      images: response.images.toImageList(),
      wiki: response.wiki?.toWiki(),
      similarArtists:
          response.similarArtists?.toSimilarArtists() ?? List.empty(),
      tags: response.tags.toTagList(),
      listeners: response.stats.listeners,
      playcount: response.stats.playcount,
      userplaycount: response.stats.userplaycount ?? '0',
    );
  }
}
