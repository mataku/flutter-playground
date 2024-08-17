import 'package:dio/dio.dart';
import 'package:state_app/api/response/common_text_response.dart';
import 'package:state_app/api/response/image_response.dart';
import 'package:state_app/api/response/recent_tracks_api_response.dart';
import 'package:state_app/model/artwork.dart';

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
