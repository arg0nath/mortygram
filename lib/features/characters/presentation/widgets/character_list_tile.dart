import 'package:flutter/material.dart';
import 'package:mortygram/core/common/widgets/custom_network_image.dart';
import 'package:mortygram/features/characters/domain/entities/character.dart';

class CharacterListTile extends StatelessWidget {
  const CharacterListTile({required this.character, required this.onTap, super.key});

  final Character character;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        // padding: const EdgeInsets.all(8.0),
        height: 150,
        child: Card(
          child: Row(
            children: [
              //image
              Expanded(
                flex: 33,
                child: CustomNetworkImage(imageUrl: character.image),
              ),
              //info
              Expanded(
                flex: 66,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 10, child: Text(character.name)),
                    Expanded(flex: 10, child: Text('${character.status} - ${character.species}')),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
