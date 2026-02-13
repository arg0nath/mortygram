import 'package:flutter/material.dart';
import 'package:mortygram/core/common/extensions/context_ext.dart';
import 'package:mortygram/core/common/widgets/custom_network_image.dart';
import 'package:mortygram/features/characters/domain/entities/character.dart';
import 'package:mortygram/features/characters/presentation/widgets/character_info_field.dart';
import 'package:mortygram/features/characters/presentation/widgets/status_indicator.dart';

class CharacterListTile extends StatelessWidget {
  const CharacterListTile({required this.character, required this.onTap, super.key});

  final Character character;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: .circular(8),
      child: Container(
        height: 150,
        decoration: BoxDecoration(
          color: context.colorScheme.surfaceBright,
          borderRadius: .circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Character Image
            Expanded(
              flex: 44,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                ),
                child: CustomNetworkImage(imageUrl: character.image),
              ),
            ),

            // Character Info
            Expanded(
              flex: 66,
              child: Padding(
                padding: const .all(8.0),
                child: Column(
                  mainAxisAlignment: .spaceEvenly,
                  crossAxisAlignment: .start,
                  children: [
                    // Name
                    Text(
                      character.name,
                      maxLines: 2,
                      overflow: .ellipsis,
                      style: context.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    // Status and Species
                    Row(
                      spacing: 4,
                      children: [
                        StatusIndicator(status: character.status),
                        Text(
                          '${character.status} - ${character.species}',
                          style: context.textTheme.labelSmall,
                        ),
                      ],
                    ),

                    // Last Known Location
                    CharacterInfoField(
                      title: 'Last known location:',
                      value: character.location.name,
                    ),

                    // First Seen In
                    CharacterInfoField(
                      title: 'First seen in:',
                      value: character.firstEpisodeName ?? 'Unknown',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
