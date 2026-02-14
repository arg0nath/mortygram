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
    required this.keyword,
  });

  final String? keyword;
  final int page;

  @override
  List<Object?> get props => <Object?>[page, keyword];
}

class LoadMoreCharactersEvent extends CharactersEvent {
  const LoadMoreCharactersEvent();
}

class RefreshCharactersEvent extends CharactersEvent {
  const RefreshCharactersEvent();
}
