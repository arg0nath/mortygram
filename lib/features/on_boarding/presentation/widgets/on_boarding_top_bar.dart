import 'package:flutter/material.dart';
import 'package:mortygram/core/common/extensions/context_ext.dart';

class OnBoardingTopBar extends StatelessWidget {
  const OnBoardingTopBar({required this.currentPage, required this.totalPages, required this.onSkip, super.key});

  final int currentPage;
  final int totalPages;
  final VoidCallback onSkip;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: .end,
      children: <Widget>[
        if (currentPage < totalPages - 1)
          TextButton(
            onPressed: onSkip,
            child: Text(
              'Skip',
              style: context.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600, color: context.colorScheme.onSurface.withOpacity(0.6)),
            ),
          ),
      ],
    );
  }
}
