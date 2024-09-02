import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:sunrisescrob/api/response/mapper/response_mapper.dart';
import 'package:sunrisescrob/api/response/profile/user_get_info_api_response.dart';

import '../../../fixture.dart';

void main() {
  test('should parse', () async {
    final jsonMap =
        json.decode(fixture('user_get_info.json')) as Map<String, dynamic>;
    final response = UserGetInfoApiResponse.fromJson(jsonMap);
    final userInfo = response.response.toUserInfo();
    expect(userInfo.name, 'matakucom');
    expect(userInfo.isSubscriber, true);
  });
}
