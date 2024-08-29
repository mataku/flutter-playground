import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:state_app/api/response/auth/auth_mobile_session_api_response.dart';

import '../../../fixture.dart';

void main() {
  test('should parse', () async {
    final jsonMap =
        json.decode(fixture('mobile_session.json')) as Map<String, dynamic>;
    final result = AuthMobileSessionApiResponse.fromJson(jsonMap);
    expect(result.sessionBody.name, 'mataku');
    expect(result.sessionBody.key, '1234abc');
  });
}
