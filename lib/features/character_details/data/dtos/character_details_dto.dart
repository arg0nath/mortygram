import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mortygram/config/typedefs/typedefs.dart';
import 'package:mortygram/features/character_details/domain/entities/character_details.dart';
import 'package:mortygram/features/characters/domain/entities/character.dart';
import 'package:mortygram/features/locations/data/dtos/location_dto.dart';
import 'package:mortygram/features/origins/data/dtos/origin_dto.dart';

part 'character_details_dto.freezed.dart';
part 'character_details_dto.g.dart';

@freezed
abstract class CharacterDetailsDto with _$CharacterDetailsDto {
  const CharacterDetailsDto._();

  const factory CharacterDetailsDto({
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
  }) = _CharacterDetailsDto;

  factory CharacterDetailsDto.fromJson(DataMap json) => _$CharacterDetailsDtoFromJson(json);

  CharacterDetails toEntity() {
    return CharacterDetails(
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

  static CharacterDetailsDto fromEntity(Character entity) {
    return CharacterDetailsDto(
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
