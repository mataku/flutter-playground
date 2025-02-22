import 'package:flutter/material.dart';
import 'package:sunrisescrob/ui/common/header.dart';
import 'package:sunrisescrob/ui/common/tag_component.dart';
import 'package:sunrisescrob/model/tag.dart';

class ChartTagsComponent extends StatelessWidget {
  final List<Tag> tags;

  const ChartTagsComponent({super.key, required this.tags});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 100,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Header(
            title: 'Top Tags',
          ),
          Expanded(
            child: ChartTagsCarousel(
              tags: tags,
            ),
          ),
        ],
      ),
    );
  }
}

class ChartTagsCarousel extends StatelessWidget {
  final List<Tag> tags;

  const ChartTagsCarousel({super.key, required this.tags});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.only(left: 16, right: 16),
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        final tag = tags[index];
        return TagComponent(tag: tag);
      },
      itemCount: tags.length,
      separatorBuilder: (context, index) {
        return const SizedBox(
          width: 12,
        );
      },
    );
  }
}
