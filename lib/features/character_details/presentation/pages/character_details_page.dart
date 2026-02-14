import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mortygram/core/common/extensions/context_ext.dart';
import 'package:mortygram/core/common/widgets/custom_loading_indicator.dart';
import 'package:mortygram/core/common/widgets/custom_network_image.dart';
import 'package:mortygram/core/common/widgets/error_page.dart';
import 'package:mortygram/features/character_details/domain/entities/character_details.dart';
import 'package:mortygram/features/character_details/presentation/bloc/character_details_bloc.dart';

class CharacterDetailsPage extends StatefulWidget {
  const CharacterDetailsPage({required this.characterId, super.key});

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
      appBar: AppBar(),

      body: BlocConsumer<CharacterDetailsBloc, CharacterDetailsState>(
        listener: (BuildContext context, CharacterDetailsState state) {
          // reset loading flag when data is loaded
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
            error: (String message) => ErrorPage(helpingMessage: message),
            loaded: (CharacterDetails characterDetails) {
              return Hero(
                tag: characterDetails.id,
                child: Column(
                  children: [
                    CustomNetworkImage(imageUrl: characterDetails.image, width: double.infinity, height: 300),
                    const SizedBox(height: 16),
                    Text(characterDetails.name),
                    Text(characterDetails.status),
                    Text(characterDetails.species),
                  ],
                ),
              );
            },
          );
        },
      ),
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
