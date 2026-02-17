import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mortygram/config/typedefs/typedefs.dart';
import 'package:mortygram/features/characters/domain/entities/character.dart';
import 'package:mortygram/features/locations/data/dtos/location_dto.dart';
import 'package:mortygram/features/origins/data/dtos/origin_dto.dart';

part 'character_dto.freezed.dart';
part 'character_dto.g.dart';

@freezed
abstract class CharacterDto with _$CharacterDto {
  const CharacterDto._();

  const factory CharacterDto({
    required int id,
    required String name,
    required String image,
    required String status,
    required String species,
    required String type,
    required String gender,
    required List<String> episode,
    required LocationDto location,
    required OriginDto origin,
    String? firstEpisodeName,
    @Default(4) @JsonKey(includeFromJson: false, includeToJson: false) int page, // Not from API,used for local DB pagination tracking
  }) = _CharacterDto;

  factory CharacterDto.fromJson(DataMap json) => _$CharacterDtoFromJson(json);

  Character toEntity() {
    return Character(
      id: id,
      name: name,
      image: image,
      status: status,
      species: species,
      type: type,
      episode: List.from(episode),
      gender: gender,
      firstEpisodeName: firstEpisodeName,
      location: location.toEntity(),
      origin: origin.toEntity(),
    );
  }

  @override
  String toString() => 'CharacterDto(id: $id, name: $name)';
}
