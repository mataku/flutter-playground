import 'package:flutter/widgets.dart';

class ArtworkComponent extends StatelessWidget {
  final String? imageUrl;
  final double size;

  const ArtworkComponent(
      {super.key, required this.imageUrl, required this.size});

  @override
  Widget build(BuildContext context) {
    final Widget imageComponent;

    if (imageUrl == null) {
      imageComponent = Image.asset(
        "asset/no_image.png",
        fit: BoxFit.cover,
      );
    } else {
      imageComponent = Image.network(imageUrl!, fit: BoxFit.cover,
          errorBuilder: (BuildContext context, error, stacktrace) {
        return Image.asset(
          "asset/no_image.png",
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
