import 'package:dio/dio.dart';
import 'package:mortygram/config/logger/my_log.dart';
import 'package:mortygram/config/typedefs/typedefs.dart';
import 'package:mortygram/core/common/constants/app_const.dart';
import 'package:mortygram/features/characters/data/dtos/character_dto.dart';
import 'package:mortygram/features/episodes/data/datasource/remote/episodes_remote_data_source.dart';

abstract interface class CharactersRemoteDataSource {
  Future<List<CharacterDto>> fetchCharacters({required int page});
}

class CharactersRemoteDataSourceImpl implements CharactersRemoteDataSource {
  const CharactersRemoteDataSourceImpl(this._dio, this._episodesRemoteDataSource);

  final Dio _dio;
  final EpisodesRemoteDataSource _episodesRemoteDataSource;

  @override
  Future<List<CharacterDto>> fetchCharacters({required int page}) async {
    final List<CharacterDto> characters = [];

    final String url = 'https://${AppConst.baseApiUrl}/${AppConst.charactersApiUrl}?page=$page';

    try {
      final Response<DataMap> response = await _dio.get<DataMap>(url);
      final List<dynamic> results = response.data?['results'] as List;
      final List<CharacterDto> characterDtos = results.map((json) => CharacterDto.fromJson(json as DataMap)).toList();

      // Fetch first episode name for each character
      for (int i = 0; i < characterDtos.length; i++) {
        final CharacterDto character = characterDtos[i];
        String? episodeName;

        if (character.episode.isNotEmpty) {
          final episodeDto = await _episodesRemoteDataSource.fetchEpisode(url: character.episode.first);
          episodeName = episodeDto?.name;
        }

        // Create a new DTO with the episode name
        characterDtos[i] = CharacterDto(
          id: character.id,
          name: character.name,
          image: character.image,
          status: character.status,
          species: character.species,
          type: character.type,
          gender: character.gender,
          episode: character.episode,
          firstEpisodeName: episodeName,
          location: character.location,
          origin: character.origin,
        );
      }

      return characterDtos;
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        myLog('Characters not found at $url', level: .error);
        return characters; // Return empty list if not found
      }
      rethrow; // Let the error interceptor handle other errors
    }
  }
}
