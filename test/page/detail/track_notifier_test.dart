import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sunrisescrob/model/result.dart';
import 'package:sunrisescrob/model/track.dart';
import 'package:sunrisescrob/repository/track_repository.dart';
import 'package:sunrisescrob/ui/detail/track_detail_screen.dart';

import '../../fixtures/test_data.dart';
import 'track_notifier_test.mocks.dart';

@GenerateMocks([TrackRepository])
void main() {
  group('track', () {
    late TrackRepository trackRepository;

    setUp(() {
      trackRepository = MockTrackRepository();
      provideDummy<Result<Track>>(Success(testTrack));
    });
    test('request succeeded', () async {
      when(trackRepository.getTrack(
        artist: 'aespa',
        track: 'Supernova',
      ),).thenAnswer((_) async => Result.success(testTrack));
      final notifier = TrackNotifier(trackRepository: trackRepository);
      await notifier.fetchTrack(
        artist: 'aespa',
        track: 'Supernova',
      );
      expect(notifier.trackDetail, testTrack);
    });

    test('request failed', () async {
      final exception = TimeoutException('timeout');
      when(trackRepository.getTrack(
        track: 'Supernova',
        artist: 'aespa',
      ),).thenAnswer((_) async => Result.failure(exception));
      final notifier = TrackNotifier(trackRepository: trackRepository);
      await notifier.fetchTrack(
        artist: 'aespa',
        track: 'Supernova',
      );
      expect(notifier.trackDetail, null);
    });
  });
}
