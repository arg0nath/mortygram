import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mortygram/core/common/extensions/context_ext.dart';
import 'package:mortygram/core/common/widgets/custom_loading_indicator.dart';
import 'package:mortygram/core/common/widgets/error_page.dart';
import 'package:mortygram/core/routes/route_names.dart';
import 'package:mortygram/features/characters/domain/entities/character.dart';
import 'package:mortygram/features/characters/presentation/bloc/characters_bloc.dart';
import 'package:mortygram/features/characters/presentation/widgets/character_list_view.dart';

class CharactersPage extends StatefulWidget {
  const CharactersPage({super.key});

  @override
  State<CharactersPage> createState() => _CharactersPageState();
}

class _CharactersPageState extends State<CharactersPage> {
  final ScrollController _scrollController = ScrollController();
  bool _isLoadingMore = false;
  bool _showScrollToTopButton = false;

  @override
  void initState() {
    super.initState();
    context.read<CharactersBloc>().add(const FetchCharactersEvent(page: 1, keyword: null)); //init load
    _scrollController.addListener(_onScroll); //listein to scroll changes
  }

  void _onScroll() {
    //  lazy loading stuff
    if (_isNearBottom && !_isLoadingMore) {
      _isLoadingMore = true;
      context.read<CharactersBloc>().add(const LoadMoreCharactersEvent());
    }

    //scroll-to-top button visibility
    final bool _shouldShowFab = _scrollController.offset > 200;
    if (_shouldShowFab != _showScrollToTopButton) {
      setState(() {
        _showScrollToTopButton = _shouldShowFab;
      });
    }
  }

  bool get _isNearBottom {
    if (!_scrollController.hasClients) return false;
    final double maxScroll = _scrollController.position.maxScrollExtent;
    final double currentScroll = _scrollController.position.pixels;
    return currentScroll >= (maxScroll - 200);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mortygram', style: context.textTheme.headlineSmall?.copyWith(fontWeight: .bold)),
      ),
      floatingActionButton: _showScrollToTopButton
          ? FloatingActionButton.small(
              onPressed: () => _scrollController.animateTo(0, duration: const Duration(milliseconds: 500), curve: Curves.easeInOut),
              child: const Icon(Icons.arrow_upward_rounded),
            )
          : null,
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<CharactersBloc>().add(const RefreshCharactersEvent());
          await Future<void>.delayed(const Duration(milliseconds: 500));
        },
        child: BlocConsumer<CharactersBloc, CharactersState>(
          listener: (BuildContext context, CharactersState state) {
            // reset loading flag when data is loaded
            state.maybeWhen(
              loaded: (_, _, _, bool isLoadingMore, String? loadMoreError) {
                if (!isLoadingMore) {
                  _isLoadingMore = false;
                }

                // Show SnackBar if there's a load more error
                if (loadMoreError != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(loadMoreError),
                      backgroundColor: context.colorScheme.error,
                      behavior: SnackBarBehavior.floating,
                      duration: const Duration(seconds: 3),
                    ),
                  );
                }
              },
              orElse: () {},
            );
          },

          builder: (BuildContext context, CharactersState state) {
            return state.when(
              initial: () => const SizedBox.shrink(),
              loading: () => const Center(child: CustomLoadingIndicator()),
              error: (String message) => ErrorPage(helpingMessage: message),
              loaded: (List<Character> characters, _, _, bool isLoadingMore, String? loadMoreError) {
                return characters.isEmpty
                    ? _EmptyListView()
                    : CharacterListView(
                        characters: characters,
                        scrollController: _scrollController,
                        isLoadingMore: isLoadingMore,
                        onCharacterTap: (Character character) => context.goNamed(
                          RouteName.characterDetailsPageName,
                          pathParameters: <String, String>{'characterId': character.id.toString()},
                        ),
                      );
              },
            );
          },
        ),
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
