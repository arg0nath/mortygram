import 'package:dio/dio.dart';
import 'package:mortygram/config/logger/my_log.dart';
import 'package:mortygram/config/typedefs/typedefs.dart';
import 'package:mortygram/core/common/constants/app_const.dart';
import 'package:mortygram/features/characters/data/dtos/character_dto.dart';
import 'package:mortygram/features/episodes/data/datasource/remote/episodes_remote_data_source.dart';
import 'package:mortygram/features/episodes/data/dtos/episode_dto.dart';
import 'package:mortygram/features/episodes/domain/helpers/extract_episode_id.dart';
import 'package:mortygram/features/pagination/domain/entities/page_result.dart';
import 'package:mortygram/features/pagination/domain/entities/pagination_meta.dart';

abstract interface class CharactersRemoteDataSource {
  Future<PaginatedResults<CharacterDto>> fetchCharacters({
    required int page,
    required String? keyword,
    required String? genderFilter,
    required String? statusFilter,
  });
}

class CharactersRemoteDataSourceImpl implements CharactersRemoteDataSource {
  const CharactersRemoteDataSourceImpl(this._dio, this._episodesRemoteDataSource);

  final Dio _dio;
  final EpisodesRemoteDataSource _episodesRemoteDataSource;

  @override
  Future<PaginatedResults<CharacterDto>> fetchCharacters({
    required int page,
    required String? keyword,
    required String? genderFilter,
    required String? statusFilter,
  }) async {
    try {
      final Response<DataMap> response = await _dio.get<DataMap>(
        AppConst.charactersApiUrl,
        queryParameters: {
          'page': page,
          if (keyword != null && keyword.isNotEmpty) 'name': keyword.trim(),
          if (genderFilter != null && genderFilter.isNotEmpty) 'gender': genderFilter,
          if (statusFilter != null && statusFilter.isNotEmpty) 'status': statusFilter,
        },
      );

      // extract pagination info
      final DataMap infoJson = response.data?['info'] as DataMap;
      final PaginationMeta paginationMeta = PaginationMeta.fromJson(infoJson);

      // extract results
      final List<dynamic> results = response.data?['results'] as List;

      final List<CharacterDto> characterDtos = results.map((json) => CharacterDto.fromJson(json as DataMap)).toList();

      await _firstEpisodeNameLoader(characterDtos, page); // load first episode names for all characters in the page

      return PaginatedResults(
        results: characterDtos,
        info: paginationMeta,
      );
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        myLog('Characters not found', level: .error);
        return PaginatedResults(
          results: [],
          info: PaginationMeta(count: 0, pages: 0, next: null, prev: null),
        );
      }
      rethrow; // error interceptor
    }
  }

  Future<void> _firstEpisodeNameLoader(List<CharacterDto> characterDtos, int page) async {
    //  set instead of list for unique episode IDs only
    final Set<int> episodeIds = {};

    for (int i = 0; i < characterDtos.length; i++) {
      if (characterDtos[i].episode.isNotEmpty) {
        final int? episodeId = extractEpisodeId(characterDtos[i].episode.first);
        if (episodeId != null) {
          episodeIds.add(episodeId); // Set automatically handles duplicates
        }
      }
    }

    // Fetch all episodes in a single batch request
    Map<int, String> episodeIdToName = {};
    if (episodeIds.isNotEmpty) {
      final dynamic result = await _episodesRemoteDataSource.fetchEpisodes(ids: episodeIds.toList());

      if (result is List<EpisodeDto>) {
        // Multiple episodes returned
        for (final EpisodeDto episode in result) {
          episodeIdToName[episode.id] = episode.name;
        }
      } else if (result is EpisodeDto) {
        // Single episode returned
        episodeIdToName[result.id] = result.name;
      }
    }

    // Update characters with episode names and page number
    for (int i = 0; i < characterDtos.length; i++) {
      String? episodeName;

      if (characterDtos[i].episode.isNotEmpty) {
        final int? episodeId = extractEpisodeId(characterDtos[i].episode.first);
        if (episodeId != null) {
          episodeName = episodeIdToName[episodeId];
        }
      }

      characterDtos[i] = characterDtos[i].copyWith(
        firstEpisodeName: episodeName,
        page: page,
      );
    }
  }
}
