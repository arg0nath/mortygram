import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:mortygram/config/typedefs/typedefs.dart';
import 'package:mortygram/core/database/app_database.dart';
import 'package:mortygram/features/characters/data/dtos/character_dto.dart';
import 'package:mortygram/features/locations/data/dtos/location_dto.dart';
import 'package:mortygram/features/origins/data/dtos/origin_dto.dart';

/// Update CharacterDto -> Drift Mapping
extension CharacterDtoDriftMapper on CharacterDto {
  CharactersTableCompanion toCompanion() {
    return CharactersTableCompanion(
      id: Value(id),
      page: Value(page),
      name: Value(name),
      image: Value(image),
      status: Value(status),
      species: Value(species),
      type: Value(type),
      gender: Value(gender),
      episode: Value(jsonEncode(episode)),
      firstEpisodeName: Value(firstEpisodeName),
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
      page: page,
      type: type,
      gender: gender,
      episode: List<String>.from(jsonDecode(episode) as List<dynamic>),
      firstEpisodeName: firstEpisodeName,
      location: LocationDto.fromJson(jsonDecode(location) as DataMap),
      origin: OriginDto.fromJson(jsonDecode(origin) as DataMap),
    );
  }
}
