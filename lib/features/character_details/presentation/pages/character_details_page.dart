import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mortygram/core/common/extensions/context_ext.dart';
import 'package:mortygram/core/common/widgets/custom_loading_indicator.dart';
import 'package:mortygram/core/common/widgets/error_page.dart';
import 'package:mortygram/features/character_details/presentation/bloc/character_details_bloc.dart';
import 'package:mortygram/features/character_details/presentation/widgets/character_details_app_bar.dart';
import 'package:mortygram/features/character_details/presentation/widgets/character_details_content.dart';

class CharacterDetailsPage extends StatefulWidget {
  const CharacterDetailsPage({
    required this.characterId,

    super.key,
  });

  final int characterId;

  @override
  State<CharacterDetailsPage> createState() => _CharacterDetailsPageState();
}

class _CharacterDetailsPageState extends State<CharacterDetailsPage> {
  @override
  void initState() {
    super.initState();
    context.read<CharacterDetailsBloc>().add(FetchCharacterDetailsEvent(characterId: widget.characterId));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CharacterDetailsAppBar(),
      body: BlocConsumer<CharacterDetailsBloc, CharacterDetailsState>(
        listener: (BuildContext context, CharacterDetailsState state) {
          state.maybeWhen(
            error: (String message) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(message),
                  backgroundColor: context.colorScheme.error,
                  behavior: SnackBarBehavior.floating,
                  duration: const Duration(seconds: 3),
                ),
              );
            },
            orElse: () {},
          );
        },
        builder: (BuildContext context, CharacterDetailsState state) {
          return state.when(
            initial: () => const SizedBox.shrink(),
            loading: () => const Center(child: CustomLoadingIndicator()),
            error: (String message) => ErrorPage(
              helpingMessage: message,
              onRefresh: () async => context.read<CharacterDetailsBloc>().add(FetchCharacterDetailsEvent(characterId: widget.characterId)),
            ),
            loaded: (characterDetails) => CharacterDetailsContent(
              characterDetails: characterDetails,
            ),
          );
        },
      ),
    );
  }
}
