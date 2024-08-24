import 'dart:async';
import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:state_app/api/response/mapper/response_mapper.dart';
import 'package:state_app/api/response/user/top_artists_api_response.dart';
import 'package:state_app/model/result.dart';
import 'package:state_app/model/user/top_artist.dart';
import 'package:state_app/repository/user_repository.dart';
import 'package:state_app/ui/home/top_artists_screen.dart';

import '../../fixture.dart';
import 'top_albums_notifier_test.mocks.dart';

@GenerateMocks([UserRepository])
void main() {
  group('fetchData', () {
    late UserRepository userRepository;
    final List<TopArtist> topArtists = TopArtistsApiResponse.fromJson(
      json.decode(fixture('user_top_artists.json')),
    ).toTopArtistList();

    setUp(() {
      userRepository = MockUserRepository();
      provideDummy<Result<List<TopArtist>>>(Success(topArtists));
    });

    test('request succeeded', () async {
      when(userRepository.getTopArtistsSample(1))
          .thenAnswer((_) async => Result.success(topArtists));
      final notifier = TopArtistsNotifier(userRepository: userRepository);
      await notifier.fetchData();
      expect(notifier.topArtistsState.topArtists.isNotEmpty, true);
      expect(notifier.topArtistsState.isLoading, false);
      expect(notifier.topArtistsState.hasMore, true);
    });

    test('request failed', () async {
      final mockException = TimeoutException('timeout');
      when(userRepository.getTopArtistsSample(1))
          .thenAnswer((_) async => Result.failure(mockException));
      final notifier = TopArtistsNotifier(userRepository: userRepository);
      await notifier.fetchData();
      expect(notifier.topArtistsState.topArtists.isEmpty, true);
      expect(notifier.topArtistsState.isLoading, false);
      expect(notifier.topArtistsState.hasMore, false);
    });
  });
}
