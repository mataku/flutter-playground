import 'package:freezed_annotation/freezed_annotation.dart';

part 'recent_tracks_response.g.dart';

@JsonSerializable()
class RecentTracksResponse {}

@JsonSerializable()
class RecentTrackResponse {}

@JsonSerializable()
class RecentTrackArtist {
  @JsonKey(name: '#text')
  final String name;
  RecentTrackArtist({required this.name});

  factory RecentTrackArtist.fromJson(Map<String, dynamic> json) =>
      _$RecentTrackArtistFromJson(json);

  Map<String, dynamic> toJson() => _$RecentTrackArtistToJson(this);
}
