import 'package:dio/dio.dart';
import 'package:mortygram/config/logger/my_log.dart';
import 'package:mortygram/config/typedefs/typedefs.dart';
import 'package:mortygram/core/common/constants/app_const.dart';
import 'package:mortygram/features/character_details/data/dtos/character_details_dto.dart';
import 'package:mortygram/features/episodes/data/datasource/remote/episodes_remote_data_source.dart';
import 'package:mortygram/features/episodes/data/dtos/episode_dto.dart';
import 'package:mortygram/features/episodes/domain/helpers/extract_episode_id.dart';

abstract interface class CharacterDetailsRemoteDataSource {
  Future<CharacterDetailsDto> fetchCharacterDetails({required int characterId});
}

class CharacterDetailsRemoteDataSourceImpl implements CharacterDetailsRemoteDataSource {
  const CharacterDetailsRemoteDataSourceImpl(this._dio, this._episodesRemoteDataSource);

  final Dio _dio;
  final EpisodesRemoteDataSource _episodesRemoteDataSource;

  @override
  Future<CharacterDetailsDto> fetchCharacterDetails({required int characterId}) async {
    final String url = '${AppConst.characterDetailsApiUrl}/$characterId';

    try {
      final Response<DataMap> response = await _dio.get<DataMap>(url);

      // Extract results
      if (response.data == null) {
        throw DioException(
          requestOptions: RequestOptions(path: url),
          message: 'No data received',
        );
      }
      CharacterDetailsDto characterDetailsDto = CharacterDetailsDto.fromJson(response.data!);

      // first episode name

      String? episodeName;
      if (characterDetailsDto.episode.isNotEmpty) {
        final int? episodeId = extractEpisodeId(characterDetailsDto.episode.first);
        if (episodeId != null) {
          final dynamic result = await _episodesRemoteDataSource.fetchEpisodes(ids: [episodeId]);
          if (result is EpisodeDto) {
            episodeName = result.name;
          }
        }
      }

      // new DTO with the episode name
      characterDetailsDto = characterDetailsDto.copyWith(firstEpisodeName: episodeName);

      return characterDetailsDto;
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        myLog('Character not found at $url', level: .error);
      }
      rethrow; // error interceptor
    }
  }
}
