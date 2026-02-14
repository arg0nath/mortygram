import 'package:dio/dio.dart';
import 'package:mortygram/config/logger/my_log.dart';
import 'package:mortygram/config/typedefs/typedefs.dart';
import 'package:mortygram/core/common/constants/app_const.dart';
import 'package:mortygram/features/characters/data/dtos/character_dto.dart';
import 'package:mortygram/features/episodes/data/datasource/remote/episodes_remote_data_source.dart';
import 'package:mortygram/features/episodes/data/dtos/episode_dto.dart';
import 'package:mortygram/features/pagination/domain/entities/page_result.dart';
import 'package:mortygram/features/pagination/domain/entities/pagination_meta.dart';

abstract interface class CharactersRemoteDataSource {
  Future<PaginatedResults<CharacterDto>> fetchCharacters({required int page});
}

class CharactersRemoteDataSourceImpl implements CharactersRemoteDataSource {
  const CharactersRemoteDataSourceImpl(this._dio, this._episodesRemoteDataSource);

  final Dio _dio;
  final EpisodesRemoteDataSource _episodesRemoteDataSource;

  @override
  Future<PaginatedResults<CharacterDto>> fetchCharacters({required int page}) async {
    final String url = 'https://${AppConst.baseApiUrl}/${AppConst.charactersApiUrl}?page=$page';

    try {
      final Response<DataMap> response = await _dio.get<DataMap>(url);

      // extract pagination info
      final DataMap infoJson = response.data?['info'] as DataMap;
      final PaginationMeta paginationMeta = PaginationMeta.fromJson(infoJson);

      // Extract results
      final List<dynamic> results = response.data?['results'] as List;
      final List<CharacterDto> characterDtos = results.map((json) => CharacterDto.fromJson(json as DataMap)).toList();

      // fetch first episode name for each character
      for (int i = 0; i < characterDtos.length; i++) {
        final CharacterDto character = characterDtos[i];
        String? episodeName;

        if (character.episode.isNotEmpty) {
          final EpisodeDto? episodeDto = await _episodesRemoteDataSource.fetchEpisode(url: character.episode.first);
          episodeName = episodeDto?.name;
        }

        // new DTO with the episode name and page number
        characterDtos[i] = character.copyWith(
          firstEpisodeName: episodeName,
          page: page,
        );
      }

      return PaginatedResults(
        results: characterDtos,
        info: paginationMeta,
      );
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        myLog('Characters not found at $url', level: .error);
        return PaginatedResults(
          results: [],
          info: PaginationMeta(count: 0, pages: 0, next: null, prev: null),
        );
      }
      rethrow; // error interceptor
    }
  }
}
