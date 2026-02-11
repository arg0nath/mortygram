import 'package:dio/dio.dart';
import 'package:mortygram/config/logger/my_log.dart';
import 'package:mortygram/config/typedefs/typedefs.dart';
import 'package:mortygram/core/common/constants/app_const.dart';
import 'package:mortygram/features/characters/data/dtos/character_dto.dart';

abstract interface class CharactersRemoteDataSource {
  Future<List<CharacterDto>> fetchCharacters();
}

class CharactersRemoteDataSourceImpl implements CharactersRemoteDataSource {
  const CharactersRemoteDataSourceImpl(this._dio);

  final Dio _dio;

  @override
  Future<List<CharacterDto>> fetchCharacters() async {
    final List<CharacterDto> characters = [];

    await Future.delayed(const Duration(seconds: 1));

    final String url = 'https://${AppConst.baseApiUrl}/${AppConst.charactersApiUrl})}';

    try {
      final Response<DataMap> response = await _dio.get<DataMap>(url);

      if (response.data != null) {
        characters.add(CharacterDto.fromJson(response.data!));
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        myLog('Characters not found at $url', level: .error);
        return characters; // Return empty list if not found
      }
      rethrow; // Let the error interceptor handle other errors
    }

    return characters;
  }
}
