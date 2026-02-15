import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mortygram/config/logger/my_log.dart';
import 'package:mortygram/core/common/constants/app_const.dart';
import 'package:mortygram/core/common/extensions/context_ext.dart';
import 'package:mortygram/core/common/widgets/custom_loading_indicator.dart';
import 'package:mortygram/core/common/widgets/error_page.dart';
import 'package:mortygram/core/routes/route_names.dart';
import 'package:mortygram/features/characters/domain/entities/character.dart';
import 'package:mortygram/features/characters/domain/entities/character_search_filters.dart';
import 'package:mortygram/features/characters/presentation/bloc/characters_bloc.dart';
import 'package:mortygram/features/characters/presentation/widgets/character_sliver_list.dart';
import 'package:mortygram/features/characters/presentation/widgets/filters/filters_button.dart';
import 'package:mortygram/features/characters/presentation/widgets/scroll_to_top_button.dart';
import 'package:mortygram/features/characters/presentation/widgets/search_bar/search_bar_delegate.dart';
import 'package:mortygram/features/characters/presentation/widgets/search_bar/search_bar_mrt.dart';

class CharactersPage extends StatefulWidget {
  const CharactersPage({super.key});

  @override
  State<CharactersPage> createState() => _CharactersPageState();
}

class _CharactersPageState extends State<CharactersPage> {
  final ScrollController _scrollController = ScrollController();
  bool _isLoadingMore = false;
  bool _showScrollToTopButton = false;

  // Filter state
  CharacterSearchFilters _activeFilters = const CharacterSearchFilters();

  @override
  void initState() {
    super.initState();
    _applyFilters(); // Use unified function
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  ///  function to apply all filters and search
  void _applyFilters() {
    context.read<CharactersBloc>().add(FetchCharactersEvent(page: 1, filters: _activeFilters));
  }

  //#region //* Lazy Load Stuff
  void _onScroll() {
    //  lazy loading stuff // * No package used, just a scroll listener
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
  //#endregion

  @override
  Widget build(BuildContext context) {
    final CharactersBloc charactersBloc = context.read<CharactersBloc>();
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
              // Sync loading flag with bloc state
              state.maybeWhen(
                loaded: (_, _, _, bool isLoadingMore, String? loadMoreError, _) {
                  _isLoadingMore = isLoadingMore; // Always sync the state

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
                  SliverAppBar.medium(
                    title: const Text(AppConst.appName),
                    titleTextStyle: context.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                    scrolledUnderElevation: 0.0,
                  ),
                  //search bar + filters
                  SliverPersistentHeader(
                    pinned: true,
                    delegate: SearchBarFilterDelegate(
                      child: Row(
                        mainAxisSize: .min,
                        children: [
                          Expanded(
                            flex: 7,
                            child: SearchBarMrt(
                              onSearch: (String? query) {
                                setState(() => _activeFilters = _activeFilters.copyWith(keyword: query));
                                _applyFilters();
                              },
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: FiltersDialogButton(
                              onClearFilters: () {
                                setState(() => _activeFilters = _activeFilters.copyWith(gender: null, status: null));
                                _applyFilters();
                              },
                              onGenderFilterSelected: (String? genderFilter) {
                                myLog('Selected gender filter: $genderFilter');
                                setState(() => _activeFilters = _activeFilters.copyWith(gender: genderFilter));
                                _applyFilters();
                              },
                              onStatusFilterSelected: (String? statusFilter) {
                                myLog('Selected status filter: $statusFilter');
                                setState(() => _activeFilters = _activeFilters.copyWith(status: statusFilter));
                                _applyFilters();
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  state.when(
                    initial: () => const SliverFillRemaining(child: SizedBox.shrink()),
                    loading: (bool isSearching, String? searchQuery) => const SliverFillRemaining(child: Center(child: CustomLoadingIndicator())),
                    error: (String message) => SliverFillRemaining(
                      child: ErrorPage(
                        helpingMessage: message,
                        onRefresh: () async => charactersBloc.add(const RefreshCharactersEvent()),
                      ),
                    ),
                    loaded: (List<Character> characters, _, _, bool isLoadingMore, String? loadMoreError, _) {
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
