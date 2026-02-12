import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mortygram/config/typedefs/typedefs.dart';
import 'package:mortygram/features/characters/domain/entities/character.dart';

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
    required List<String> location,
    required List<String> origin,
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
      location: location,
      origin: origin,
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
      location: entity.location,
      origin: entity.origin,
    );
  }
}
