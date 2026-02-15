import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mortygram/core/common/errors/failures.dart';
import 'package:mortygram/features/characters/domain/entities/character.dart';
import 'package:mortygram/features/characters/domain/usecases/get_characters.dart';
import 'package:mortygram/features/pagination/domain/entities/page_result.dart';

part 'characters_bloc.freezed.dart';
part 'characters_event.dart';
part 'characters_state.dart';

class CharactersBloc extends Bloc<CharactersEvent, CharactersState> {
  CharactersBloc({required GetCharacters getCharacters}) : _getCharacters = getCharacters, super(const CharactersState.initial()) {
    on<InitialCharactersEvent>(_onInitial);
    on<FetchCharactersEvent>(_onFetchCharactersHandler);
    on<LoadMoreCharactersEvent>(_onLoadMoreHandler);
    on<RefreshCharactersEvent>(_onRefreshHandler);
  }

  void _onInitial(InitialCharactersEvent event, Emitter<CharactersState> emit) {
    _pageCache.clear();
    _currentSearchQuery = null;
    _currentGenderFilter = null;
    _currentStatusFilter = null;
    emit(const CharactersState.initial());
  }

  Future<void> _onRefreshHandler(RefreshCharactersEvent event, Emitter<CharactersState> emit) async {
    _pageCache.clear();
    add(FetchCharactersEvent(page: 1, keyword: _currentSearchQuery, genderFilter: _currentGenderFilter, statusFilter: _currentStatusFilter));
  }

  // fetch characters for a specific page
  Future<void> _onFetchCharactersHandler(FetchCharactersEvent event, Emitter<CharactersState> emit) async {
    // update current search query/filters and clear cache if any changed
    final bool isNewSearch = event.keyword != _currentSearchQuery || event.genderFilter != _currentGenderFilter || event.statusFilter != _currentStatusFilter;

    if (isNewSearch) {
      _currentSearchQuery = event.keyword;
      _currentGenderFilter = event.genderFilter;
      _currentStatusFilter = event.statusFilter;
      _pageCache.clear();
    }

    final bool isSearching = event.keyword != null && event.keyword!.isNotEmpty;

    // show loading state only on initial load (page 1) , for other pages, LoadMoreCharactersEvent already set isLoadingMore: true
    if (event.page == 1) {
      emit(CharactersState.loading(isSearching: isSearching, searchQuery: event.keyword));
    }

    final Either<Failure, PaginatedResults<Character>> result = await _getCharacters(
      GetCharactersParams(
        page: event.page,
        keyword: event.keyword,
        genderFilter: event.genderFilter,
        statusFilter: event.statusFilter,
      ),
    );

    result.fold(
      (Failure failure) {
        // if this is a load more error (page > 1), keep the existing characters and show error as toast
        if (event.page > 1) {
          state.maybeWhen(
            loaded: (List<Character> characters, int currentPage, int lastPage, bool isLoadingMore, _, bool isSearching, String? searchQuery) {
              emit(
                CharactersState.loaded(
                  characters,
                  currentPage: currentPage,
                  lastPage: lastPage,
                  isLoadingMore: false,
                  loadMoreError: failure.message,
                  isSearching: isSearching,
                  searchQuery: searchQuery,
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
            isSearching: isSearching,
            searchQuery: event.keyword,
          ),
        );
      },
    );
  }

  Future<void> _onLoadMoreHandler(LoadMoreCharactersEvent event, Emitter<CharactersState> emit) async {
    state.maybeWhen(
      loaded: (List<Character> characters, int currentPage, int lastPage, bool isLoadingMore, String? loadMoreError, bool isSearching, String? searchQuery) {
        // prevent duplicate requests
        if (currentPage < lastPage && !isLoadingMore) {
          emit(
            CharactersState.loaded(
              characters,
              currentPage: currentPage,
              lastPage: lastPage,
              isLoadingMore: true, //  show loading more state
              isSearching: isSearching,
              searchQuery: searchQuery,
            ),
          );
          // fetch next page
          add(FetchCharactersEvent(page: currentPage + 1, keyword: _currentSearchQuery, genderFilter: _currentGenderFilter, statusFilter: _currentStatusFilter));
        }
      },
      orElse: () {},
    );
  }

  final GetCharacters _getCharacters;
  final Map<int, List<Character>> _pageCache = <int, List<Character>>{}; // to cache characters by page
  String? _currentSearchQuery;
  String? _currentStatusFilter;
  String? _currentGenderFilter;
}
