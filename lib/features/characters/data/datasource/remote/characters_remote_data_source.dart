import 'package:dio/dio.dart';
import 'package:mortygram/config/logger/my_log.dart';
import 'package:mortygram/config/typedefs/typedefs.dart';
import 'package:mortygram/core/common/constants/app_const.dart';
import 'package:mortygram/features/characters/data/dtos/character_dto.dart';

abstract interface class CharactersRemoteDataSource {
  Future<List<CharacterDto>> fetchCharacters({required int page});
}

class CharactersRemoteDataSourceImpl implements CharactersRemoteDataSource {
  const CharactersRemoteDataSourceImpl(this._dio);

  final Dio _dio;

  @override
  Future<List<CharacterDto>> fetchCharacters({required int page}) async {
    final List<CharacterDto> characters = [];

    final String url = 'https://${AppConst.baseApiUrl}/${AppConst.charactersApiUrl}?page=$page';

    try {
      final Response<DataMap> response = await _dio.get<DataMap>(url);
      final List<dynamic> results = response.data?['results'] as List;
      return results.map((json) => CharacterDto.fromJson(json as DataMap)).toList();
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        myLog('Characters not found at $url', level: .error);
        return characters; // Return empty list if not found
      }
      rethrow; // Let the error interceptor handle other errors
    }
  }
}
