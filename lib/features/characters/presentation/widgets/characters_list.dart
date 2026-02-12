import 'package:flutter/material.dart';
import 'package:mortygram/features/characters/domain/entities/character.dart';

class CharactersList extends StatelessWidget {
  const CharactersList({
    required this.characters,
    required this.currentPage,
    required this.lastPage,
    super.key,
  });

  final List<Character> characters;
  final int currentPage, lastPage;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: characters.length,
      itemBuilder: (BuildContext context, int index) {},
    );
  }
}
