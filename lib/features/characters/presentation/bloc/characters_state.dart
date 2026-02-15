part of 'characters_bloc.dart';

@freezed
class CharactersState with _$CharactersState {
  const factory CharactersState.initial() = _Initial;
  const factory CharactersState.loading({@Default(false) bool isSearching, String? searchQuery}) = _Loading;
  const factory CharactersState.loaded(
    List<Character> characters, {
    required int currentPage,
    required int lastPage,
    @Default(false) bool isLoadingMore,
    String? loadMoreError,
    @Default(false) bool isSearching,
    String? searchQuery,
  }) = _Loaded;

  const factory CharactersState.error(String message) = _Error;
}
