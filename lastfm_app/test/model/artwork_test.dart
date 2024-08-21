import 'package:flutter_test/flutter_test.dart';
import 'package:state_app/model/artwork.dart';

import '../fixtures/test_data.dart';

void main() {
  group('imageUrl', () {
    test('extralarge exists', () {
      expect([extraLargeArtwork, largeArtwork].imageUrl(),
          "https://example.com/extralarge.png");
    });

    test('large exists', () {
      expect([largeArtwork].imageUrl(), "https://example.com/large.png");
    });

    test('empty', () {
      final List<Artwork> lists = List.empty();
      expect(lists.imageUrl(), null);
    });
  });
}
