import 'dart:async';
import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sunrisescrob/api/response/mapper/response_mapper.dart';
import 'package:sunrisescrob/api/response/user/top_albums_api_response.dart';
import 'package:sunrisescrob/model/result.dart';
import 'package:sunrisescrob/model/user/top_album.dart';
import 'package:sunrisescrob/repository/user_repository.dart';
import 'package:sunrisescrob/ui/home/top_albums_screen.dart';

import '../../fixture.dart';
import 'top_albums_notifier_test.mocks.dart';

@GenerateMocks([UserRepository])
void main() {
  group('fetchData', () {
    late UserRepository userRepository;
    final List<TopAlbum> topAlbums = TopAlbumsApiResponse.fromJson(
            json.decode(fixture('user_top_albums.json')),)
        .toTopAlbumList();

    setUp(() {
      userRepository = MockUserRepository();
      provideDummy<Result<List<TopAlbum>>>(Success(topAlbums));
    });

    test('request succeeded', () async {
      when(userRepository.getTopAlbums(1))
          .thenAnswer((_) async => Result.success(topAlbums));
      final notifier = TopAlbumsNotifier(userRepository: userRepository);
      await notifier.fetchData();
      expect(notifier.topAlbumsState.topAlbums.isNotEmpty, true);
      expect(notifier.topAlbumsState.isLoading, false);
      expect(notifier.topAlbumsState.hasMore, true);
    });

    test('request failed', () async {
      final mockException = TimeoutException('timeout');
      when(userRepository.getTopAlbums(1))
          .thenAnswer((_) async => Result.failure(mockException));
      final notifier = TopAlbumsNotifier(userRepository: userRepository);
      await notifier.fetchData();
      expect(notifier.topAlbumsState.topAlbums.isEmpty, true);
      expect(notifier.topAlbumsState.isLoading, false);
      expect(notifier.topAlbumsState.hasMore, false);
    });
  });
}
