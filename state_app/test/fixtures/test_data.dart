import 'package:dio/dio.dart';
import 'package:state_app/api/response/chart_top_artists_api_response.dart';
import 'package:state_app/api/response/chart_top_tags_api_response.dart';
import 'package:state_app/api/response/chart_top_tracks_api_response.dart';
import 'package:state_app/api/response/common_text_response.dart';
import 'package:state_app/api/response/image_response.dart';
import 'package:state_app/api/response/mapper/response_mapper.dart';
import 'package:state_app/api/response/paging_attr_body_response.dart';
import 'package:state_app/api/response/recent_tracks_api_response.dart';
import 'package:state_app/api/response/top_tags_response.dart';
import 'package:state_app/api/response/track_info_api_response.dart';
import 'package:state_app/model/artwork.dart';

const pagingAttrResponse = PagingAttrBodyResponse(
  page: '1',
  perPage: '10',
  totalPages: '100',
  total: '1000',
);

final testImageResponse = ImageResponse(
  "https://example.com/image.png",
  "small",
);

final testRecentTrackAlbum =
    CommonTextResponse(name: 'Armageddon - The 1st Album');
final testRecentTrackArtist = CommonTextResponse(name: 'aespa');
final testRecentTrackResponse = RecentTrackResponse(
  artist: testRecentTrackArtist,
  images: [testImageResponse],
  album: testRecentTrackAlbum,
  name: "Supernova",
  url: "https://example.com/supernova",
);
final testRecentTracksResponse =
    RecentTracksResponse(tracks: [testRecentTrackResponse]);

final testRecentTrackApiResponse =
    RecentTracksApiResponse(response: testRecentTracksResponse);

const _testChartTrackArtistResponse = ChartTrackArtistResponse(
  name: 'aespa',
  url: 'https://example.com/aespa',
);
final _testChartTrackResponse = ChartTrackResponse(
  name: 'Supernova',
  playCount: '100000',
  listeners: '1000000',
  url: 'https://example.com/supernova',
  artist: _testChartTrackArtistResponse,
  images: [testImageResponse],
);

const _testChartArtistResponse = ChartArtistResponse(
  name: 'aespa',
  url: 'https://example.com/aespa',
  playCount: '100000',
  listeners: '1000000',
  images: [],
);

const testChartArtistApiResponse = ChartTopArtistsApiResponse(
    body: ChartTopArtistsApiBody(
  artists: [_testChartArtistResponse],
  pagingAttrBodyResponse: pagingAttrResponse,
));

final testChartTrackApiResponse = ChartTopTracksApiResponse(
    body: ChartTopTracksApiBody(
  tracks: [_testChartTrackResponse],
  pagingAttrBodyResponse: pagingAttrResponse,
));

final testChartArtistList = testChartArtistApiResponse.toChartArtistList();
final testChartTrackList = testChartTrackApiResponse.toChartTrackList();

const testChartTagApiResponse = ChartTopTagsApiResponse(
  body: ChartTopTagsApiBody(
    tags: [
      ChartTopTagResponse(
        name: 'Rock',
        url: 'https://example.com/rock',
      ),
    ],
    pagingAttrBodyResponse: pagingAttrResponse,
  ),
);

final testChartTagList = testChartTagApiResponse.toTagList();

const _testTrackResponse = TrackInfoResponse(
  name: 'Supernova',
  mbid: 'trackmbid',
  url: 'https://example.com/supernova',
  duration: '300000',
  listeners: '100000',
  playcount: '200000',
  album: TrackAlbumResponse(
    artist: 'aespa',
    title: 'Armageddon',
    mbid: 'mbid',
    url: 'https://example.com/armageddon',
    images: [],
  ),
  artist: TrackInfoArtist(
    name: 'aespa',
    mbid: 'mbid',
    url: 'https://example.com/aespa',
  ),
  wiki: WikiResponse(
    published: 'published',
    summary: 'summary',
    content: 'content',
  ),
  tags: TopTagsResponse(
    tagsResponse: [
      TagResponse(name: 'tag', url: 'https://example.com/tag'),
    ],
  ),
);

const testTrackApiResponse = TrackInfoApiResponse(response: _testTrackResponse);

final artworks = [
  const Artwork(size: "extralarge", url: "https://example.com/extralarge.png"),
  const Artwork(size: "large", url: "https://example.com/large.png"),
];

const extraLargeArtwork =
    Artwork(size: "extralarge", url: "https://example.com/extralarge.png");
const largeArtwork =
    Artwork(size: "large", url: "https://example.com/large.png");

final _dioOptions = BaseOptions(
  connectTimeout: const Duration(seconds: 5),
  receiveTimeout: const Duration(seconds: 3),
  queryParameters: {'format': 'json'},
);
final testDio = Dio(_dioOptions);
