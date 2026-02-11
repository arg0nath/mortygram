import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mortygram/core/routes/route_names.dart';
import 'package:mortygram/features/characters/domain/entities/character.dart';
import 'package:mortygram/features/characters/presentation/widgets/character_list_tile.dart';

class CharactersList extends StatelessWidget {
  const CharactersList({required this.characters, super.key});

  final List<Character> characters;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: characters.length,
      itemBuilder: (BuildContext context, int index) {
        return CharacterListTile(
          character: characters[index],
          onTap: () => context.goNamed(RouteName.characterDetailsPageName, pathParameters: <String, String>{'characterId': characters[index].id.toString()}),
        );
      },
    );
  }
}
