import 'package:state_app/api/response/common_text_response.dart';
import 'package:state_app/api/response/image_response.dart';
import 'package:state_app/api/response/recent_tracks_api_response.dart';

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
