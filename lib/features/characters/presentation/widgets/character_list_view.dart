import 'package:flutter/material.dart';
import 'package:mortygram/core/common/extensions/context_ext.dart';
import 'package:mortygram/features/characters/domain/entities/character.dart';
import 'package:mortygram/features/characters/presentation/widgets/character_list_tile.dart';

class CharacterListView extends StatelessWidget {
  final List<Character> characters;
  final ScrollController scrollController;
  final bool isLoadingMore;
  final void Function(Character character) onCharacterTap;

  const CharacterListView({
    required this.characters,
    required this.scrollController,
    required this.isLoadingMore,
    required this.onCharacterTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return characters.isEmpty
        ? const _EmptyListView()
        : Column(
            children: [
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: characters.length + (isLoadingMore ? 1 : 0),
                  itemBuilder: (BuildContext context, int index) {
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

                    return const SizedBox.shrink();
                  },
                ),
              ),
              if (isLoadingMore)
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Center(child: CircularProgressIndicator()),
                ),
            ],
          );
  }
}

/// A simple widget to show when the character list is empty
///
/// ListView so that pull-to-refresh can still be used to trigger a reload of characters
class _EmptyListView extends StatelessWidget {
  const _EmptyListView();

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: <Widget>[
        SizedBox(
          height: context.height * 0.7,
          child: const Center(child: Text('No characters found.')),
        ),
      ],
    );
  }
}
