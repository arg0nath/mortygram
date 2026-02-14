import 'package:flutter/material.dart';
import 'package:mortygram/features/characters/domain/entities/character.dart';
import 'package:mortygram/features/characters/presentation/widgets/character_list_tile.dart';

class CharacterSliverList extends StatelessWidget {
  final List<Character> characters;
  final bool isLoadingMore;
  final void Function(Character character) onCharacterTap;

  const CharacterSliverList({
    required this.characters,
    required this.isLoadingMore,
    required this.onCharacterTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (characters.isEmpty) {
      return const _EmptySliverList();
    }

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          if (index < characters.length) {
            return Hero(
              tag: 'character_image_${characters[index].id}',
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CharacterListTile(
                  character: characters[index],
                  onTap: () => onCharacterTap(characters[index]),
                ),
              ),
            );
          }

          if (index == characters.length && isLoadingMore) {
            return const Padding(
              padding: EdgeInsets.all(16.0),
              child: Center(child: CircularProgressIndicator()),
            );
          }

          return const SizedBox.shrink();
        },
        childCount: characters.length + (isLoadingMore ? 1 : 0),
      ),
    );
  }
}

/// A simple widget to show when the character list is empty
///
/// Sliver so that pull-to-refresh can still be used to trigger a reload of characters
class _EmptySliverList extends StatelessWidget {
  const _EmptySliverList();

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: Center(
        child: Text('No characters found.'),
      ),
    );
  }
}
