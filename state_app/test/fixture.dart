import 'dart:io';

String fixture(String name) {
  File file = File('${Directory.current.path}/test/fixtures/$name');

  return file.readAsStringSync();
}
