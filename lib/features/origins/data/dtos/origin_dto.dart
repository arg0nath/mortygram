import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mortygram/config/typedefs/typedefs.dart';
import 'package:mortygram/features/origins/domain/entities/origin.dart';

part 'origin_dto.freezed.dart';
part 'origin_dto.g.dart';

@freezed
abstract class OriginDto with _$OriginDto {
  const OriginDto._();

  const factory OriginDto({
    required String name,
    required String url,
  }) = _OriginDto;

  factory OriginDto.fromJson(DataMap json) => _$OriginDtoFromJson(json);

  Origin toEntity() {
    return Origin(
      name: name,
      url: url,
    );
  }
}
