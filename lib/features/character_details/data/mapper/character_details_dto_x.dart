import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:mortygram/config/typedefs/typedefs.dart';
import 'package:mortygram/core/database/app_database.dart';
import 'package:mortygram/features/character_details/data/dtos/character_details_dto.dart';
import 'package:mortygram/features/locations/data/dtos/location_dto.dart';
import 'package:mortygram/features/origins/data/dtos/origin_dto.dart';

/// Update CharacterDto -> Drift Mapping
extension CharacterDetailsDtoDriftMapper on CharacterDetailsDto {
  CharacterDetailsTableCompanion toCompanion() {
    return CharacterDetailsTableCompanion(
      id: Value(id),
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

extension CharacterDetailsDriftToDto on CharacterDetailsTableData {
  CharacterDetailsDto toDto() {
    return CharacterDetailsDto(
      id: id,
      name: name,
      image: image,
      status: status,
      species: species,
      type: type,
      gender: gender,
      episode: List<String>.from(jsonDecode(episode) as List<dynamic>),
      firstEpisodeName: firstEpisodeName,
      location: LocationDto.fromJson(jsonDecode(location) as DataMap),
      origin: OriginDto.fromJson(jsonDecode(origin) as DataMap),
    );
  }
}
