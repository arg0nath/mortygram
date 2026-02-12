import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mortygram/features/characters/domain/entities/character.dart';
import 'package:mortygram/features/characters/domain/usecases/watch_characters.dart';
import 'package:mortygram/features/pagination/domain/entities/page_result.dart';

part 'characters_bloc.freezed.dart';
part 'characters_event.dart';
part 'characters_state.dart';

class CharactersBloc extends Bloc<CharactersEvent, CharactersState> {
  CharactersBloc({required WatchCharacters watchCharacters}) : _watchCharacters = watchCharacters, super(const CharactersState.initial()) {
    on<InitialCharactersEvent>(_onInitial);
    on<FetchCharactersEvent>(_onFetchCharacters);
  }

  final WatchCharacters _watchCharacters;

  // Initial event: just emit initial state
  void _onInitial(InitialCharactersEvent event, Emitter<CharactersState> emit) {
    emit(const CharactersState.initial());
  }

  // Fetch/Watch characters
  Future<void> _onFetchCharacters(FetchCharactersEvent event, Emitter<CharactersState> emit) async {
    emit(const CharactersState.loading());

    await emit.forEach<PaginatedResults<Character>>(
      _watchCharacters(
        PaginatedWatchCharactersParams(page: event.page, keyword: event.keyword),
      ),
      onData: (PaginatedResults<Character> data) {
        return CharactersState.loaded(
          data.items,
          currentPage: data.currentPage,
          lastPage: data.lastPage,
        );
      },
      onError: (error, stackTrace) {
        return CharactersState.error(error.toString());
      },
    );
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
