part of 'characters_bloc.dart';

@freezed
class CharactersState with _$CharactersState {
  const factory CharactersState.initial() = _Initial;
  const factory CharactersState.loading() = _Loading;
  const factory CharactersState.loaded(List<Character> characters) = _Loaded;
  const factory CharactersState.error(String message) = _Error;
}
