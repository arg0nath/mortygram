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
  const FetchCharactersEvent({required this.page, this.filters = const CharacterSearchFilters(), this.isRefresh});

  final int page;
  final CharacterSearchFilters filters;
  final bool? isRefresh;

  @override
  List<Object?> get props => <Object?>[page, isRefresh, filters];
}

class LoadMoreCharactersEvent extends CharactersEvent {
  const LoadMoreCharactersEvent();
}

class RefreshCharactersEvent extends CharactersEvent {
  const RefreshCharactersEvent();
}
