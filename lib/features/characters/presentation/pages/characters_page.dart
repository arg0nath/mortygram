import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mortygram/core/common/widgets/custom_error_widget.dart';
import 'package:mortygram/core/common/widgets/custom_loading_indicator.dart';
import 'package:mortygram/core/common/widgets/message_toast.dart';
import 'package:mortygram/features/characters/domain/entities/character.dart';
import 'package:mortygram/features/characters/presentation/bloc/characters_bloc.dart';
import 'package:mortygram/features/characters/presentation/widgets/characters_list.dart';

class CharactersPage extends StatefulWidget {
  const CharactersPage({super.key});

  @override
  State<CharactersPage> createState() => _CharactersPageState();
}

class _CharactersPageState extends State<CharactersPage> {
  late CharactersBloc charactersBloc;

  @override
  void initState() {
    super.initState();
    context.read<CharactersBloc>().add(FetchCharactersEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),

      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async => context.read<CharactersBloc>().add(FetchCharactersEvent()),
          child: BlocConsumer<CharactersBloc, CharactersState>(
            listener: (BuildContext context, CharactersState state) {
              state.maybeWhen(
                error: (String message) {
                  showCustomToast(context, message);
                },
                orElse: () {},
              );
            },

            builder: (BuildContext context, CharactersState state) {
              return state.when(
                initial: () => const SizedBox.shrink(),
                loading: () => const Center(child: CustomLoadingIndicator()),
                error: (String message) => CustomErrorWidget(helpingMessage: message),
                loaded: (List<Character> characters) => CharactersList(characters: characters),
              );
            },
          ),
        ),
      ),
    );
  }
}
