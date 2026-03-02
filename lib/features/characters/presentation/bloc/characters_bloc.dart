import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mortygram/core/common/errors/failures.dart';
import 'package:mortygram/features/characters/domain/entities/character.dart';
import 'package:mortygram/features/characters/domain/entities/character_search_filters.dart';
import 'package:mortygram/features/characters/domain/usecases/get_characters.dart';
import 'package:mortygram/features/pagination/domain/entities/page_result.dart';
import 'package:stream_transform/stream_transform.dart';

part 'characters_bloc.freezed.dart';
part 'characters_event.dart';
part 'characters_state.dart';

class CharactersBloc extends Bloc<CharactersEvent, CharactersState> {
  CharactersBloc({required GetCharacters getCharacters}) : _getCharacters = getCharacters, super(const CharactersState.initial()) {
    on<InitialCharactersEvent>(_onInitial);
    on<FetchCharactersEvent>(
      _onFetchCharactersHandler,
      transformer: (Stream<FetchCharactersEvent> events, mapper) => events.debounce(const Duration(milliseconds: 500)).switchMap(mapper), //debounce for search input
    );
    on<LoadMoreCharactersEvent>(_onLoadMoreHandler);
    on<RefreshCharactersEvent>(_onRefreshHandler);
  }

  void _onInitial(InitialCharactersEvent event, Emitter<CharactersState> emit) {
    _pageCache.clear();
    emit(const CharactersState.initial());
  }

  Future<void> _onRefreshHandler(RefreshCharactersEvent event, Emitter<CharactersState> emit) async {
    _pageCache.clear();
    state.maybeWhen(
      loaded: (_, _, _, _, _, CharacterSearchFilters activeFilters) {
        add(FetchCharactersEvent(page: 1, filters: activeFilters, isRefresh: true));
      },
      orElse: () {
        add(const FetchCharactersEvent(page: 1));
      },
    );
  }

  // fetch characters for a specific page
  Future<void> _onFetchCharactersHandler(FetchCharactersEvent event, Emitter<CharactersState> emit) async {
    final CharacterSearchFilters newFilters = event.filters;
    CharacterSearchFilters? currentFilters;

    state.maybeWhen(
      loaded: (_, _, _, _, _, CharacterSearchFilters activeFilters) {
        currentFilters = activeFilters;
      },
      orElse: () {},
    );

    final bool isNewSearch = currentFilters == null || newFilters != currentFilters; // check if filters changed

    if (isNewSearch) {
      _pageCache.clear();
    }

    // show loading state only on initial load (page 1) , for other pages, LoadMoreCharactersEvent already set isLoadingMore: true
    if (event.page == 1) {
      emit(CharactersState.loading(isSearching: newFilters.keyword != null && newFilters.keyword!.isNotEmpty, searchQuery: newFilters.keyword));
    }

    final Either<Failure, PaginatedResults<Character>> result = await _getCharacters(
      GetCharactersParams(
        page: event.page,
        isRefresh: event.isRefresh,
        filters: newFilters,
      ),
    );

    result.fold(
      //! error handling
      (Failure failure) {
        // if this is a load more error (page > 1), keep the existing characters and show error as toast
        if (event.page > 1) {
          state.maybeWhen(
            loaded: (List<Character> characters, int currentPage, int lastPage, bool isLoadingMore, _, CharacterSearchFilters activeFilters) {
              emit(
                CharactersState.loaded(
                  characters,
                  currentPage: currentPage,
                  lastPage: lastPage,
                  isLoadingMore: false,
                  loadMoreError: failure.message,
                  activeFilters: activeFilters,
                ),
              );
            },
            orElse: () {
              emit(CharactersState.error(failure.message));
            },
          );
        } else {
          emit(CharactersState.error(failure.message));
        }
      },
      // * success handling
      (PaginatedResults<Character> data) {
        // cache this page's results
        _pageCache[event.page] = data.results;

        // all characters from page 1 to current page
        final List<Character> allCharacters = <Character>[];
        for (int i = 1; i <= event.page; i++) {
          if (_pageCache.containsKey(i)) {
            allCharacters.addAll(_pageCache[i]!);
          }
        }

        emit(
          CharactersState.loaded(
            allCharacters,
            currentPage: event.page,
            lastPage: data.info.pages,
            isLoadingMore: false,
            activeFilters: newFilters,
          ),
        );
      },
    );
  }

  Future<void> _onLoadMoreHandler(LoadMoreCharactersEvent event, Emitter<CharactersState> emit) async {
    state.maybeWhen(
      loaded: (List<Character> characters, int currentPage, int lastPage, bool isLoadingMore, String? loadMoreError, CharacterSearchFilters activeFilters) {
        // prevent duplicate requests
        if (currentPage < lastPage && !isLoadingMore) {
          emit(
            CharactersState.loaded(
              characters,
              currentPage: currentPage,
              lastPage: lastPage,
              isLoadingMore: true, //  show loading more state
              activeFilters: activeFilters,
            ),
          );
          // fetch next page with current active filters
          add(FetchCharactersEvent(page: currentPage + 1, filters: activeFilters));
        }
      },
      orElse: () {},
    );
  }

  final GetCharacters _getCharacters;
  final Map<int, List<Character>> _pageCache = <int, List<Character>>{}; // to cache characters by page
}
