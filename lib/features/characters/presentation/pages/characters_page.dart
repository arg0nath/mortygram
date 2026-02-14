import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mortygram/core/common/extensions/context_ext.dart';
import 'package:mortygram/core/common/widgets/custom_loading_indicator.dart';
import 'package:mortygram/core/common/widgets/error_page.dart';
import 'package:mortygram/core/routes/route_names.dart';
import 'package:mortygram/features/characters/domain/entities/character.dart';
import 'package:mortygram/features/characters/presentation/bloc/characters_bloc.dart';
import 'package:mortygram/features/characters/presentation/widgets/character_sliver_list.dart';
import 'package:mortygram/features/characters/presentation/widgets/scroll_to_top_button.dart';
import 'package:mortygram/features/characters/presentation/widgets/search_bar_mrt.dart';

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
    final CharactersBloc charactersBloc = context.watch<CharactersBloc>();
    return SafeArea(
      child: Scaffold(
        floatingActionButton: _showScrollToTopButton ? ScrollToTopButton(scrollController: _scrollController) : null,
        body: RefreshIndicator(
          onRefresh: () async {
            charactersBloc.add(const RefreshCharactersEvent());
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
                      SnackBar(content: Text(loadMoreError), backgroundColor: context.colorScheme.error, behavior: SnackBarBehavior.floating, duration: const Duration(seconds: 3)),
                    );
                  }
                },
                orElse: () {},
              );
            },
            builder: (BuildContext context, CharactersState state) {
              return CustomScrollView(
                controller: _scrollController,
                slivers: [
                  SliverAppBar(
                    scrolledUnderElevation: 0.0,
                    floating: true,
                    snap: true,
                    title: Text('Mortygram', style: context.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
                  ),
                  //search bar
                  SliverPersistentHeader(
                    pinned: true,
                    delegate: _SearchBarDelegate(
                      child: SearchBarMrt(
                        onSearch: (String? query) => charactersBloc.add(FetchCharactersEvent(page: 1, keyword: query)),
                      ),
                    ),
                  ),
                  state.when(
                    initial: () => const SliverFillRemaining(child: SizedBox.shrink()),
                    loading: () => const SliverFillRemaining(child: Center(child: CustomLoadingIndicator())),
                    searching: () => const SliverFillRemaining(child: Center(child: CustomLoadingIndicator())),
                    error: (String message) => SliverFillRemaining(child: ErrorPage(helpingMessage: message)),
                    searched: (List<Character> characters, _, _, bool isLoadingMore, String? loadMoreError) {
                      return CharacterSliverList(
                        characters: characters,
                        isLoadingMore: isLoadingMore,
                        onCharacterTap: (Character character) => context.goNamed(
                          RouteName.characterDetailsPageName,
                          pathParameters: <String, String>{'characterId': character.id.toString()},
                        ),
                      );
                    },
                    loaded: (List<Character> characters, _, _, bool isLoadingMore, String? loadMoreError) {
                      return CharacterSliverList(
                        characters: characters,
                        isLoadingMore: isLoadingMore,
                        onCharacterTap: (Character character) => context.goNamed(
                          RouteName.characterDetailsPageName,
                          pathParameters: <String, String>{'characterId': character.id.toString()},
                        ),
                      );
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

/// Delegate for creating a pinned search bar in the sliver scroll view
class _SearchBarDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  _SearchBarDelegate({required this.child});

  @override
  double get minExtent => 72.0;

  @override
  double get maxExtent => 72.0;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: context.theme.appBarTheme.backgroundColor,
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      child: child,
    );
  }

  @override
  bool shouldRebuild(_SearchBarDelegate oldDelegate) {
    return false;
  }
}
