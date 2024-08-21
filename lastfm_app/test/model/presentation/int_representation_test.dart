import 'package:flutter_test/flutter_test.dart';
import 'package:state_app/model/presentation/int_representation.dart';

void main() {
  group('toReadableValue', () {
    test('int', () {
      const intString = "10000";
      expect(IntRepresentation.toReadableValue(intString), '10K');
    });
    test('double', () {
      const intString = "10000.0";
      expect(IntRepresentation.toReadableValue(intString), '10K');
    });
    test('not number', () {
      const intString = "hoge";
      expect(IntRepresentation.toReadableValue(intString), 'hoge');
    });
  });
}
