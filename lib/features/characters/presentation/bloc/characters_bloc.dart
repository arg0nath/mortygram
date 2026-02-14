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

  final GetCharacters _getCharacters;
  final Map<int, List<Character>> _pageCache = <int, List<Character>>{}; // Cache characters by page

  void _onInitial(InitialCharactersEvent event, Emitter<CharactersState> emit) {
    _pageCache.clear();
    emit(const CharactersState.initial());
  }

  Future<void> _onRefreshHandler(RefreshCharactersEvent event, Emitter<CharactersState> emit) async {
    _pageCache.clear();
    add(const FetchCharactersEvent(page: 1, keyword: null));
  }

  //fetch next page
  Future<void> _onLoadMoreHandler(LoadMoreCharactersEvent event, Emitter<CharactersState> emit) async {
    state.maybeWhen(
      loaded: (List<Character> characters, int currentPage, int lastPage, bool isLoadingMore, String? loadMoreError) {
        // prevent duplicate requests
        if (currentPage < lastPage && !isLoadingMore) {
          //  show loading more state
          emit(
            CharactersState.loaded(
              characters,
              currentPage: currentPage,
              lastPage: lastPage,
              isLoadingMore: true,
            ),
          );
          // fetch next page
          add(FetchCharactersEvent(page: currentPage + 1, keyword: null));
        }
      },
      orElse: () {},
    );
  }

  // fetch characters for a specific page
  Future<void> _onFetchCharactersHandler(FetchCharactersEvent event, Emitter<CharactersState> emit) async {
    // Show loading state only on initial load (page 1)
    // For other pages, LoadMoreCharactersEvent already set isLoadingMore: true
    if (event.page == 1) {
      emit(const CharactersState.loading());
    }

    final Either<Failure, PaginatedResults<Character>> result = await _getCharacters(PaginatedGetCharactersParams(page: event.page, keyword: event.keyword));

    result.fold(
      (Failure failure) {
        // if this is a load more error (page > 1), keep the existing characters and show error as toast
        if (event.page > 1) {
          state.maybeWhen(
            loaded: (List<Character> characters, int currentPage, int lastPage, bool isLoadingMore, _) {
              emit(
                CharactersState.loaded(
                  characters,
                  currentPage: currentPage,
                  lastPage: lastPage,
                  isLoadingMore: false,
                  loadMoreError: failure.message,
                ),
              );
            },
            orElse: () {
              // fallback
              emit(CharactersState.error(failure.message));
            },
          );
        } else {
          // Initial load error: show error page
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
          ),
        );
      },
    );
  }
}
