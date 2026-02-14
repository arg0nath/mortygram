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
    String? firstEpisodeName,
    required LocationDto location,
    required OriginDto origin,
    @Default(1) @JsonKey(includeFromJson: false, includeToJson: false) int page, // Not from API
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

  static CharacterDto fromEntity(Character entity) {
    return CharacterDto(
      id: entity.id,
      name: entity.name,
      image: entity.image,
      status: entity.status,
      species: entity.species,
      type: entity.type,
      episode: List.from(entity.episode),
      gender: entity.gender,
      firstEpisodeName: entity.firstEpisodeName,
      location: LocationDto.fromEntity(entity.location),
      origin: OriginDto.fromEntity(entity.origin),
    );
  }
}
