import 'package:url_launcher/url_launcher.dart';

class UrlOpener {
  static openUrlInBrowser(Uri uri) async {
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}
