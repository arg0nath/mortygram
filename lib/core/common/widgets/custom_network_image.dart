import 'package:cached_network_image/cached_network_image.dart';
import 'package:cached_network_svg_image/cached_network_svg_image.dart';
import 'package:flutter/material.dart';

class CustomNetworkImage extends StatelessWidget {
  const CustomNetworkImage({
    super.key,
    this.fit = BoxFit.cover,
    required this.imageUrl,
    this.width,
    this.height,
  });

  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;

  bool get isSvg => imageUrl.toLowerCase().endsWith('.svg');

  @override
  Widget build(BuildContext context) {
    if (isSvg) {
      return CachedNetworkSVGImage(
        imageUrl,
        placeholder: const _PlaceHolderWidget(),
        errorWidget: const _ErrorWidget(),
        width: width,
        height: height,
        fit: fit,
        fadeDuration: const Duration(milliseconds: 200),
      );
    } else {
      return CachedNetworkImage(
        imageUrl: imageUrl,
        width: width,
        height: height,
        fit: fit,
        placeholder: (BuildContext context, String url) => const _PlaceHolderWidget(),
        errorWidget: (BuildContext context, String url, Object error) => const _ErrorWidget(),
      );
    }
  }
}

class _PlaceHolderWidget extends StatelessWidget {
  const _PlaceHolderWidget();

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}

class _ErrorWidget extends StatelessWidget {
  const _ErrorWidget();

  @override
  Widget build(BuildContext context) {
    return const Center(child: Icon(Icons.error_rounded));
  }
}
