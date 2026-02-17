part of 'characters_bloc.dart';

abstract class CharactersEvent extends Equatable {
  const CharactersEvent();

  @override
  List<Object?> get props => <Object?>[];
}

class InitialCharactersEvent extends CharactersEvent {
  const InitialCharactersEvent();
}

class FetchCharactersEvent extends CharactersEvent {
  const FetchCharactersEvent({
    required this.page,
    this.filters = const CharacterSearchFilters(),
  });

  final int page;
  final CharacterSearchFilters filters;

  @override
  List<Object?> get props => <Object?>[page, filters];
}

class LoadMoreCharactersEvent extends CharactersEvent {
  const LoadMoreCharactersEvent();
}

class RefreshCharactersEvent extends CharactersEvent {
  const RefreshCharactersEvent();
}
