import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cached_network_svg_image/cached_network_svg_image.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class CustomNetworkImage extends StatefulWidget {
  const CustomNetworkImage({
    required this.imageUrl,
    super.key,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
  });

  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;

  @override
  State<CustomNetworkImage> createState() => _CustomNetworkImageState();
}

class _CustomNetworkImageState extends State<CustomNetworkImage> {
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;
  bool _hasError = false;
  int _retryKey = 0;

  @override
  void initState() {
    super.initState();
    _connectivitySubscription = Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> result) {
      // When connectivity is restored and there was an error, retry loading
      if (_hasError && result.isNotEmpty && result.first != ConnectivityResult.none) {
        setState(() {
          _hasError = false;
          _retryKey++; // Force widget rebuild with new key
        });
      }
    });
  }

  @override
  void dispose() {
    _connectivitySubscription?.cancel();
    super.dispose();
  }

  bool get isSvg => widget.imageUrl.toLowerCase().endsWith('.svg');

  @override
  Widget build(BuildContext context) {
    if (isSvg) {
      return CachedNetworkSVGImage(
        widget.imageUrl,
        key: ValueKey('${widget.imageUrl}_$_retryKey'),
        placeholder: const _PlaceHolderWidget(),
        errorWidget: const _ErrorWidget(),
        width: widget.width,
        height: widget.height,
        fit: widget.fit,
        fadeDuration: const Duration(milliseconds: 200),
      );
    } else {
      return CachedNetworkImage(
        key: ValueKey('${widget.imageUrl}_$_retryKey'), // force image to rebuild when data changes or retry
        imageUrl: widget.imageUrl,
        width: widget.width,
        height: widget.height,
        fit: widget.fit,
        placeholder: (BuildContext context, String url) => const _PlaceHolderWidget(),
        errorWidget: (BuildContext context, String url, Object error) {
          // Track error state to trigger retry on connectivity restore
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) {
              setState(() => _hasError = true);
            }
          });
          return const _ErrorWidget();
        },
        fadeInDuration: const Duration(milliseconds: 200),
        fadeOutDuration: const Duration(milliseconds: 100),
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
