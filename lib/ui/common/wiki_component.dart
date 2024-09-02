import 'package:collection/collection.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:sunrisescrob/model/wiki.dart';
import 'package:sunrisescrob/util/url_opener.dart';

class WikiComponent extends StatelessWidget {
  final String title;
  final Wiki wiki;
  final String url;

  const WikiComponent({
    super.key,
    required this.title,
    required this.wiki,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    var bodyNode = parse(wiki.summary).nodes.first;

    var bodyElement =
        bodyNode.children.firstWhereOrNull((v) => v.localName == 'body');
    var boldChildren = bodyElement?.children
            .where((child) => child.localName == 'b')
            .map((child) => child.text)
            .toList() ??
        [];
    var hrefChildren = bodyElement?.children
            .where((child) => child.localName == 'a')
            .map((child) => child.text)
            .toList() ??
        [];

    List<TextSpan> annotatedStringList = [];

    bodyElement?.nodes.forEach((node) {
      String? body = node.text;
      if (body == null) {
      } else if (boldChildren.contains(body)) {
        annotatedStringList.add(
          TextSpan(
            text: body,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: theme.colorScheme.onSurface,
            ),
          ),
        );
      } else if (hrefChildren.contains(body)) {
        annotatedStringList.add(
          TextSpan(
            text: body,
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                UrlOpener.openUrlInBrowser(Uri.parse(url));
              },
            style: const TextStyle(
              color: Colors.blue,
              fontSize: 14,
            ),
          ),
        );
      } else {
        annotatedStringList.add(
          TextSpan(
            text: body,
            style: TextStyle(
              fontSize: 14,
              color: theme.colorScheme.onSurface,
            ),
          ),
        );
      }
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "About $title",
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const Padding(padding: EdgeInsets.only(top: 8)),
        // const Text('hello')

        RichText(
          text: TextSpan(
            children: annotatedStringList,
          ),
        ),
      ],
    );
  }
}
