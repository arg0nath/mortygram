import 'package:flutter/material.dart';

/// A floating action button that scrolls to the top of the list when pressed
class ScrollToTopButton extends StatelessWidget {
  const ScrollToTopButton({
    required this.scrollController,
    super.key,
  });

  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.small(
      onPressed: () => scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      ),
      child: const Icon(Icons.arrow_upward_rounded),
    );
  }
}
