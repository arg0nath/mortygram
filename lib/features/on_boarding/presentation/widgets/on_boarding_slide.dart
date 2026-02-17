import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:mortygram/core/common/extensions/context_ext.dart';
import 'package:mortygram/features/on_boarding/domain/entities/on_boarding_data.dart';

class OnBoardingSlide extends StatelessWidget {
  const OnBoardingSlide({required this.data, required this.index, super.key});

  final OnBoardingData data;
  final int index;

  // Animation delays and durations
  static const int _baseDelay = 100;
  static const int _shimmerDelay = 2000;
  static const int _shimmerDuration = 1800;
  static const int _fadeInDuration = 600;

  // Spacing and sizing
  static const double _horizontalPadding = 32;
  static const double _iconContainerSize = 180;
  static const double _iconSize = 100;
  static const double _imageSize = 200;
  static const double _titleSpacing = 60;
  static const double _descriptionSpacing = 24;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: _horizontalPadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          if (data.icon != null && data.gradient != null) _buildGradientIconContainer() else if (data.image != null && data.image!.isNotEmpty) _buildImageWidget(),
          const SizedBox(height: _titleSpacing),
          _buildTitle(context),
          const SizedBox(height: _descriptionSpacing),
          _buildDescription(context),
        ],
      ),
    );
  }

  Widget _buildGradientIconContainer() {
    return ClipRRect(
          borderRadius: .circular(40),
          child: Container(
            width: _iconContainerSize,
            height: _iconContainerSize,
            decoration: BoxDecoration(
              gradient: LinearGradient(begin: .topLeft, end: .bottomRight, colors: data.gradient!),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: data.gradient!.first.withAlpha(80),
                  blurRadius: 40,
                  offset: const Offset(0, 20),
                ),
              ],
            ),
            child: Stack(
              children: <Widget>[
                _buildDecorativeCircle(top: 20, right: 20, size: 60),
                _buildDecorativeCircle(bottom: 30, left: 30, size: 40),
                Center(
                  child: Icon(data.icon, size: _iconSize, color: Colors.white),
                ),
              ],
            ),
          ),
        )
        .animate(onPlay: (AnimationController controller) => controller.repeat(reverse: true))
        .shimmer(
          delay: _shimmerDelay.ms,
          duration: _shimmerDuration.ms,
        )
        .animate();
  }

  Widget _buildDecorativeCircle({
    required double size,
    double? top,
    double? right,
    double? bottom,
    double? left,
  }) {
    return Positioned(
      top: top,
      right: right,
      bottom: bottom,
      left: left,
      child: Container(
        width: size,
        height: size,
        decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white10),
      ),
    );
  }

  Widget _buildImageWidget() {
    return Image.asset(data.image!, width: _imageSize, height: _imageSize)
        .animate()
        .fadeIn(delay: (index * _baseDelay).ms, duration: _fadeInDuration.ms)
        .slideY(
          begin: 0.3,
          end: 0,
          curve: Curves.easeOut,
        );
  }

  Widget _buildTitle(BuildContext context) {
    return Text(
          data.title,
          maxLines: 3,
          overflow: .ellipsis,
          textAlign: TextAlign.center,
          style: context.textTheme.displaySmall?.copyWith(
            fontWeight: FontWeight.w800,
            height: 1.2,
            letterSpacing: -1,
          ),
        )
        .animate()
        .fadeIn(delay: (index * _baseDelay + 200).ms, duration: _fadeInDuration.ms)
        .slideY(
          begin: 0.3,
          end: 0,
          curve: Curves.easeOut,
        );
  }

  Widget _buildDescription(BuildContext context) {
    return Text(
          data.description,
          textAlign: TextAlign.center,
          maxLines: 4,
          overflow: .ellipsis,
          style: context.textTheme.bodyLarge?.copyWith(
            color: context.colorScheme.onSurface.withAlpha(190),
            height: 1.6,
          ),
        )
        .animate()
        .fadeIn(delay: (index * _baseDelay + 400).ms, duration: _fadeInDuration.ms)
        .slideY(
          begin: 0.3,
          end: 0,
          curve: Curves.easeOut,
        );
  }
}
