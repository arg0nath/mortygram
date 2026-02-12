import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mortygram/config/typedefs/typedefs.dart';
import 'package:mortygram/features/locations/domain/entities/location.dart';

part 'location_dto.freezed.dart';
part 'location_dto.g.dart';

@freezed
abstract class LocationDto with _$LocationDto {
  const LocationDto._();

  const factory LocationDto({
    required String name,
    required String url,
  }) = _LocationDto;

  factory LocationDto.fromJson(DataMap json) => _$LocationDtoFromJson(json);

  Location toEntity() {
    return Location(
      name: name,
      url: url,
    );
  }

  static LocationDto fromEntity(Location entity) {
    return LocationDto(
      name: entity.name,
      url: entity.url,
    );
  }
}
