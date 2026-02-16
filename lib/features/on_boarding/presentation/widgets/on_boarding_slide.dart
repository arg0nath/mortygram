import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:mortygram/core/common/extensions/context_ext.dart';
import 'package:mortygram/features/on_boarding/domain/entities/on_boarding_data.dart';

class OnBoardingSlide extends StatelessWidget {
  const OnBoardingSlide({required this.data, required this.index});

  final OnBoardingData data;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const .symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: .center,
        children: <Widget>[
          // animated icon container with gradient
          if (data.icon != null && data.gradient != null)
            ClipRRect(
              borderRadius: .circular(40),
              child: Container(
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                  gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: data.gradient!), //
                  boxShadow: <BoxShadow>[BoxShadow(color: data.gradient!.first.withAlpha(80), blurRadius: 40, offset: const Offset(0, 20))],
                ),
                child: Stack(
                  children: <Widget>[
                    //bit decorative circle
                    Positioned(
                      top: 20,
                      right: 20,
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: const BoxDecoration(shape: .circle, color: Colors.white10),
                      ),
                    ),

                    //smaller decorative circle
                    Positioned(
                      bottom: 30,
                      left: 30,
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(shape: .circle, color: Colors.white10),
                      ),
                    ),
                    // Main icon
                    Center(child: Icon(data.icon, size: 100, color: Colors.white)),
                  ],
                ),
              ).animate(onPlay: (AnimationController controller) => controller.repeat(reverse: true)).shimmer(delay: 2000.ms, duration: 1800.ms).animate(),
              // .scale(delay: (index * 100).ms, duration: 600.ms, curve: Curves.elasticOut),
            )
          else if (data.image != null && data.image!.isNotEmpty)
            Image.asset(data.image!, width: 200, height: 200).animate().fadeIn(delay: (index * 100).ms, duration: 600.ms).slideY(begin: 0.3, end: 0, curve: Curves.easeOut),

          const SizedBox(height: 60),

          // title
          Text(
            data.title,
            textAlign: TextAlign.center,
            style: context.textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w800, height: 1.2, letterSpacing: -1),
          ).animate().fadeIn(delay: (index * 100 + 200).ms, duration: 600.ms).slideY(begin: 0.3, end: 0, curve: Curves.easeOut),

          const SizedBox(height: 24),

          // description
          Text(
            data.description,
            textAlign: TextAlign.center,
            style: context.textTheme.bodyLarge?.copyWith(color: context.colorScheme.onSurface.withAlpha(190), height: 1.6, fontSize: 16),
          ).animate().fadeIn(delay: (index * 100 + 400).ms, duration: 600.ms).slideY(begin: 0.3, end: 0, curve: Curves.easeOut),
        ],
      ),
    );
  }
}
