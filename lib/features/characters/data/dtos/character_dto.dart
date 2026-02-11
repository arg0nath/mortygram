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
    required String imageUrl,
    required String status,
    required String species,
    required String type,
    required String gender,
    required List<String> episode,
  }) = _CharacterDto;

  factory CharacterDto.fromJson(DataMap json) => _$CharacterDtoFromJson(json);

  Character toEntity() {
    return Character(
      id: id,
      name: name,
      imageUrl: imageUrl,
      status: status,
      species: species,
      type: type,
      episode: List.from(episode),
      gender: gender,
    );
  }

  static CharacterDto fromEntity(Character entity) {
    return CharacterDto(
      id: entity.id,
      name: entity.name,
      imageUrl: entity.imageUrl,
      status: entity.status,
      species: entity.species,
      type: entity.type,
      episode: List.from(entity.episode),
      gender: entity.gender,
    );
  }
}
