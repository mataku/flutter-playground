import 'package:envied/envied.dart';

part 'key.g.dart';

@envied
abstract class Env {
  @EnviedField(varName: 'API_KEY', obfuscate: true)
  static String apiKey = _Env.apiKey;

  @EnviedField(varName: 'SHARED_SECRET', obfuscate: true)
  static String sharedSecret = _Env.sharedSecret;
}
