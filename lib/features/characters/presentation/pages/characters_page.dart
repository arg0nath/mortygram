import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mortygram/core/common/widgets/custom_error_widget.dart';
import 'package:mortygram/core/common/widgets/custom_loading_indicator.dart';
import 'package:mortygram/core/routes/route_names.dart';
import 'package:mortygram/features/characters/domain/entities/character.dart';
import 'package:mortygram/features/characters/presentation/bloc/characters_bloc.dart';
import 'package:mortygram/features/characters/presentation/widgets/character_list_tile.dart';

class CharactersPage extends StatefulWidget {
  const CharactersPage({super.key});

  @override
  State<CharactersPage> createState() => _CharactersPageState();
}

class _CharactersPageState extends State<CharactersPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<CharactersBloc>().add(const FetchCharactersEvent(page: 1, keyword: null));

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {}
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Rick & Morty')),
      body: RefreshIndicator(
        onRefresh: () async => context.read<CharactersBloc>().add(const FetchCharactersEvent(page: 1, keyword: null)),
        child: BlocBuilder<CharactersBloc, CharactersState>(
          builder: (BuildContext context, CharactersState state) {
            return state.when(
              initial: () => const SizedBox.shrink(),
              loading: () => const Center(child: CustomLoadingIndicator()),
              error: (String message) => CustomErrorWidget(helpingMessage: message),
              loaded: (List<Character> characters, int currentPage, int lastPage) {
                return ListView.builder(
                  controller: _scrollController,
                  itemCount: characters.length + (currentPage < lastPage ? 1 : 0),
                  itemBuilder: (BuildContext context, int index) {
                    if (index < characters.length) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CharacterListTile(
                          character: characters[index],
                          onTap: () => context.goNamed(RouteName.characterDetailsPageName, pathParameters: <String, String>{'characterId': characters[index].id.toString()}),
                        ),
                      );
                    } else {
                      // loading indicator at bottom
                      return const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
