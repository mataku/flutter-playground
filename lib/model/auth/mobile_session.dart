import 'package:freezed_annotation/freezed_annotation.dart';

part 'mobile_session.freezed.dart';

@freezed
class MobileSession with _$MobileSession {
  const factory MobileSession({
    required String name,
    required String key,
  }) = _MobileSession;
}
