part of 'character_details_bloc.dart';

abstract class CharacterDetailsEvent extends Equatable {
  const CharacterDetailsEvent();

  @override
  List<Object?> get props => <Object?>[];
}

class InitialCharacterDetailsEvent extends CharacterDetailsEvent {
  const InitialCharacterDetailsEvent();
}

class FetchCharacterDetailsEvent extends CharacterDetailsEvent {
  const FetchCharacterDetailsEvent({
    required this.characterId,
  });

  final int characterId;

  @override
  List<Object?> get props => <Object?>[characterId];
}
