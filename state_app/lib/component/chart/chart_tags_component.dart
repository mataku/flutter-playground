import 'package:flutter/material.dart';
import 'package:state_app/component/header.dart';
import 'package:state_app/component/tag_component.dart';
import 'package:state_app/model/tag.dart';

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
            child: _ChartTagsCarousel(
              tags: tags,
            ),
          ),
        ],
      ),
    );
  }
}

class _ChartTagsCarousel extends StatelessWidget {
  final List<Tag> tags;

  const _ChartTagsCarousel({required this.tags});

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
