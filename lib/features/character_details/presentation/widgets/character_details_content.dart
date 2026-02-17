import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mortygram/core/common/extensions/context_ext.dart';
import 'package:mortygram/core/common/widgets/custom_network_image.dart';
import 'package:mortygram/features/character_details/domain/entities/character_details.dart';
import 'package:mortygram/features/character_details/presentation/widgets/character_info_item.dart';

/// Widget that displays the full character details content
class CharacterDetailsContent extends StatelessWidget {
  const CharacterDetailsContent({
    required this.characterDetails,
    super.key,
  });

  final CharacterDetails characterDetails;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: characterDetails.id,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            //  image
            Padding(
              padding: const .all(16.0),
              child: ClipRRect(
                borderRadius: .circular(16),
                child: CustomNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: characterDetails.image,
                  width: context.width,
                  height: context.width,
                ),
              ),
            ),
            const SizedBox(height: 8),
            //  name  header
            Padding(
              padding: const .symmetric(horizontal: 16),
              child: Text(
                characterDetails.name,
                style: context.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 24),
            // Character details
            CharacterInfoItem(label: 'characterDetails.status'.tr(), value: characterDetails.status, showStatusIndicator: true),
            CharacterInfoItem(label: 'characterDetails.species'.tr(), value: characterDetails.species),
            CharacterInfoItem(label: 'characterDetails.gender'.tr(), value: characterDetails.gender),
            CharacterInfoItem(label: 'characterDetails.origin'.tr(), value: characterDetails.origin.name),
            CharacterInfoItem(label: 'characterDetails.location'.tr(), value: characterDetails.location.name),
            if (characterDetails.firstEpisodeName != null) CharacterInfoItem(label: 'characterDetails.firstEpisode'.tr(), value: characterDetails.firstEpisodeName!),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
