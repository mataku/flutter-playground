import 'package:flutter/material.dart';

class ArtworkComponent extends StatelessWidget {
  final String? imageUrl;
  final double size;

  const ArtworkComponent({
    super.key,
    required this.imageUrl,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    final Widget imageComponent;

    if (imageUrl == null || imageUrl?.isEmpty == true) {
      imageComponent = Image.asset(
        "asset/image/no_image.png",
        fit: BoxFit.cover,
      );
    } else {
      imageComponent = Image.network(imageUrl!, fit: BoxFit.cover,
          errorBuilder: (BuildContext context, error, stacktrace) {
        return Image.asset(
          "asset/image/no_image.png",
          fit: BoxFit.cover,
        );
      });
    }

    return SizedBox(
      height: size,
      width: size,
      child: imageComponent,
    );
  }
}

class ArtworkSquareComponent extends StatelessWidget {
  final String? imageUrl;
  final double size;

  const ArtworkSquareComponent({
    super.key,
    required this.imageUrl,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final Widget imageComponent;

    if (imageUrl == null || imageUrl?.isEmpty == true) {
      imageComponent = Image.asset(
        "asset/image/no_image.png",
        fit: BoxFit.cover,
      );
    } else {
      imageComponent = Image.network(
        imageUrl!,
        fit: BoxFit.cover,
        errorBuilder: (BuildContext context, error, stacktrace) {
          return Image.asset(
            "asset/image/no_image.png",
            fit: BoxFit.cover,
          );
        },
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress != null) {
            return Container(color: theme.colorScheme.surface);
          } else {
            return child;
          }
        },
      );
    }

    return SizedBox(
      width: size,
      child: imageComponent,
    );
  }
}
