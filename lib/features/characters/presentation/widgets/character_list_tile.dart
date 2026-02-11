import 'package:flutter/material.dart';
import 'package:mortygram/core/common/extensions/context_ext.dart';
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
      child: ListTile(
        leading: CustomNetworkImage(imageURL: character.imageUrl, width: 30, height: 30),
        title: Row(
          children: [Text(character.name, style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600))],
        ),
      ),
    );
  }
}
