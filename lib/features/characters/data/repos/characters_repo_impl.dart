import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:mortygram/config/typedefs/typedefs.dart';
import 'package:mortygram/core/common/errors/failures.dart';
import 'package:mortygram/features/characters/data/datasource/remote/characters_remote_data_source.dart';
import 'package:mortygram/features/characters/data/dtos/character_dto.dart';
import 'package:mortygram/features/characters/domain/entities/character.dart';
import 'package:mortygram/features/characters/domain/repos/characters_repo.dart';

class CharactersRepoImpl implements CharactersRepo {
  const CharactersRepoImpl(this._remoteDataSource);

  final CharactersRemoteDataSource _remoteDataSource;

  @override
  ResultFuture<List<Character>> fetchCharacters() async {
    List<Character> characters = [];
    try {
      final List<CharacterDto> result = await _remoteDataSource.fetchCharacters();

      for (final CharacterDto dto in result) {
        final Character entity = dto.toEntity();
        characters.add(entity);
      }

      return Right(characters);
    } on DioException catch (e) {
      return Left(ApiFailure(message: e.message ?? 'Unknown error', statusCode: e.response?.statusCode ?? 500));
    }
  }
}
