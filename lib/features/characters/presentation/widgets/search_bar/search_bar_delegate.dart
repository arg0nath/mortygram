import 'package:flutter/material.dart';
import 'package:mortygram/core/common/extensions/context_ext.dart';

/// Delegate for creating a pinned search bar in the sliver scroll view
class SearchBarFilterDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  SearchBarFilterDelegate({required this.child});

  @override
  double get minExtent => 72.0;

  @override
  double get maxExtent => 72.0;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: context.theme.appBarTheme.backgroundColor,
      padding: const EdgeInsets.fromLTRB(16, 8, 8, 16),
      child: child,
    );
  }

  @override
  bool shouldRebuild(SearchBarFilterDelegate oldDelegate) {
    return false;
  }
}
