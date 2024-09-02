import 'dart:collection';
import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:sunrisescrob/model/key.dart';

class LastfmApiSignature {
  static String generate(
    Map<String, String> params,
  ) {
    var str = "";

    params['api_key'] = Env.apiKey;
    var sortedMap =
        SplayTreeMap.from(params, (String a, String b) => a.compareTo(b));
    sortedMap.forEach((key, value) {
      str += "$key$value";
    });
    str += Env.sharedSecret;
    var bytes = utf8.encode(str);
    var digest = md5.convert(bytes);
    params.remove('api_key');
    return digest.toString();
  }
}
