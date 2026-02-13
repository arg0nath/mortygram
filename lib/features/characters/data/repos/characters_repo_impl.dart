// ignore_for_file: always_specify_types

import 'package:dartz/dartz.dart';
import 'package:mortygram/config/typedefs/typedefs.dart';
import 'package:mortygram/core/common/constants/app_const.dart';
import 'package:mortygram/core/common/errors/exceptions.dart';
import 'package:mortygram/core/common/errors/failures.dart';
import 'package:mortygram/features/characters/data/datasource/local/characters_local_data_source.dart';
import 'package:mortygram/features/characters/data/datasource/remote/characters_remote_data_source.dart';
import 'package:mortygram/features/characters/data/dtos/character_dto.dart';
import 'package:mortygram/features/characters/domain/entities/character.dart';
import 'package:mortygram/features/characters/domain/repos/characters_repo.dart';
import 'package:mortygram/features/pagination/domain/entities/page_result.dart';
import 'package:mortygram/features/pagination/domain/entities/pagination_meta.dart';

class CharactersRepoImpl implements CharactersRepo {
  const CharactersRepoImpl(
    this._remote,
    this._local,
  );

  final CharactersRemoteDataSource _remote;
  final CharactersLocalDataSource _local;

  @override
  ResultFuture<PaginatedResults<Character>> getCharacters({required int page, String? keyword}) async {
    // try to get from local DB
    final List<CharacterDto> localCharacters = await _local.getCharacters(page);
    final PaginationMeta? localMeta = await _local.getPaginationMeta(AppConst.charactersApiUrl, page);

    // ff cached data exists
    if (localCharacters.isNotEmpty && localMeta != null) {
      final List<Character> characters = localCharacters.map((CharacterDto e) => e.toEntity()).toList();
      return Right(PaginatedResults(results: characters, info: localMeta));
    }

    //not cached - fetch from API
    try {
      final PaginatedResults<CharacterDto> remoteResult = await _remote.fetchCharacters(page: page);

      // Cache  characters and pagination metadata
      await _local.cacheCharacters(remoteResult.results);
      await _local.cachePaginationMeta(AppConst.charactersApiUrl, page, remoteResult.info);

      final List<Character> characters = remoteResult.results.map((CharacterDto e) => e.toEntity()).toList();
      return Right(PaginatedResults(results: characters, info: remoteResult.info));
    } on ApiException catch (e) {
      return Left(ApiFailure.fromException(e));
    } catch (e) {
      return Left(ApiFailure(message: e.toString(), statusCode: 500));
    }
  }
}
