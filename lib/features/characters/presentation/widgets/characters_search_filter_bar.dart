import 'package:flutter/material.dart';
import 'package:mortygram/features/characters/domain/entities/character_search_filters.dart';
import 'package:mortygram/features/characters/presentation/widgets/filters/filters_button.dart';
import 'package:mortygram/features/characters/presentation/widgets/search_bar/search_bar_delegate.dart';
import 'package:mortygram/features/characters/presentation/widgets/search_bar/search_bar_mrt.dart';

class CharactersSearchFilterBar extends StatelessWidget {
  const CharactersSearchFilterBar({
    required this.currentFilters,
    required this.onSearchFiltersChanged,
    super.key,
  });

  final CharacterSearchFilters currentFilters;
  final void Function(CharacterSearchFilters filters) onSearchFiltersChanged;

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: SearchBarFilterDelegate(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              flex: 7,
              child: SearchBarMrt(
                onSearch: (String? query) {
                  onSearchFiltersChanged(currentFilters.copyWith(keyword: query));
                },
              ),
            ),
            Expanded(
              flex: 1,
              child: FiltersDialogButton(
                currentFilters: currentFilters,
                onFiltersChanged: onSearchFiltersChanged,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
