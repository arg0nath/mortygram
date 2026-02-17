import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mortygram/core/common/res/app_assets.dart';
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
            return Padding(
              padding: const .all(8.0),
              child: Hero(
                tag: 'character_image_${characters[index].id}',
                child: CharacterListTile(
                  key: ValueKey('character_${characters[index].id}'),
                  character: characters[index],
                  onTap: () => onCharacterTap(characters[index]),
                ),
              ),
            );
          }
          //loading indicator at the end of the list when loading more characters
          if (index == characters.length && isLoadingMore) {
            return const Padding(
              padding: .all(16.0),
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
        child: Column(
          spacing: 24,
          crossAxisAlignment: .center,
          mainAxisAlignment: .center,
          children: [
            LottieBuilder.asset(AppAssets.emptyListAnimation, repeat: true, height: 150, width: 150),
            const Text('No characters found.'),
          ],
        ),
      ),
    );
  }
}
