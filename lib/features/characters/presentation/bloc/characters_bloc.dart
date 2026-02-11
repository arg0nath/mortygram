import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mortygram/core/common/errors/failures.dart';
import 'package:mortygram/features/characters/domain/entities/character.dart';
import 'package:mortygram/features/characters/domain/usecases/fetch_characters.dart';

part 'characters_bloc.freezed.dart';
part 'characters_event.dart';
part 'characters_state.dart';

class CharactersBloc extends Bloc<CharactersEvent, CharactersState> {
  CharactersBloc({required FetchCharacters fetchCharacters}) : _fetchCharacters = fetchCharacters, super(_Initial()) {
    on<InitialCharactersEvent>(_initialHomeEventHandler);
    on<FetchCharactersEvent>(_fetchCharactersEventHandler);
  }

  final FetchCharacters _fetchCharacters;
  void _initialHomeEventHandler(InitialCharactersEvent event, Emitter<CharactersState> emit) {
    emit(const CharactersState.initial());
  }

  void _fetchCharactersEventHandler(FetchCharactersEvent event, Emitter<CharactersState> emit) async {
    emit(const CharactersState.loading());
    try {
      final Either<Failure, List<Character>> result = await _fetchCharacters();
      result.fold((Failure failure) => emit(CharactersState.error(failure.errorMessage)), (List<Character> characters) => emit(CharactersState.loaded(characters)));
    } catch (e) {
      emit(CharactersState.error(e.toString()));
    }
  }
}
