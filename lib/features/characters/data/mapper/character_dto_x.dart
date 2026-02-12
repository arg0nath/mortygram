import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:mortygram/core/database/app_database.dart';
import 'package:mortygram/features/characters/data/dtos/character_dto.dart';

/// Update CharacterDto -> Drift Mapping
extension CharacterDtoDriftMapper on CharacterDto {
  CharactersTableCompanion toCompanion() {
    return CharactersTableCompanion(
      id: Value(id),
      name: Value(name),
      image: Value(image),
      status: Value(status),
      species: Value(species),
      type: Value(type),
      gender: Value(gender),
      episode: Value(jsonEncode(episode)),
      location: Value(jsonEncode(location)),
      origin: Value(jsonEncode(origin)),
    );
  }
}

extension CharacterDriftToDto on CharactersTableData {
  CharacterDto toDto() {
    return CharacterDto(
      id: id,
      name: name,
      image: image,
      status: status,
      species: species,
      type: type,
      gender: gender,
      episode: List<String>.from(jsonDecode(episode) as List<dynamic>),
      location: List<String>.from(jsonDecode(location) as List<dynamic>),
      origin: List<String>.from(jsonDecode(origin) as List<dynamic>),
    );
  }
}
