import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mortygram/config/typedefs/typedefs.dart';

part 'character_search_filters.freezed.dart';
part 'character_search_filters.g.dart';

@freezed
abstract class CharacterSearchFilters with _$CharacterSearchFilters {
  const CharacterSearchFilters._();

  const factory CharacterSearchFilters({
    String? keyword,
    String? gender,
    String? status,
  }) = _CharacterSearchFilters;

  factory CharacterSearchFilters.fromJson(DataMap json) => _$CharacterSearchFiltersFromJson(json);
}
