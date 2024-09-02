import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:state_app/model/result.dart';
import 'package:state_app/model/track.dart';
import 'package:state_app/repository/track_repository.dart';
import 'package:state_app/ui/detail/track_detail_screen.dart';

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
      when(trackRepository.getTrackSample('Supernova', 'aespa'))
          .thenAnswer((_) async => Result.success(testTrack));
      final notifier = TrackNotifier(trackRepository: trackRepository);
      await notifier.fetchTrack();
      expect(notifier.track, testTrack);
    });

    test('request failed', () async {
      final exception = TimeoutException('timeout');
      when(trackRepository.getTrackSample('Supernova', 'aespa'))
          .thenAnswer((_) async => Result.failure(exception));
      final notifier = TrackNotifier(trackRepository: trackRepository);
      await notifier.fetchTrack();
      expect(notifier.track, null);
    });
  });
}
