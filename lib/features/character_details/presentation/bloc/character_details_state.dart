part of 'character_details_bloc.dart';

@freezed
class CharacterDetailsState with _$CharacterDetailsState {
  const factory CharacterDetailsState.initial() = _Initial;
  const factory CharacterDetailsState.loading() = _Loading;
  const factory CharacterDetailsState.loaded(CharacterDetails characterDetails) = _Loaded;
  const factory CharacterDetailsState.error(String message) = _Error;
}
