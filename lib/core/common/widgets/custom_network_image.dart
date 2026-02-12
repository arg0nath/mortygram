import 'package:cached_network_image/cached_network_image.dart';
import 'package:cached_network_svg_image/cached_network_svg_image.dart';
import 'package:flutter/material.dart';
import 'package:mortygram/config/theme/app_palette.dart';
import 'package:mortygram/core/common/constants/app_const.dart';
import 'package:mortygram/core/common/extensions/context_ext.dart';
import 'package:mortygram/core/common/res/app_assets.dart';

class CustomNetworkImage extends StatelessWidget {
  const CustomNetworkImage({super.key, required this.imageUrl, this.width, this.height});

  final String imageUrl;

  final double? width;
  final double? height;

  bool get isSvg => imageUrl.toLowerCase().endsWith('.svg');

  @override
  Widget build(BuildContext context) {
    if (isSvg) {
      return CachedNetworkSVGImage(imageUrl, placeholder: const _PlaceHolderWidget(), errorWidget: const _ErrorWidget(), width: width, height: height, fadeDuration: const Duration(milliseconds: 200));
    } else {
      return CachedNetworkImage(
        imageUrl: imageUrl,
        width: 300, //hard copied from values of api docs.
        height: 300,
        placeholder: (BuildContext context, String url) => CircularProgressIndicator(),
        errorWidget: (BuildContext context, String url, Object error) => Icon(Icons.error),
      );
    }
  }
}

class _PlaceHolderWidget extends StatelessWidget {
  const _PlaceHolderWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 300,
      decoration: BoxDecoration(
        borderRadius: AppConst.mainRadius,
        border: Border.all(color: AppPalette.transparent, width: AppConst.networkImagePlaceholderWidth),
      ),
      child: const Center(child: CircularProgressIndicator()),
    );
  }
}

class _ErrorWidget extends StatelessWidget {
  const _ErrorWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 300,
      decoration: BoxDecoration(border: Border.all(color: AppPalette.transparent, width: 0)),
      child: Center(
        child: Image.asset(AppAssets.mortygramLogoPng, width: context.height * 0.05, height: context.height * 0.05),
      ),
    );
  }
}
