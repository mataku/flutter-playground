import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sunrisescrob/ui/common/image/app_image_cache_manager.dart';

class ArtworkComponent extends ConsumerWidget {
  final String? imageUrl;
  final double size;

  const ArtworkComponent({
    super.key,
    required this.imageUrl,
    required this.size,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final cacheManager = ref.read(appImageCacheManagerProvider);

    final Widget imageComponent;

    if (imageUrl == null || imageUrl?.isEmpty == true) {
      imageComponent = Image.asset(
        "asset/image/no_image.png",
        fit: BoxFit.cover,
      );
    } else {
      imageComponent = CachedNetworkImage(
        imageUrl: imageUrl!,
        placeholder: (context, url) {
          return SizedBox(
            width: size,
            height: size,
            child:
                ColoredBox(color: theme.colorScheme.onSecondary.withAlpha(64)),
          );
        },
        errorWidget: (context, url, error) {
          return Image.asset(
            "asset/image/no_image.png",
            fit: BoxFit.cover,
          );
        },
        fadeInDuration: const Duration(
          milliseconds: 200,
        ),
        cacheManager: cacheManager,
      );
    }

    return SizedBox(
      height: size,
      width: size,
      child: imageComponent,
    );
  }
}

class ArtworkSquareComponent extends ConsumerWidget {
  final String? imageUrl;
  final double size;

  const ArtworkSquareComponent({
    super.key,
    required this.imageUrl,
    required this.size,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cacheManager = ref.read(appImageCacheManagerProvider);

    final theme = Theme.of(context);

    final Widget imageComponent;

    if (imageUrl == null || imageUrl?.isEmpty == true) {
      imageComponent = Image.asset(
        "asset/image/no_image.png",
        fit: BoxFit.cover,
      );
    } else {
      imageComponent = CachedNetworkImage(
        fit: BoxFit.cover,
        imageUrl: imageUrl!,
        placeholder: (context, url) {
          return AspectRatio(
            aspectRatio: 1 / 1,
            child: SizedBox(
              width: size,
              child: ColoredBox(
                color: theme.colorScheme.onSecondary.withAlpha(128),
              ),
            ),
          );
        },
        errorWidget: (context, url, error) {
          return AspectRatio(
            aspectRatio: 1 / 1,
            child: SizedBox(
              width: size,
              child: Image.asset(
                "asset/image/no_image.png",
                fit: BoxFit.fitWidth,
              ),
            ),
          );
        },
        fadeInDuration: const Duration(
          milliseconds: 200,
        ),
        cacheManager: cacheManager,
      );

      // imageComponent = Image.network(
      //   imageUrl!,
      //   fit: BoxFit.cover,
      //   errorBuilder: (BuildContext context, error, stacktrace) {
      //     return Image.asset(
      //       "asset/image/no_image.png",
      //       fit: BoxFit.cover,
      //     );
      //   },
      //   loadingBuilder: (context, child, loadingProgress) {
      //     if (loadingProgress != null) {
      //       return Container(color: theme.colorScheme.surface);
      //     } else {
      //       return child;
      //     }
      //   },
      // );
    }

    return SizedBox(
      width: size,
      child: imageComponent,
    );
  }
}
