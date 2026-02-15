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
    required this.statusFilter,
    required this.genderFilter,
  });

  final int page;
  final String? keyword, statusFilter, genderFilter;

  @override
  List<Object?> get props => <Object?>[page, keyword, genderFilter, statusFilter];
}

class LoadMoreCharactersEvent extends CharactersEvent {
  const LoadMoreCharactersEvent();
}

class RefreshCharactersEvent extends CharactersEvent {
  const RefreshCharactersEvent();
}
