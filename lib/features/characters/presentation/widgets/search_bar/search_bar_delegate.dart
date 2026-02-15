import 'package:flutter/material.dart';
import 'package:mortygram/core/common/extensions/context_ext.dart';

/// Delegate for creating a pinned search bar in the sliver scroll view
class SearchBarDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  SearchBarDelegate({required this.child});

  @override
  double get minExtent => 72.0;

  @override
  double get maxExtent => 72.0;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: context.theme.appBarTheme.backgroundColor,
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      child: child,
    );
  }

  @override
  bool shouldRebuild(SearchBarDelegate oldDelegate) {
    return false;
  }
}
