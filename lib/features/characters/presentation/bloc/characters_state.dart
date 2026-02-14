part of 'characters_bloc.dart';

@freezed
class CharactersState with _$CharactersState {
  const factory CharactersState.initial() = _Initial;
  const factory CharactersState.loading() = _Loading;
  const factory CharactersState.loaded(
    List<Character> characters, {
    required int currentPage,
    required int lastPage,
    @Default(false) bool isLoadingMore,
    String? loadMoreError,
  }) = _Loaded;

  const factory CharactersState.searching() = _Searching;
  const factory CharactersState.searched(
    List<Character> characters, {
    required int currentPage,
    required int lastPage,
    @Default(false) bool isLoadingMore,
    String? loadMoreError,
  }) = _Searched;

  const factory CharactersState.error(String message) = _Error;
}
