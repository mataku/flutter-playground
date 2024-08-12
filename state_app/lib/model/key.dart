import 'package:envied/envied.dart';

part 'key.g.dart';

@envied
abstract class Env {
  @EnviedField(varName: 'API_KEY')
  static const String apiKey = _Env.apiKey;

  @EnviedField(varName: 'SHARED_SECRET')
  static const String sharedSecret = _Env.sharedSecret;
}
