import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mortygram/config/typedefs/typedefs.dart';
import 'package:mortygram/features/episodes/domain/entities/episode.dart';

part 'episode_dto.freezed.dart';
part 'episode_dto.g.dart';

@freezed
abstract class EpisodeDto with _$EpisodeDto {
  const EpisodeDto._();

  const factory EpisodeDto({
    required int id,
    required String name,
    required String url,
    required String episode,
  }) = _EpisodeDto;

  factory EpisodeDto.fromJson(DataMap json) => _$EpisodeDtoFromJson(json);

  Episode toEntity() {
    return Episode(
      id: id,
      name: name,
      url: url,
      episode: episode,
    );
  }

  static EpisodeDto fromEntity(Episode entity) {
    return EpisodeDto(
      id: entity.id,
      name: entity.name,
      url: entity.url,
      episode: entity.episode,
    );
  }
}
