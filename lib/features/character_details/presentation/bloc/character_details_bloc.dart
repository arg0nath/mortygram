import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mortygram/core/common/errors/failures.dart';
import 'package:mortygram/features/character_details/domain/entities/character_details.dart';
import 'package:mortygram/features/character_details/domain/usecases/get_character_details.dart';

part 'character_details_bloc.freezed.dart';
part 'character_details_event.dart';
part 'character_details_state.dart';

class CharacterDetailsBloc extends Bloc<CharacterDetailsEvent, CharacterDetailsState> {
  CharacterDetailsBloc({required GetCharacterDetails getCharacterDetails})
    : _getCharacterDetails = getCharacterDetails,
      super(
        const CharacterDetailsState.initial(),
      ) {
    on<InitialCharacterDetailsEvent>(_onInitial);
    on<FetchCharacterDetailsEvent>(_onFetchCharacterDetailsHandler);
  }

  final GetCharacterDetails _getCharacterDetails;

  void _onInitial(InitialCharacterDetailsEvent event, Emitter<CharacterDetailsState> emit) {
    emit(const CharacterDetailsState.initial());
  }

  // fetch characters for a specific page
  Future<void> _onFetchCharacterDetailsHandler(FetchCharacterDetailsEvent event, Emitter<CharacterDetailsState> emit) async {
    emit(const CharacterDetailsState.loading());

    final Either<Failure, CharacterDetails> result = await _getCharacterDetails(GetCharacterDetailsParams(characterId: event.characterId));

    result.fold(
      (Failure failure) => emit(CharacterDetailsState.error(failure.message)),
      (CharacterDetails characterDetails) => emit(CharacterDetailsState.loaded(characterDetails)),
    );
  }
}
