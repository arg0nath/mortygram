import 'package:flutter/material.dart';
import 'package:mortygram/core/common/extensions/context_ext.dart';

class OnBoardingButtonBar extends StatelessWidget {
  const OnBoardingButtonBar({required this.currentPage, required this.totalPages, required this.onNext, super.key});

  final int currentPage;
  final int totalPages;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onNext,
      style: FilledButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            currentPage == totalPages - 1 ? "Get Started" : "Continue",
            style: context.textTheme.titleMedium?.copyWith(color: context.colorScheme.onPrimary, fontWeight: FontWeight.w700),
          ),
          const SizedBox(width: 8),
          Icon(currentPage == totalPages - 1 ? Icons.check_rounded : Icons.arrow_forward_rounded, color: context.colorScheme.onPrimary),
        ],
      ),
    );
  }
}
